import 'package:flutter/material.dart';
import 'package:story_weaver/app/components/app_bar/default_app_bar.dart';
import 'package:story_weaver/app/components/list_item/list_tile.dart';
import 'package:story_weaver/system/service/local_storage.dart';

import '../../../system/global_style.dart';
import '../../components/text/basic_text.dart';

class FontScreen extends StatefulWidget {
  const FontScreen({super.key});

  @override
  State<FontScreen> createState() => _FontScreenState();
}

class _FontScreenState extends State<FontScreen> {
  TextStyle? _selectedTextStyle;

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
    return ListView(
      children: AppTextStyle.instance.availableTextStyle.map((item) {
        return Container(
          color: _selectedTextStyle == item
              ? AppColors.green.withOpacity(0.25)
              : AppColors.transparent,
          child: AppListTile(
            withDivider: true,
            dividerPadding: AppSpacer.instance.edgeInsets.zero,
            title: AppText(
              item.fontFamily ?? '',
              color: AppColors.textPrimary,
              textStyle: item.copyWith(
                fontSize: 16 * AppTextStyle.instance.currentTextScaleFactor,
              ),
            ),
            subtitle: AppText(
              'The quick brown fox jumps over the lazy dog',
              color: AppColors.textBlack,
              textStyle: item.copyWith(
                fontSize: 14 * AppTextStyle.instance.currentTextScaleFactor,
              ),
            ),
            onTap: () => _ctaSelectItem(item),
          ),
        );
      }).toList(),
    );
  }

  void _ctaSelectItem(TextStyle item) {
    if (_selectedTextStyle == item) {
      return;
    } else {
      AppLocalStorage.instance.saveTextStyleName(item.fontFamily ?? '');
      setState(
          () => _selectedTextStyle = AppTextStyle.instance.storageTextStyle);
    }
  }

  Future<void> _initPlatformState() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _selectedTextStyle = AppTextStyle.instance.storageTextStyle;
      });
    });
  }
}
