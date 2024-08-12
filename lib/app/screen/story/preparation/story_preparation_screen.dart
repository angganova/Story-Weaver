import 'package:flutter/material.dart';
import 'package:story_weaver/app/components/list_item/list_tile.dart';
import 'package:story_weaver/app/components/text/text_chips.dart';
import 'package:story_weaver/data/model/main/title_detail_model.dart';
import 'package:story_weaver/data/model/story/story_breakdown_model.dart';
import 'package:story_weaver/system/global_extension.dart';

import '../../../../data/model/story/story_preparation_model.dart';
import '../../../../system/global_style.dart';
import '../../../../system/popup/dialog.dart';
import '../../../../system/routes/routes_map.dart';
import '../../../../system/service/navigator.dart';
import '../../../components/app_bar/default_app_bar.dart';
import '../../../components/button/elevated_button.dart';
import '../../../components/loading/basic_loading.dart';
import '../../../components/text/basic_text.dart';
import '../../../components/text/text_field.dart';

class StoryPreparationScreen extends StatefulWidget {
  const StoryPreparationScreen({super.key});

  @override
  State<StoryPreparationScreen> createState() => _StoryPreparationScreenState();
}

class _StoryPreparationScreenState extends State<StoryPreparationScreen> {
  StoryPreparationModel? _storyPreparationModel;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _storyPreparationModel = StoryPreparationModel.initial();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _storyPreparationModel?.storyPreparationList?.forEach((item) {
      item.tc?.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarHeader.basic(
        title: 'Story Preparation',
      ),
      body: _mainView,
    );
  }

  Widget get _mainView {
    if (_storyPreparationModel != null &&
        _storyPreparationModel!.storyPreparationList.isNotNullOrEmpty) {
      return ListView(
        padding: AppSpacer.instance.edgeInsets.all.sm,
        children: [
          ..._storyPreparationModel!.storyPreparationList!
              .map((item) => _bindItemView(item)),
          AppSpacer.instance.vHsm,
          AppElevatedButton(
            text: 'Begin the Story',
            onPressed: ctaBeginStory,
          )
        ],
      );
    } else {
      return const Center(
        child: AppBasicLoading(),
      );
    }
  }

  Widget _bindItemView(StoryPreparationDetail item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
                child: AppText.h2(
              item.title ?? '',
              isBold: true,
            )),
            AppSpacer.instance.vWsm,
            GestureDetector(
              onTap: () {
                AppDialog.instance.sInformation(
                  context: context,
                  title: item.title,
                  detail: item.description,
                );
              },
              child: const Icon(
                Icons.help_outline_rounded,
                color: AppColors.darkBlueBgColor,
              ),
            ),
          ],
        ),
        AppSpacer.instance.vHxs,
        _bindItemContentView(item),
        const Divider(),
      ],
    );
  }

  Widget _bindItemContentView(StoryPreparationDetail item) {
    if (item.dataType.ignoreCase('internalOption')) {
      return _bindInternalOption(item);
    } else if (item.dataType.ignoreCase('split-string')) {
      return TextChipsView(
        controller: item.tc!,
        selectedChips: _storyPreparationModel!.characterNameList,
      );
    } else if (item.dataType.ignoreCase('string')) {
      return AppTextField(
        controller: item.tc!,
        textCapitalization: TextCapitalization.words,
      );
    }
    return Container();
  }

  Widget _bindInternalOption(StoryPreparationDetail item) {
    final List<TitleDetailModel> selectedInternalOptionList =
        item.internalOptionList.where((opt) => opt.selected).toList();

    if (selectedInternalOptionList.length.isMoreThanZero) {
      return InkWell(
        onTap: () => _ctaInternalOption(item),
        child: Row(
          children: [
            Expanded(
              child: Wrap(
                spacing: 8.0,
                children: selectedInternalOptionList.map(
                  (opt) {
                    return Chip(
                      label: Text(opt.title ?? ''),
                      onDeleted: () {
                        setState(() => opt.selected = false);
                      },
                    );
                  },
                ).toList(),
              ),
            ),
            AppSpacer.instance.vWxs,
            const Icon(Icons.arrow_forward_ios_rounded),
          ],
        ),
      );
    } else {
      return AppListTile.titleTrailing(
        padding: AppSpacer.instance.edgeInsets.y.xs,
        title: 'Pick ${item.title}',
        trailing: const Icon(Icons.arrow_forward_ios_rounded),
        onTap: () => _ctaInternalOption(item),
      );
    }
  }

  Future<void> _ctaInternalOption(StoryPreparationDetail item) async {
    await AppNavigator.instance.push(
      StoryOptionPickerScreenRoute(
        appBarTitle: item.title ?? '',
        optList: item.internalOptionList,
      ),
    );

    setState(() {});
  }

  void ctaBeginStory() {
    final StoryBreakdownModel storyBreakdown = _storyPreparationModel!.finish();
    AppDialog.instance.sConfirmation(
      context: context,
      detail: 'Please be aware that your selection can\'t be changed later, '
          'are you sure you want to start your story?',
      confirmCallback: () async {
        AppDialog.instance.dismissCurrentPopUp();
        await AppNavigator.instance.push(
          StoryGeneratorScreenRoute(
            storyBreakdownModel: storyBreakdown,
          ),
        );
        AppNavigator.instance.pop(true);
      },
    );
  }
}
