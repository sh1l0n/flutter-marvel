//
// Created by @sh1l0n
//
// Licensed by GPLv3
// This file is part of Flutter-Marvel project
//

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lib_assets/location.dart';

import 'package:lib_drawer/drawer_bloc.dart';

import '../base_scaffold.dart';


class SupportScreenStyle {
  const SupportScreenStyle({@required this.textStyle});
  final TextStyle textStyle;
}


// ##TODO: Should be Stateless not Stateful
class SupportScreen extends BaseScaffold {
  const SupportScreen({Key key, @required this.style, @required DrawerBLoC drawerBLoC}) : super(key: key, drawerBLoC: drawerBLoC);
  
  final SupportScreenStyle style;
  static String get route => '/support';

  @override
  State<StatefulWidget> createState() => _SupportScreenState();
}

class _SupportScreenState extends BaseScaffoldState {

  @override
  Widget buildBody(BuildContext context) {
    return Center(
      child: Text(it(LocationId.support, true), style:  (widget as SupportScreen).style.textStyle),
    );
  }
}