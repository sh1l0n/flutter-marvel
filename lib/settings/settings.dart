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


class SettingsScreenStyle {
  const SettingsScreenStyle({@required this.textStyle});
  final TextStyle textStyle;
}

class SettingsScreen extends BaseScaffold {
  const SettingsScreen({Key key, @required this.style, @required MarvelDrawerBLoC drawerBLoC}) : super(key: key, drawerBLoC: drawerBLoC);
  
  final SettingsScreenStyle style;
  static String get route => '/settings';

  @override
  State<StatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends BaseScaffoldState {

  @override
  Widget buildBody(BuildContext context) {
    return Center(
      child: Text('Settings', style: (widget as SettingsScreen).style.textStyle),
    );
  }
}