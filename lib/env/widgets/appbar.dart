import 'package:flutter/material.dart';

class PmateAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// A universal app bar for Pmate.
  /// PreferredSizeWidget interface is implemented to set the preferred size to the standard height of an app bar.

  const PmateAppBar({
    super.key,
    required this.title,
    this.actions = const [],
  });

  final String title;
  final List<Widget> actions;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      title: Text(
        title,
        style: theme.textTheme.displaySmall,
      ),
      backgroundColor: theme.colorScheme.primaryContainer,
      actions: actions,
    );
  }
}
