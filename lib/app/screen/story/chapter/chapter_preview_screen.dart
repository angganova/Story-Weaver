// ignore_for_file: use_build_context_synchronously

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:story_weaver/app/components/app_bar/default_app_bar.dart';
import 'package:story_weaver/data/model/story/story_breakdown_model.dart';
import 'package:story_weaver/system/extension/string_extension.dart';
import 'package:story_weaver/system/global_style.dart';
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
      appBar: AppBarHeader.basic(
        title: 'Chapter ${widget.chapterBreakdown.number}',
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
      style: AppTextStyle.instance.paragraph.copyWith(
        fontFamily: 'Agne',
        height: 2,
      ),
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
