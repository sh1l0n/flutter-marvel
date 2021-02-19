//
// Created by @sh1l0n
//
// Licensed by GPLv3
// This file is part of Flutter-Marvel project
//

import 'package:flutter/material.dart';
import 'package:marvel/drawer/drawer_bloc.dart';

import 'drawer_item.dart';


class MarvelDrawer extends StatelessWidget {
  const MarvelDrawer({Key key, @required this.bloc}) : super(key: key);

  final MarvelDrawerBLoC bloc;

  Widget buildHeader() {
    final fontSize = 30;
    return Container(
      width: double.infinity,
      height: 50,
      color: Color(0xffa3a3a3),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text('Flutter Marvel'),
      )
    );
  }

  Widget buildCategories() {
    return Container(
      width: double.infinity,
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemBuilder: (final BuildContext c, final int index) {
          final title = bloc.categories[index];
          final extra = bloc.selected==index ? 'SEL' : '';
          return DrawerItem(
            title: title + extra,
            onTap: () {
              bloc.selectCategory(c, index);
            }
          );
        },
        itemCount: bloc.categories.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color(0xff242424),
        child: Column(
          children: [
            buildHeader(),
            buildCategories(),
          ],
        ),
      )
    );
  }
}