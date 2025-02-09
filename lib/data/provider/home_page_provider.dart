import 'package:flutter/material.dart';

// ignore: constant_identifier_names
enum ScreenSwitch { IRAGORA, IROUTRODIA }

class HomePageProvider extends ChangeNotifier {
  ScreenSwitch _chooseScreen = ScreenSwitch.IRAGORA;

  bool _favorite = false;

  ScreenSwitch get chooseScreen => _chooseScreen;
  bool get favorite => _favorite;

  set favorite(bool value) {
    _favorite = value;
    notifyListeners();
  }

  set chooseScreen(ScreenSwitch value) {
    _chooseScreen = value;
    notifyListeners();
  }
}
