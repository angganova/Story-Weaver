import 'package:flutter/material.dart';
import 'package:story_weaver/app/components/text/basic_text.dart';
import 'package:story_weaver/app/components/text/text_field.dart';
import 'package:story_weaver/system/global_extension.dart';

class TextChipsView extends StatefulWidget {
  const TextChipsView(
      {super.key, required this.controller, required this.selectedChips});

  final TextEditingController controller;
  final List<String> selectedChips;

  @override
  State<TextChipsView> createState() => _TextChipsViewState();
}

class _TextChipsViewState extends State<TextChipsView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextField(
          controller: widget.controller,
          onChanged: _handleTextChanged,
          textInputAction: TextInputAction.done,
          textCapitalization: TextCapitalization.words,
          onFieldSubmitted: (text) {
            _finishTextChanged(text);
          },
        ),
        const SizedBox(height: 16.0),
        Wrap(
          spacing: 8.0,
          children: widget.selectedChips
              .map(
                (chip) => Chip(
                  label: AppText(chip),
                  onDeleted: () {
                    setState(() => widget.selectedChips.remove(chip));
                  },
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  void _handleTextChanged(String value) {
    if (value.replaceAll(', ', ',').endsWith(',')) {
      setState(() {
        widget.selectedChips.addAll(
          value
              .replaceAll(', ', ',')
              .split(',')
              .map((tag) => tag.trim())
              .where((tag) => tag.isNotEmpty),
        );
        widget.controller.clear();
      });
    }
  }

  void _finishTextChanged(String value) {
    setState(() {
      if (value.trim().isNotNullOrEmpty) {
        widget.selectedChips.add(value);
      }
      widget.controller.clear();
    });
  }
}
