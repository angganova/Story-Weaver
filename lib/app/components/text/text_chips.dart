import 'package:flutter/material.dart';
import 'package:story_weaver/app/components/text/text_field.dart';

class TextChipsView extends StatefulWidget {
  const TextChipsView({super.key, required this.tc});
  final TextEditingController tc;
  @override
  State<TextChipsView> createState() => _TextChipsViewState();
}

class _TextChipsViewState extends State<TextChipsView> {
  final List<String> _chips = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextField(
            controller: widget.tc,
            onChanged: _handleTextChanged,
          ),
          const SizedBox(height: 16.0),
          Wrap(
            spacing: 8.0,
            children: _chips
                .map(
                  (chip) => Chip(
                    label: Text(chip),
                    onDeleted: () {
                      setState(() {
                        _chips.remove(chip);
                      });
                    },
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  void _handleTextChanged(String value) {
    if (value.endsWith(',')) {
      setState(() {
        _chips.addAll(
          value
              .split(',')
              .map((tag) => tag.trim())
              .where((tag) => tag.isNotEmpty),
        );
        widget.tc.clear();
      });
    }
  }
}
