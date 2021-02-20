//
// Created by @sh1l0n
//
// Licensed by GPLv3
// This file is part of Flutter-Marvel project
//

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:lib_drawer/drawer_bloc.dart';
import 'package:lib_drawer/drawer.dart';
import 'package:lib_drawer/drawer_item.dart';


class BaseScaffold extends StatefulWidget {
  const BaseScaffold({Key key, @required this.drawerBLoC}) : super(key: key);
  final DrawerBLoC drawerBLoC;

  static String get route => '/';

  @override
  State<StatefulWidget> createState() => BaseScaffoldState();
}

class BaseScaffoldState extends State<BaseScaffold> {

  Widget buildBody(final BuildContext context) {
    return Container();
  }

  @override
  Widget build(final BuildContext context) {
    final title = widget.drawerBLoC.categories[widget.drawerBLoC.selected].title;

    return Scaffold(
      appBar:  PreferredSize(
        preferredSize: Size.fromHeight(50.0), // here the desired height
        child: AppBar(
          backgroundColor: Color(0xff424242),
          title: Text(title),
        ),
      ),
      drawer: CustomDrawer(
        bloc: widget.drawerBLoC,
        title: 'Marvel Flutter',
        style: CustomDrawerStyle(
          backgroundColor: Color(0xff424242),
          headerColor: Color(0xff242424),
          headerHeight: 50,
          headerTextStyle: TextStyle(fontSize: 24, color: Color(0xffffffff)),
          drawerItemStyle: DrawerItemStyle(
            textStyle: TextStyle(fontSize: 18, color: Color(0xffffffff)), 
            height: 50, 
            marginBetweenIconText: 5, 
            selectedColor: Color(0xff727272),
          ),
        )
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color(0xff242424),
        child: buildBody(context),
      )
    );
  }
}