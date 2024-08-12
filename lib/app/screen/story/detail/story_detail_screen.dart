import 'package:flutter/material.dart';
import 'package:story_weaver/app/components/app_bar/default_app_bar.dart';
import 'package:story_weaver/app/components/list_item/list_tile.dart';
import 'package:story_weaver/data/model/story/story_breakdown_model.dart';
import 'package:story_weaver/system/global_extension.dart';
import 'package:story_weaver/system/global_style.dart';
import 'package:story_weaver/system/popup/dialog.dart';
import 'package:story_weaver/system/routes/routes_map.dart';
import 'package:story_weaver/system/service/navigator.dart';

import '../../../components/global/map_view.dart';

class StoryDetailScreen extends StatefulWidget {
  const StoryDetailScreen({super.key, required this.storyBreakdownModel});

  final StoryBreakdownModel storyBreakdownModel;

  @override
  State<StoryDetailScreen> createState() => _StoryDetailScreenState();
}

class _StoryDetailScreenState extends State<StoryDetailScreen>
    with SingleTickerProviderStateMixin {
  final List<Tab> tabList = [
    const Tab(text: 'Details'),
    const Tab(text: 'Chapters'),
    const Tab(text: 'Characters'),
    const Tab(text: 'Plots'),
    const Tab(text: 'Settings'),
  ];

  TabController? _tabController;
  PageController? _pageController;
  int _selectedTabIndex = 0;

  StoryBreakdownModel? _currentStoryBreakdownModel;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabList.length, vsync: this);
    _pageController = PageController();
    _currentStoryBreakdownModel = widget.storyBreakdownModel;
  }

  @override
  void dispose() {
    _tabController?.dispose();
    _pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarHeader.basic(
        title: _currentStoryBreakdownModel?.storyMetadata?.title ?? '',
      ),
      floatingActionButton: _selectedTabIndex.isEqual(1)
          ? FloatingActionButton(
              shape: const CircleBorder(),
              onPressed: _ctaAddChapter,
              child: const Icon(Icons.add),
            )
          : null,
      body: SafeArea(
        child: _mainView,
      ),
    );
  }

  Widget get _mainView {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TabBar(
          tabAlignment: TabAlignment.start,
          controller: _tabController,
          isScrollable: true,
          onTap: (int index) {
            _pageController!.jumpToPage(index);
          },
          tabs: tabList,
          labelStyle: AppTextStyle.instance.paragraph,
        ),
        Expanded(child: _tabContentView),
      ],
    );
  }

  Widget get _tabContentView {
    return PageView(
      controller: _pageController,
      onPageChanged: (int index) {
        _tabController!.animateTo(index);
        setState(() => _selectedTabIndex = index);
      },
      children: [
        MapView(map: _currentStoryBreakdownModel?.storyMetadata?.toJson()),
        _bindDataListView(_currentStoryBreakdownModel?.chapterBreakdown),
        _bindDataListView(_currentStoryBreakdownModel?.characterBreakdown),
        MapView(map: _currentStoryBreakdownModel?.plotBreakdown?.toJson()),
        MapView(map: _currentStoryBreakdownModel?.settingBreakdown?.toJson()),
      ],
    );
  }

  Widget _bindDataListView(List<dynamic>? dataList) {
    if (dataList == null) {
      return Container();
    } else {
      return ListView(
        children: dataList.map((item) => _bindDataListItemView(item)).toList(),
      );
    }
  }

  Widget _bindDataListItemView(dynamic item) {
    if (item == null) {
      return Container();
    }

    String title = '';
    String subtitle = '';
    VoidCallback? onTap;

    if (item is CharacterBreakdown) {
      title = item.name ?? '';
      subtitle = item.description ?? '';
      onTap = () {
        AppNavigator.instance
            .push(CharacterPreviewScreenRoute(characterBreakdown: item));
      };
    } else if (item is ChapterBreakdown) {
      title = item.title ?? '';
      subtitle = item.summary ?? '';
      onTap = () async {
        await AppNavigator.instance
            .push(ChapterPreviewScreenRoute(chapterBreakdown: item));
        setState(() {});
      };
    }

    return AppListTile.titleSubtitle(
      title: title,
      subtitle: subtitle,
      withDivider: true,
      onTap: onTap,
    );
  }

  Future<void> _ctaAddChapter() async {
    if (_currentStoryBreakdownModel == null) {
      return;
    }

    final String? storyHighlight = await AppDialog.instance.sInputText(context);
    final dynamic storyBreakdownModel = await AppNavigator.instance.push(
      StoryGeneratorScreenRoute(
        storyBreakdownModel: _currentStoryBreakdownModel!,
        storyHighlight: storyHighlight,
      ),
    );

    if (storyBreakdownModel != null &&
        storyBreakdownModel is StoryBreakdownModel) {
      setState(() => _currentStoryBreakdownModel = storyBreakdownModel);
    }
  }
}
