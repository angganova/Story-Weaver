// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:screenshot/screenshot.dart';
import 'package:story_weaver/app/components/app_bar/default_app_bar.dart';
import 'package:story_weaver/app/components/button/icon_button.dart';
import 'package:story_weaver/app/components/global/watermark_view.dart';
import 'package:story_weaver/app/components/loading/basic_loading.dart';
import 'package:story_weaver/data/model/story/story_breakdown_model.dart';
import 'package:story_weaver/system/extension/list_extension.dart';
import 'package:story_weaver/system/extension/string_extension.dart';
import 'package:story_weaver/system/global_style.dart';
import 'package:story_weaver/system/popup/dialog.dart';
import 'package:story_weaver/system/popup/toast.dart';
import 'package:story_weaver/system/routes/routes_map.dart';
import 'package:story_weaver/system/service/ai_service.dart';
import 'package:story_weaver/system/service/bug_tracker.dart';
import 'package:story_weaver/system/service/internal/story_file_management.dart';
import 'package:story_weaver/system/service/navigator.dart';
import 'package:story_weaver/system/variables/durations.dart';

import '../../../../system/service/share_service.dart';

class StoryGeneratorScreen extends StatefulWidget {
  const StoryGeneratorScreen(
      {super.key, required this.storyBreakdownModel, this.storyHighlight});

  final StoryBreakdownModel storyBreakdownModel;
  final String? storyHighlight;

  @override
  State<StoryGeneratorScreen> createState() => _StoryGeneratorScreenState();
}

class _StoryGeneratorScreenState extends State<StoryGeneratorScreen> {
  final GlobalKey<ExpandableFabState> _fabKey = GlobalKey<ExpandableFabState>();
  final ScreenshotController _ssController = ScreenshotController();

  bool _isLoading = true;
  bool _isGenerateError = false;
  bool _isShowAction = false;

  String _storyText = '';

  @override
  void initState() {
    _generateStory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarHeader.defaultHeader(
        title: 'Story Generator',
        actions: [
          AppIconButton.transparent(
            icon: Icons.format_size_rounded,
            onTap: () async {
              await AppNavigator.instance.push(const FontScaleScreenRoute());
              setState(() {});
            },
          ),
          AppIconButton.transparent(
            icon: Icons.font_download_rounded,
            onTap: () async {
              await AppNavigator.instance.push(const FontScreenRoute());
              setState(() {});
            },
          ),
        ],
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: _actionView,
      body: SafeArea(
        child: AnimatedSwitcher(
          duration: kDuration200,
          child: _isLoading ? const AppBasicLoading() : _mainView,
        ),
      ),
    );
  }

  Widget get _mainView {
    return Column(
      children: [
        ListView(
          padding: AppSpacer.instance.edgeInsets.all.sm,
          children: <Widget>[
            _contentView,
            if (_isShowAction) AppSpacer.instance.vHmd,
          ],
        ),
      ],
    );
  }

  Widget get _contentView {
    if (_storyText.isNullOrEmpty) {
      return Container();
    }

    return Screenshot(
      controller: _ssController,
      child: AppWaterMarkView(
        child: DefaultTextStyle(
          style: AppTextStyle.instance.storyGenerator,
          child: AnimatedTextKit(
            pause: kDuration100,
            isRepeatingAnimation: false,
            displayFullTextOnTap: true,
            onTap: () {
              setState(() => _isShowAction = true);
            },
            onFinished: () {
              setState(() => _isShowAction = true);
            },
            animatedTexts: [
              TypewriterAnimatedText(_storyText),
            ],
          ),
        ),
      ),
    );
  }

  Widget? get _actionView {
    if (!_isShowAction) {
      return null;
    }

    return ExpandableFab(
      key: _fabKey,
      openButtonBuilder: RotateFloatingActionButtonBuilder(
        child: const Icon(Icons.menu),
        fabSize: ExpandableFabSize.regular,
        foregroundColor: AppColors.black,
        backgroundColor: AppColors.white,
        shape: const CircleBorder(),
      ),
      closeButtonBuilder: FloatingActionButtonBuilder(
        size: 56,
        builder: (BuildContext context, void Function()? onPressed,
            Animation<double> progress) {
          return AppIconButton(
            onTap: onPressed,
            icon: Icons.close,
          );
        },
      ),
      overlayStyle: ExpandableFabOverlayStyle(
        color: Colors.black.withOpacity(0.5),
        blur: 5,
      ),
      children: [
        if (!_isGenerateError)
          AppIconButton(
            icon: Icons.save,
            onTap: _ctaSave,
          ),
        AppIconButton(
          icon: Icons.refresh,
          onTap: _generateStory,
        ),
        if (!_isGenerateError)
          AppIconButton(
            icon: Icons.share,
            onTap: _ctaShare,
          ),
      ],
    );
  }

