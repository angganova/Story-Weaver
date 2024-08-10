import 'package:flutter/material.dart';
import 'package:story_weaver/app/components/text/basic_text.dart';
import 'package:story_weaver/system/style/dimensions.dart';

class MultiSelectDropdown extends StatefulWidget {
  final String label;
  final List<String> optionList;
  final Function(List<String>) onUpdateSelectedOption;

  const MultiSelectDropdown({
    super.key,
    required this.optionList,
    required this.label,
    required this.onUpdateSelectedOption,
  });

  @override
  State<MultiSelectDropdown> createState() => _MultiSelectDropdownState();
}

class _MultiSelectDropdownState extends State<MultiSelectDropdown> {
  final List<String> selectedOption = [];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: DropdownButtonHideUnderline(
            child: Padding(
              padding: AppSpacer.instance.edgeInsets.x.sm,
              child: DropdownButton<String>(
                isExpanded: true,
                hint: AppText.label("Select Options"),
                items: widget.optionList.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: _bindCbView(item),
                  );
                }).toList(),
                onChanged: (String? value) {
                  _onItemSelect(!selectedOption.contains(value), value!);
                },
              ),
            ),
          ),
        ),
        AppSpacer.instance.vHs,
        Wrap(
          spacing: 8.0,
          children: selectedOption.map((item) {
            return Chip(
              label: Text(item),
              onDeleted: () => _onItemSelect(false, item),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _bindCbView(String item) {
    return StatefulBuilder(builder: (context, StateSetter setStateNew) {
      return CheckboxListTile(
        value: selectedOption.contains(item),
        title: Text(item),
        onChanged: (bool? selected) {
          setStateNew(() {
            _onItemSelect(selected!, item);
          });
        },
      );
    });
  }

  void _onItemSelect(bool selected, String item) {
    setState(() {
      if (selected && !selectedOption.contains(item)) {
        selectedOption.add(item);
      } else {
        selectedOption.remove(item);
      }
    });

    widget.onUpdateSelectedOption(selectedOption);
  }
}
