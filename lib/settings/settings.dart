//
// Created by @sh1l0n
//
// Licensed by GPLv3
// This file is part of Flutter-Marvel project
//

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../base_scaffold.dart';
import '../drawer/drawer_bloc.dart';


class SettingsScreen extends BaseScaffold {
  const SettingsScreen({Key key, @required MarvelDrawerBLoC drawerBLoC}) : super(key: key, drawerBLoC: drawerBLoC);
  static String get route => '/settings';

  @override
  State<StatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends BaseScaffoldState {

  @override
  Widget buildBody(BuildContext context) {
    return Center(
      child: Text('Settings'),
    );
  }
}