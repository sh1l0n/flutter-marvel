//
// Created by @sh1l0n
//
// Licensed by GPLv3
// This file is part of Flutter-Marvel project
//

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:lib_drawer/drawer_bloc.dart';

import '../base_scaffold.dart';


class SettingsScreenStyle {
  const SettingsScreenStyle({@required this.textStyle});
  final TextStyle textStyle;
}

//  ##TODO: Should be Stateless not Stateful
class SettingsScreen extends BaseScaffold {
  const SettingsScreen({Key key, @required this.style, @required DrawerBLoC drawerBLoC}) : super(key: key, drawerBLoC: drawerBLoC);
  
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