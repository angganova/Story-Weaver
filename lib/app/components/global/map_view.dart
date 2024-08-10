import 'package:flutter/material.dart';
import 'package:story_weaver/system/global_extension.dart';
import 'package:story_weaver/system/global_style.dart';

import '../list_item/list_tile.dart';
import '../text/basic_text.dart';

class MapView extends StatelessWidget {
  const MapView({super.key, this.map});

  final Map<String, dynamic>? map;

  @override
  Widget build(BuildContext context) {
    if (map != null && map!.isNotEmpty) {
      return _bindDataObjectView(map);
    } else {
      return Container();
    }
  }

  Widget _bindDataObjectView(Map<String, dynamic>? json) {
    if (json == null) {
      return Container();
    } else {
      return ListView(
        children: json.entries
            .map((entry) => _bindDataObjectItemView(entry))
            .toList(),
      );
    }
  }

  Widget _bindDataObjectItemView(dynamic entry) {
    if (entry.value.toString().isNullOrEmpty) {
      return Container();
    }

    final dynamic value = entry.value;
    if (value is List) {
      if (value.isEmpty) {
        return Container();
      } else if (value.first is String || value.first is num) {
        return Padding(
          padding: AppSpacer.instance.edgeInsets.symmetric(x: 'sm', y: 's'),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.sectionHeader(
                entry.key.toString().splitCamelCase.capsWords,
                color: AppColors.textPrimary,
              ),
              AppSpacer.instance.vHxxs,
              Wrap(
                spacing: 8.0,
                children: value.map(
                  (opt) {
                    return Chip(
                      label: AppText.paragraph(
                        opt ?? '',
                        fontWeight: FontWeight.w500,
                      ),
                    );
                  },
                ).toList(),
              ),
              AppSpacer.instance.vHsm,
              Container(
                width: AppQuery.instance.width,
                color: AppColors.borderBlack,
                height: 1,
              )
            ],
          ),
        );
      }
    } else if (value is Map<String, dynamic>) {
      return Column(
        children:
            value.entries.map((item) => _bindDataObjectItemView(item)).toList(),
      );
    }

    return AppListTile.titleSubtitle(
      title: entry.key.toString().splitCamelCase.capsWords,
      subtitle: value.toString().splitCamelCase.capsSentences,
      withDivider: true,
    );
  }
}
