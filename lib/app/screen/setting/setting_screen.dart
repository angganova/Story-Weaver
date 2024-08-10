import 'package:flutter/material.dart';
import 'package:story_weaver/app/components/app_bar/default_app_bar.dart';
import 'package:story_weaver/app/components/list_item/list_tile.dart';
import 'package:story_weaver/app/components/text/basic_text.dart';
import 'package:story_weaver/system/global_style.dart';
import 'package:story_weaver/system/routes/routes_map.dart';
import 'package:story_weaver/system/service/navigator.dart';

import '../../../system/config/app_info.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarHeader.basic(
        title: 'Setting',
      ),
      body: SafeArea(
        child: _mainView,
      ),
    );
  }

  Widget get _mainView {
    return Column(
      children: [
        Expanded(child: _contentView),
        Container(
          padding: AppSpacer.instance.edgeInsets.x.sm,
          width: AppQuery.instance.width,
          child: AppText.b1(
            'Story Weaver ${AppInfo.instance.displayVersion}',
            align: TextAlign.center,
          ),
        ),
        AppSpacer.instance.vHxs,
        Container(
          padding: AppSpacer.instance.edgeInsets.x.sm,
          width: AppQuery.instance.width,
          child: AppText.sectionHeader(
            'Powered by Gemini AI',
            align: TextAlign.center,
          ),
        ),
        AppSpacer.instance.vHsm,
      ],
    );
  }

  Widget get _contentView {
    return ListView(
      children: [
        AppListTile.titleSubtitle(
          title: 'Gemini AI',
          subtitle: 'List of all Gemini AI Models',
          onTap: () {
            AppNavigator.instance.push(const GeminiScreenRoute());
          },
        ),
      ],
    );
  }
}
