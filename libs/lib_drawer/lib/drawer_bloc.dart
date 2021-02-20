//
// Created by @sh1l0n
//
// Licensed by GPLv3
// This file is part of Flutter-Marvel project
//

import 'package:flutter/material.dart';


class DrawerItemModel {
  const DrawerItemModel({@required this.title, @required this.route, @required this.icon});
  final String title;
  final String route;
  final IconData icon;
}

class DrawerBLoC {

  DrawerBLoC(final List<DrawerItemModel> items) {
    // ignore: omit_local_variable_types
    for(int i=0; i<items.length; i++) {
      _categories[i] = items[i];
    }
  }

  final Map<int, DrawerItemModel> _categories = {};
  Map<int, DrawerItemModel> get categories => _categories;

  int _selected = 0;
  int get selected => _selected;

  void selectCategory(final BuildContext context, final int id) {
    if (categories.containsKey(id) && selected!=id && categories.containsKey(id)) {
      _selected = id;
      Navigator.pushNamed(context, categories[selected].route);
    }
  }
}