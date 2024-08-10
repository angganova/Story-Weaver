import 'package:flutter/material.dart';
import 'package:story_weaver/app/components/app_bar/default_app_bar.dart';
import 'package:story_weaver/app/components/button/icon_button.dart';
import 'package:story_weaver/app/components/text/basic_text.dart';
import 'package:story_weaver/system/global_style.dart';
import 'package:story_weaver/system/service/navigator.dart';

import '../../../../data/model/main/title_detail_model.dart';

class StoryOptionPickerScreen extends StatefulWidget {
  const StoryOptionPickerScreen({
    super.key,
    required this.optList,
    required this.appBarTitle,
    this.singleSelect = false,
  });

  final String appBarTitle;
  final List<TitleDetailModel> optList;
  final bool singleSelect;

  @override
  State<StoryOptionPickerScreen> createState() =>
      _StoryOptionPickerScreenState();
}

class _StoryOptionPickerScreenState extends State<StoryOptionPickerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarHeader.defaultHeader(
        title: widget.appBarTitle,
        actions: [
          Padding(
            padding: AppSpacer.instance.edgeInsets.x.s,
            child: AppIconButton.transparent(
              icon: Icons.check_circle_outlined,
              onTap: () => AppNavigator.instance.pop(true),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: _mainView,
      ),
    );
  }

  Widget get _mainView {
    return ListView(
      children: widget.optList.map((item) {
        return _bindOption(item);
      }).toList(),
    );
  }

  Widget _bindOption(TitleDetailModel item) {
    return InkWell(
      onTap: () {
        setState(() {
          item.selected = !item.selected;
        });
      },
      child: Padding(
        padding: AppSpacer.instance.edgeInsets.symmetric(x: 'sm', y: 's'),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.sectionHeader(item.title ?? ''),
                  AppText.paragraph(
                    item.detail ?? '',
                    maxLines: 5,
                  ),
                ],
              ),
            ),
            AppSpacer.instance.vWsm,
            IgnorePointer(
              child: Checkbox(
                value: item.selected,
                onChanged: (selected) {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
