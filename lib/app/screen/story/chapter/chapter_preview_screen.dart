// ignore_for_file: use_build_context_synchronously

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:story_weaver/app/components/app_bar/default_app_bar.dart';
import 'package:story_weaver/app/components/button/icon_button.dart';
import 'package:story_weaver/data/model/story/story_breakdown_model.dart';
import 'package:story_weaver/system/extension/string_extension.dart';
import 'package:story_weaver/system/global_style.dart';
import 'package:story_weaver/system/routes/routes_map.dart';
import 'package:story_weaver/system/service/navigator.dart';
import 'package:story_weaver/system/variables/durations.dart';

class ChapterPreviewScreen extends StatefulWidget {
  const ChapterPreviewScreen({super.key, required this.chapterBreakdown});

  final ChapterBreakdown chapterBreakdown;

  @override
  State<ChapterPreviewScreen> createState() => _ChapterPreviewScreenState();
}

class _ChapterPreviewScreenState extends State<ChapterPreviewScreen> {
  @override
  void initState() {
    super.initState();
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
      padding: AppSpacer.instance.edgeInsets.all.sm,
      children: [_contentView],
    );
  }

  Widget get _contentView {
    if (widget.chapterBreakdown.chapterStory.isNullOrEmpty) {
      return Container();
    }

    return DefaultTextStyle(
      style: AppTextStyle.instance.storyGenerator,
      child: AnimatedTextKit(
        pause: kDuration100,
        isRepeatingAnimation: false,
        displayFullTextOnTap: true,
        animatedTexts: [
          TypewriterAnimatedText(widget.chapterBreakdown.chapterStory!),
        ],
      ),
    );
  }
}
