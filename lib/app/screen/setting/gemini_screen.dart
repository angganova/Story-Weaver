import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:story_weaver/app/components/app_bar/default_app_bar.dart';
import 'package:story_weaver/app/components/list_item/list_tile.dart';
import 'package:story_weaver/system/extension/list_extension.dart';
import 'package:story_weaver/system/service/local_storage.dart';

import '../../../system/global_style.dart';
import '../../../system/service/ai_service.dart';
import '../../components/text/basic_text.dart';

class GeminiScreen extends StatefulWidget {
  const GeminiScreen({super.key});

  @override
  State<GeminiScreen> createState() => _GeminiScreenState();
}

class _GeminiScreenState extends State<GeminiScreen> {
  List<GeminiModel> _geminiList = [];
  GeminiModel? _selectedGeminiModel;

  @override
  void initState() {
    _initPlatformState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarHeader.basic(
        title: 'Gemini API',
      ),
      body: SafeArea(
        child: _mainView,
      ),
    );
  }

  Widget get _mainView {
    return ListView(
      children: _geminiList.map((item) {
        return Container(
          color: _selectedGeminiModel == item
              ? AppColors.green.withOpacity(0.25)
              : AppColors.transparent,
          child: AppListTile(
            withDivider: true,
            dividerPadding: AppSpacer.instance.edgeInsets.zero,
            title: AppText.sectionHeader(
              item.displayName ?? '',
              color: AppColors.textPrimary,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.paragraph(
                  item.description ?? '',
                  color: AppColors.textBlack,
                  maxLines: 5,
                ),
                AppSpacer.instance.vHxxs,
                AppText.paragraph2('Max Input Token : ${item.inputTokenLimit}'),
                AppSpacer.instance.vHxxs,
                AppText.paragraph2(
                    'Max Output Token : ${item.outputTokenLimit}')
              ],
            ),
            onTap: () => _ctaSelectGeminiModel(item),
          ),
        );
      }).toList(),
    );
  }

  void _ctaSelectGeminiModel(GeminiModel item) {
    if (_selectedGeminiModel == item) {
      return;
    } else {
      AppLocalStorage.instance.setGeminiModel(item);
      setState(() {
        _selectedGeminiModel = item;
      });
    }
  }

  Future<void> _initPlatformState() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _geminiList = AiService.instance.geminiList ?? [];
      List<GeminiModel> prob = _geminiList
          .where((item) => AppLocalStorage.instance.isSelectedGeminiModel(item))
          .toList();
      if (prob.isNotNullOrEmpty) {
        _selectedGeminiModel = prob.first;
      }
      setState(() {});
    });
  }
}
