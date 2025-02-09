import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:techtest_guia_motel/models/item_model.dart';

enum ScreenSwitch { iragora, iroutrodia }

class HomePageProvider extends ChangeNotifier {
  ScreenSwitch _chooseScreen = ScreenSwitch.iragora;

  ScreenSwitch get chooseScreen => _chooseScreen;

  set chooseScreen(ScreenSwitch value) {
    _chooseScreen = value;
    notifyListeners();
  }

  List<IconData> mapItemsToIcons(List<ItemModel> items) {
    if (items.isEmpty) {
      return [Icons.error, Icons.error, Icons.keyboard_arrow_down];
    }

    final Map<String, IconData> iconMap = {
      'tv a cabo': Icons.tv,
      "tv led 32''": Icons.tv,
      'iluminação por leds': Icons.lightbulb,
      'garagem coletiva': FontAwesomeIcons.warehouse,
      'som am/fm': FontAwesomeIcons.radio,
      '3 canais eróticos': FontAwesomeIcons.lock,
      'bluetooth': FontAwesomeIcons.bluetooth,
      'espelho no teto': FontAwesomeIcons.square,
      'ducha dupla': FontAwesomeIcons.shower,
      'acesso à suíte via escadas': FontAwesomeIcons.personWalking,
      'banheira de hidromassagem': FontAwesomeIcons.hotTubPerson,
      'frigobar': FontAwesomeIcons.snowflake,
      'wi-fi': FontAwesomeIcons.wifi,
      'ar-condicionado split': FontAwesomeIcons.wind,
      'secador de cabelo': FontAwesomeIcons.hotjar,
    };

    Set<IconData> iconSet = {};
    Random random = Random();

    List<String> shuffledItems =
        List.from(items.map((e) => e.name!.toLowerCase()))..shuffle(random);

    for (var name in shuffledItems) {
      if (iconMap.containsKey(name)) {
        if (iconSet.add(iconMap[name]!) && iconSet.length == 2) break;
      }
    }

    List<IconData> icons = iconSet.toList();

    while (icons.length < 2) {
      icons.add(FontAwesomeIcons.question);
    }

    icons.add(Icons.keyboard_arrow_down); // "Ver todos"

    return icons;
  }
}
