import 'package:flutter/material.dart';

class SubpageInfo {
  final String name;
  final IconData icon;
  final String route;
  final Widget page;

  const SubpageInfo({
    required this.name,
    required this.icon,
    required this.route,
    required this.page,
  });
}
