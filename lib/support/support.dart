//
// Created by @sh1l0n
//
// Licensed by GPLv3
// This file is part of Flutter-Marvel project
//

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../drawer/drawer.dart';
import '../drawer/drawer_bloc.dart';


class SupportScreen extends StatefulWidget {
  const SupportScreen({Key key, @required this.drawerBLoC}) : super(key: key);
  final MarvelDrawerBLoC drawerBLoC;

  static String get route => '/support';

  @override
  State<StatefulWidget> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  PreferredSize(
        preferredSize: Size.fromHeight(50.0), // here the desired height
        child: AppBar(
          title: Text('Marvel Flutter'),
        ),
      ),
      drawer: MarvelDrawer(bloc: widget.drawerBLoC),
      body: Center(
        child: Text('Support'),
      ),
    );
  }
}