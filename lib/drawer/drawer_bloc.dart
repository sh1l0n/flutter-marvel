//
// Created by @sh1l0n
//
// Licensed by GPLv3
// This file is part of Flutter-Marvel project
//

import 'package:flutter/material.dart';

class MarvelDrawerBLoC {
  final Map<int, String> categories = {
    0: 'Series',
    1: 'Settings',
    2: 'Support'
  };

  final Map<int, String> routes = {
    0: '/',
    1: '/settings',
    2: '/support'
  };

  int _selected = 0;
  int get selected => _selected;

  void selectCategory(final BuildContext context, final int id) {
    if (categories.containsKey(id) && selected!=id && routes.containsKey(id)) {
      _selected = id;
      Navigator.pushNamed(context, routes[selected]);
    }
  }
}