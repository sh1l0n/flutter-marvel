//
// Created by @sh1l0n
//
// Licensed by GPLv3
// This file is part of Flutter-Marvel project
//

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:lib_drawer/drawer_bloc.dart';
import 'package:marvel/main_screen/marvel_grid_refreshing_bloc.dart';

import 'package:lib_network_grid/network_grid.dart';

import '../base_scaffold.dart';


class MainScreen extends BaseScaffold {
  const MainScreen({Key key, @required DrawerBLoC drawerBLoC, @required this.style}) : super(key: key, drawerBLoC: drawerBLoC);
  final NetworkGridStyle style;

  static String get route => '/';

  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends BaseScaffoldState {

  MarvelGridRefreshingBLoC bloc;
  NetworkGridStyle get style => (widget as MainScreen).style;
  
  @override
  void initState() {
    super.initState();
    bloc = MarvelGridRefreshingBLoC();
  }

  @override
  Widget buildBody(final BuildContext context) {
    return NetworkGrid(bloc: bloc, style: style);
  }
}