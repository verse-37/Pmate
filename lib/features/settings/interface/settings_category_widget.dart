import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:logger/logger.dart';
import 'package:pmate/features/settings/interface/settings_subpage_page.dart';
import 'package:pmate/features/settings/models/subpage_info.dart';

class SettingsCategoryDisplay extends StatelessWidget {
  const SettingsCategoryDisplay({
    super.key,
    required this.name,
    required this.subpagesList,
  });

  final String name;
  final List<SubpageInfo> subpagesList;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(name),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children:
                subpagesList.map((e) => SettingsSubpageDisplay(e)).toList(),
          ),
        ),
      ],
    );
  }
}
