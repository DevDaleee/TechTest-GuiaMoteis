import 'package:flutter/material.dart';
import 'package:techtest_guia_motel/services/moteis.dart';
import 'package:techtest_guia_motel/src/home/home_page.dart';

final Map<String, Widget Function(BuildContext)> namedRoutes = {
  '/home': (context) => HomePage(
        motelServices: MotelServices(),
      ),
};
