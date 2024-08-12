import 'package:flutter/material.dart';
import 'package:story_weaver/app/components/app_bar/default_app_bar.dart';
import 'package:story_weaver/app/components/button/elevated_button.dart';
import 'package:story_weaver/app/components/button/icon_button.dart';
import 'package:story_weaver/app/components/list_item/list_tile.dart';
import 'package:story_weaver/app/components/loading/basic_loading.dart';
import 'package:story_weaver/app/components/text/basic_text.dart';
import 'package:story_weaver/app/screen/home/home_vm.dart';
import 'package:story_weaver/data/model/story/story_breakdown_model.dart';
import 'package:story_weaver/system/global_extension.dart';
import 'package:story_weaver/system/popup/dialog.dart';
import 'package:story_weaver/system/routes/routes_map.dart';
import 'package:story_weaver/system/service/internal/story_file_management.dart';
import 'package:story_weaver/system/service/navigator.dart';
import 'package:story_weaver/system/style/colors.dart';
import 'package:story_weaver/system/style/dimensions.dart';
import 'package:story_weaver/system/variables/durations.dart';

import '../../components/global/empty_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<StoryBreakdownModel>? _storyList;

  @override
  void initState() {
    _initPlatformState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarHeader.defaultHeader(
        title: 'Story Weaver',
        showBackButton: false,
        actions: [
          AppIconButton.transparent(
            icon: Icons.settings,
            onTap: () async {
              await AppNavigator.instance.push(const SettingScreenRoute());
              setState(() {});
            },
          ),
        ],
      ),
      body: SafeArea(child: _mainView),
    );
  }

  Widget get _mainView {
    if (_storyList.isNull) {
      return const AppBasicLoading();
    } else if (_storyList.isNotNullOrEmpty) {
      return _contentView;
    } else {
      return _emptyView;
    }
  }

  Widget get _emptyView {
    return Padding(
      padding: AppSpacer.instance.edgeInsets.all.sm,
      child: Column(
        children: [
          const Expanded(
            child: AppEmptyView(
              imageUrl:
                  'https://static.vecteezy.com/system/resources/previews/013/558/523/non_2x/folder-archive-computer-document-empty-file-storage-blue-icon-on-abstract-cloud-background-free-vector.jpg',
              title: 'No Stories Found',
            ),
          ),
          AppSpacer.instance.vHsm,
          _addButtonView
        ],
      ),
    );
  }

  Widget get _contentView {
    return Column(
      children: [
        Expanded(
          child: RefreshIndicator(
            onRefresh: _getStoryList,
            child: ListView(
              children: _storyList!.map((item) => _bindItemView(item)).toList(),
            ),
          ),
        ),
        AppSpacer.instance.vHsm,
        Padding(
          padding: AppSpacer.instance.edgeInsets.all.sm,
          child: _addButtonView,
        )
      ],
    );
  }

  Widget _bindItemView(StoryBreakdownModel item) {
    return AppListTile(
      title: AppText.sectionHeader(item.storyMetadata?.title ?? 'No-Title'),
      subtitle: AppText.paragraph('${item.chapterBreakdown?.last.title}'),
      onTap: () => _ctaEditStory(item),
      trailing: item.fileName.isNotNullOrEmpty
          ? AppIconButton.transparent(
              icon: Icons.delete_forever,
              iconColor: AppColors.red,
              onTap: () => _ctaDeleteStory(item),
            )
          : null,
      withDivider: true,
    );
  }

  Widget get _addButtonView {
    return AppElevatedButton(
      text: 'Add Story',
      onPressed: _ctaAddStory,
    );
  }

  Future<void> _initPlatformState() async {
    HomeVm.instance.init();
    _getStoryList();
  }

  Future<void> _getStoryList() async {
    _storyList = await StoryFileManagement.instance.getStoryList();
    setState(() => _storyList ??= []);
  }

  Future<void> _ctaAddStory() async {
    await AppNavigator.instance.push(const StoryPreparationScreenRoute());
    Future.delayed(kDuration500, () => _getStoryList());
  }

  Future<void> _ctaEditStory(StoryBreakdownModel story) async {
    await AppNavigator.instance
        .push(StoryDetailScreenRoute(storyBreakdownModel: story));
    _getStoryList();
  }

  Future<void> _ctaDeleteStory(StoryBreakdownModel story) async {
    AppDialog.instance.sConfirmation(
      context: context,
      title: 'Delete Story',
      detail: 'Are you sure you want to delete this story?',
      confirmCallback: () async {
        AppDialog.instance.dismissCurrentPopUp();
        await StoryFileManagement.instance.deleteStory(story.fileName!);
        _getStoryList();
      },
    );
  }
}
