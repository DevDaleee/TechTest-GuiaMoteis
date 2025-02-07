import 'package:flutter/material.dart';

enum ScreenSwitch { iragora, iroutrodia }

class HomePageProvider extends ChangeNotifier {
  ScreenSwitch _chooseScreen = ScreenSwitch.iragora;

  ScreenSwitch get chooseScreen => _chooseScreen;

  set chooseScreen(ScreenSwitch value) {
    _chooseScreen = value;
    notifyListeners();
  }
}
