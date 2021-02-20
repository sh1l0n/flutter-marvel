//
// Created by @sh1l0n
//
// Licensed by GPLv3
// This file is part of Flutter-Marvel project
//

import 'package:flutter/material.dart';

import 'drawer_bloc.dart';
import 'drawer_item.dart';


class CustomDrawerStyle {
  const CustomDrawerStyle({@required this.backgroundColor, @required this.headerHeight, @required this.headerColor, @required this.headerTextStyle, @required this.drawerItemStyle});
  final Color backgroundColor;
  final double headerHeight;
  final Color headerColor;
  final TextStyle headerTextStyle;
  final DrawerItemStyle drawerItemStyle;
}

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key key, @required this.title, @required this.bloc, @required this.style}) : super(key: key);

  final String title;
  final DrawerBLoC bloc;
  final CustomDrawerStyle style;

  Widget buildHeader() {
    return Container(
      width: double.infinity,
      height: style.headerHeight,
      color: style.headerColor,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(title, style: style.headerTextStyle),
      )
    );
  }

  Widget buildCategories() {
    return Container(
      width: double.infinity,
      height: bloc.categories.length*style.drawerItemStyle.height,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemBuilder: (final BuildContext c, final int index) {
          final cat = bloc.categories[index];
          return DrawerItem(
            isSelected: index==bloc.selected,
            title: cat.title,
            icon: cat.icon,
            style: style.drawerItemStyle,
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
        color: style.backgroundColor,
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