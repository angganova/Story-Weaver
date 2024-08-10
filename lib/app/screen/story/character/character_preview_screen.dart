// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:story_weaver/app/components/app_bar/default_app_bar.dart';
import 'package:story_weaver/app/components/global/map_view.dart';
import 'package:story_weaver/data/model/story/story_breakdown_model.dart';
import 'package:story_weaver/system/variables/durations.dart';

class CharacterPreviewScreen extends StatefulWidget {
  const CharacterPreviewScreen({super.key, required this.characterBreakdown});

  final CharacterBreakdown characterBreakdown;

  @override
  State<CharacterPreviewScreen> createState() => _CharacterPreviewScreenState();
}

class _CharacterPreviewScreenState extends State<CharacterPreviewScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarHeader.basic(
        title: widget.characterBreakdown.name,
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
    return MapView(
      map: widget.characterBreakdown.toJson(),
    );
  }
}
