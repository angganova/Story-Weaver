import 'package:flutter/material.dart';
import 'package:story_weaver/app/components/app_bar/default_app_bar.dart';
import 'package:story_weaver/app/components/button/elevated_button.dart';
import 'package:story_weaver/system/service/local_storage.dart';

import '../../../system/global_style.dart';
import '../../components/text/basic_text.dart';

class FontScaleScreen extends StatefulWidget {
  const FontScaleScreen({super.key});

  @override
  State<FontScaleScreen> createState() => _FontScaleScreenState();
}

class _FontScaleScreenState extends State<FontScaleScreen> {
  double? _selectedTextScale;

  @override
  void initState() {
    _initPlatformState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarHeader.basic(
        title: 'Font',
      ),
      body: SafeArea(
        child: _mainView,
      ),
    );
  }

  Widget get _mainView {
    return ListView(padding: AppSpacer.instance.edgeInsets.all.sm, children: [
      Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: AppTextStyle.instance.availableTextScale
            .map(
              (item) => AppElevatedButton(
                wrapContent: true,
                text: item.toString(),
                backgroundColor: _selectedTextScale == item
                    ? AppColors.primaryBgColor
                    : AppColors.bgAccent2,
                onPressed: () => _ctaSelectItem(item),
              ),
            )
            .toList(),
      ),
      AppSpacer.instance.vHstandard,
      AppText.paragraph(
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod '
        'tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim '
        'veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex '
        'ea commodo consequat. Duis aute irure dolor in reprehenderit in '
        'voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur '
        'sint occaecat cupidatat non proident, sunt in culpa qui officia '
        'deserunt mollit anim id est laborum.',
        maxLines: 99,
      ),
    ]);
  }

  void _ctaSelectItem(double item) {
    if (_selectedTextScale == item) {
      return;
    } else {
      AppLocalStorage.instance.saveTextScale(item);
      setState(
          () => _selectedTextScale = AppTextStyle.instance.storageTextScale);
    }
  }

  Future<void> _initPlatformState() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _selectedTextScale = AppTextStyle.instance.storageTextScale;
      });
    });
  }
}