  Future<void> _ctaSave({List<String>? errorList}) async {
    AppDialog.instance.sLoading(context);

    try {
      String response;

      if (errorList.isNullOrEmpty) {
        response = await AiService.instance.generateLatestStoryBreakdown(
          widget.storyBreakdownModel,
          _storyText,
        );
      } else {
        response = await AiService.instance.regenerateErrorStoryBreakdown(
          widget.storyBreakdownModel,
          errorList!,
        );
      }

      StoryBreakdownModel storyBreakdownModel =
          StoryBreakdownModel.fromJson(jsonDecode(response));
      storyBreakdownModel.jsonString = response;

      List<String> newErrorList = validateStoryBreakdown(storyBreakdownModel);

      if (newErrorList.isNotNullOrEmpty) {
        _ctaSave(errorList: newErrorList);
      } else {
        _executeFinalStoryBreakdown(storyBreakdownModel);
      }
    } on Exception catch (e, s) {
      AppDialog.instance.hLoading();
      AppBugTracker.instance.captureException(exception: e, stackTrace: s);
      AppDialog.instance.sError(
        context: context,
        detail: 'Save story failed, please try again',
      );
    } catch (e) {
      AppDialog.instance.hLoading();
      AppDialog.instance.sError(
        context: context,
        detail: 'Save story failed, please try again',
      );
    }
  }

  Future<void> _ctaShare() async {
    ShareService().shareScreenshot(context: context, controller: _ssController);
  }

  List<String> validateStoryBreakdown(StoryBreakdownModel storyBreakdownModel) {
    List<String> errorList = [];
    if (storyBreakdownModel.storyMetadata == null ||
        storyBreakdownModel.storyMetadata!.toJson().isEmpty) {
      errorList.add('Story metadata is empty');
    }
    // if (storyBreakdownModel.plotBreakdown == null ||
    //     storyBreakdownModel.plotBreakdown!.toJson().isEmpty) {
    //   errorList.add('Story plot breakdown is empty');
    // }
    // if (storyBreakdownModel.settingBreakdown == null ||
    //     storyBreakdownModel.settingBreakdown!.toJson().isEmpty) {
    //   errorList.add('Story setting breakdwon is empty');
    // }
    if (storyBreakdownModel.chapterBreakdown.isNullOrEmpty) {
      errorList.add('Chapter Breakdown is empty');
    }
    if (storyBreakdownModel.characterBreakdown.isNullOrEmpty) {
      errorList.add('Character Breakdown is empty');
    }
    return errorList;
  }

  void _executeFinalStoryBreakdown(StoryBreakdownModel storyBreakdownModel) {
    try {
      if (storyBreakdownModel.toJson().isEmpty) {
        throw Exception(
            'Json generated is empty : ${storyBreakdownModel.toJson()}');
      }

      /// Assign old chapter story
      if (widget.storyBreakdownModel.chapterBreakdown.isNotNullOrEmpty) {
        List.generate(widget.storyBreakdownModel.chapterBreakdown!.length,
            (int index) {
          final item = storyBreakdownModel.chapterBreakdown?[index];
          final oldItem = widget.storyBreakdownModel.chapterBreakdown?[index];

          if (item != null && oldItem != null) {
            item.chapterStory = oldItem.chapterStory;
          }
        });
      }

      /// Assign new chapter story
      storyBreakdownModel.chapterBreakdown?.last.chapterStory = _storyText;

      StoryFileManagement.instance.saveStory(
        storyBreakdownModel,
        title: widget.storyBreakdownModel.storyMetadata?.title,
      );

      AppToast.sSuccess(context: context, text: 'Story saved successfully');
      AppDialog.instance.hLoading();
      AppNavigator.instance.pop(storyBreakdownModel);
    } catch (e) {
      log('XXX error $e');
      AppDialog.instance.hLoading();
      AppDialog.instance.sError(
        context: context,
        detail: 'Save story failed, please try again',
      );
    }
  }

  Future<void> _generateStory() async {
    setState(() {
      _storyText = '';
      _isShowAction = false;
      _isLoading = true;
    });

    try {
      String? response;
      if (widget.storyBreakdownModel.chapterBreakdown.isNullOrEmpty) {
        response = await AiService.instance
            .generateInitialStory(widget.storyBreakdownModel);
      } else {
        response = await AiService.instance.continueStory(
          widget.storyBreakdownModel,
          widget.storyHighlight,
        );
      }

      setState(() {
        if (response.isNullOrEmpty) {
          _isGenerateError = true;
          _storyText = 'Failed to generate story, please try regenerate again.';
        } else {
          _isGenerateError = false;
          _storyText = response!;
        }
        _isLoading = false;
      });
    } catch (e) {
      _isGenerateError = true;
      _storyText = 'Failed to generate story, please try regenerate again.';
    }
  }
}
