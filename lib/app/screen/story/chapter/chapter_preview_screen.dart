// ignore_for_file: use_build_context_synchronously

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:screenshot/screenshot.dart';
import 'package:story_weaver/app/components/app_bar/default_app_bar.dart';
import 'package:story_weaver/app/components/button/icon_button.dart';
import 'package:story_weaver/app/components/global/watermark_view.dart';
import 'package:story_weaver/data/model/story/story_breakdown_model.dart';
import 'package:story_weaver/system/extension/string_extension.dart';
import 'package:story_weaver/system/global_style.dart';
import 'package:story_weaver/system/routes/routes_map.dart';
import 'package:story_weaver/system/service/navigator.dart';
import 'package:story_weaver/system/variables/durations.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../../../system/service/share_service.dart';

class ChapterPreviewScreen extends StatefulWidget {
  const ChapterPreviewScreen({super.key, required this.chapterBreakdown});

  final ChapterBreakdown chapterBreakdown;

  @override
  State<ChapterPreviewScreen> createState() => _ChapterPreviewScreenState();
}

class _ChapterPreviewScreenState extends State<ChapterPreviewScreen> {
  final ScreenshotController _ssController = ScreenshotController();
  final GlobalKey<ExpandableFabState> _fabKey = GlobalKey<ExpandableFabState>();

  bool _isShowAction = false;

  @override
  void initState() {
    WakelockPlus.enable();
    super.initState();
  }

  @override
  void dispose() {
    WakelockPlus.disable();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarHeader.defaultHeader(
        title: 'Chapter ${widget.chapterBreakdown.number}',
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
          child: _mainView,
        ),
      ),
    );
  }

  Widget get _mainView {
    return ListView(
      children: [
        _contentView,
        if (_isShowAction) AppSpacer.instance.vHxxl,
      ],
    );
  }

  Widget get _contentView {
    if (widget.chapterBreakdown.chapterStory.isNullOrEmpty) {
      return Container();
    }

    return Screenshot(
      controller: _ssController,
      child: Container(
        padding: AppSpacer.instance.edgeInsets.all.sm,
        color: AppColors.white,
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
                WakelockPlus.disable();
                setState(() => _isShowAction = true);
              },
              animatedTexts: [
                TypewriterAnimatedText(
                    widget.chapterBreakdown.chapterStory!.trim()),
              ],
            ),
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
        AppIconButton(
          icon: Icons.share,
          onTap: _ctaShare,
        ),
      ],
    );
  }

  Future<void> _ctaShare() async {
    ShareService().shareScreenshot(context: context, controller: _ssController);
  }
}
