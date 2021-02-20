//
// Created by @sh1l0n
//
// Licensed by GPLv3
// This file is part of Flutter-Marvel project
//

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:marvel/drawer/drawer.dart';
import 'package:marvel/drawer/drawer_bloc.dart';


class BaseScaffold extends StatefulWidget {
  const BaseScaffold({Key key, @required this.drawerBLoC}) : super(key: key);
  final MarvelDrawerBLoC drawerBLoC;

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
    final title = widget.drawerBLoC.categories[widget.drawerBLoC.selected];
    return Scaffold(
      appBar:  PreferredSize(
        preferredSize: Size.fromHeight(50.0), // here the desired height
        child: AppBar(
          title: Text(title),
        ),
      ),
      drawer: MarvelDrawer(bloc: widget.drawerBLoC),
      body: buildBody(context)
    );
  }
}