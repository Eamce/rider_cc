import 'package:flutter/material.dart';

class Caption with ChangeNotifier {
  String _cap = 'Creating....';

  void changeCap(String data) {
    _cap = data;
    notifyListeners();
  }

  String get cap => _cap;
}
