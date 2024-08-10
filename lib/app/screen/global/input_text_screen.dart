import 'package:flutter/material.dart';
import 'package:story_weaver/app/components/app_bar/default_app_bar.dart';
import 'package:story_weaver/app/components/button/icon_button.dart';
import 'package:story_weaver/app/components/list_item/list_tile.dart';
import '../../../../system/style/dimensions.dart';
import '../../components/button/elevated_button.dart';
import '../../components/text/text_field.dart';

class InputTextScreen extends StatefulWidget {
  const InputTextScreen({super.key});

  @override
  State<InputTextScreen> createState() => _InputTextScreenState();
}

class _InputTextScreenState extends State<InputTextScreen> {
  final TextEditingController _tc = TextEditingController();
  String? errorText;

  @override
  void dispose() {
    _tc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBarHeader.defaultHeader(
          title: 'New Chapter ',
          showBackButton: false,
          actions: [
            AppIconButton.transparent(
                icon: Icons.close,
                onTap: () => Navigator.of(context).pop(false)),
          ],
        ),
        body: _contentView,
      ),
    );
  }

  Widget get _contentView {
    return Padding(
      padding: AppSpacer.instance.edgeInsets.all.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AppListTile.titleSubtitle(
              padding: AppSpacer.instance.edgeInsets.zero,
              title: 'Anything to highlight in the new chapter?',
              subtitle:
                  'Use action tags like introduce, create, discover, and etch'),
          AppSpacer.instance.vHs,
          _inputView,
          AppSpacer.instance.vHstandard,
          _saveButtonView,
        ],
      ),
    );
  }

  Widget get _inputView {
    return AppTextField(
      controller: _tc,
      textCapitalization: TextCapitalization.sentences,
      singleLine: false,
      maxLine: null,
      textInputAction: TextInputAction.newline,
    );
  }

  Widget get _saveButtonView {
    return AppElevatedButton.primary(
        text: 'Generate Story',
        onPressed: () => Navigator.of(context).pop(_tc.text));
  }
}
