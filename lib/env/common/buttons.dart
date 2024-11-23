import 'package:flutter/material.dart';

class LargeButton extends StatelessWidget {
  const LargeButton({
    super.key,
    required this.text,
    required this.action,
  });

  final String text;
  final VoidCallback action;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: theme.colorScheme.secondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 0,
        minimumSize: Size(double.infinity, 60),
      ),
      onPressed: action,
      child: Text(
        text,
        style: theme.textTheme.labelLarge?.copyWith(
          color: theme.colorScheme.onSecondary,
          fontSize: 20,
        ),
      ),
    );
  }
}
