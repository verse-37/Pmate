import 'package:flutter/material.dart';

abstract class PmatePage {
  String get routeName;
  String get routePath;
  void init(BuildContext context);
}
