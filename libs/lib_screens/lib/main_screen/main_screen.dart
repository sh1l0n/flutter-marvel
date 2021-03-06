//
// Created by @sh1l0n
//
// Licensed by GPLv3
// This file is part of lib_screens package
//

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:lib_assets/location.dart';
import 'package:lib_drawer/drawer_bloc.dart';
import 'package:lib_network_grid/network_grid.dart';
import 'package:lib_network_grid/network_grid_card.dart';

import '../base_scaffold.dart';
import '../details/details_screen.dart';
import 'marvel_grid_refreshing_bloc.dart';


class MainScreen extends BaseScaffold {
  const MainScreen({Key key, @required this.bloc, @required DrawerBLoC drawerBLoC, @required this.style}) : super(key: key, drawerBLoC: drawerBLoC);
  final NetworkGridStyle style;
  final MarvelGridRefreshingBLoC bloc;

  static String get route => '/';

  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends BaseScaffoldState {  
  @override
  Widget buildBody(final BuildContext context) {
    return NetworkGrid(
      placeholder: it(LocationId.pullToRefresh),
      bloc: (widget as MainScreen).bloc, 
      style: (widget as MainScreen).style,
      onTap: (final NetworkGridDataWrapper serie) {
         Navigator.pushNamed(context, DetailsScreen.route, arguments: serie);
      }
    );
  }
}