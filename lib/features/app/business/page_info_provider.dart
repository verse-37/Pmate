import 'package:flutter/material.dart';

class PageInfoProvider extends ChangeNotifier {
  String _title = "";
  List<Widget> _actions = [];

  String get title => _title;
  void setTitle(String title) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _title = title;
      notifyListeners();
    });
  }

  List<Widget> get actions => _actions;
  void setActions(List<Widget> actions) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _actions = actions;
      notifyListeners();
    });
  }
}
