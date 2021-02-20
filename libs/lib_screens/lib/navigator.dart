//
// Created by @sh1l0n
//
// Licensed by GPLv3
// This file is part of Flutter-Marvel project
//

import 'package:flutter/material.dart';

import 'package:lib_drawer/drawer_bloc.dart';
import 'package:lib_network_grid/network_grid.dart';
import 'package:lib_network_grid/network_grid_card.dart';

import 'details/details_bloc.dart';
import 'details/details_screen.dart';
import 'support/support.dart';
import 'main_screen/main_screen.dart';
import 'settings/settings.dart';


class NavigatorManager extends StatelessWidget {
  
  bool isBigScreen(final BuildContext c) {
    final width = MediaQuery.of(c).size.width;
    return width>600;
  }

  final drawerBLoC = DrawerBLoC([
    DrawerItemModel(title: 'Series', route: '/', icon: Icons.library_books),
    DrawerItemModel(title: 'Settings', route: '/settings', icon: Icons.settings),
    DrawerItemModel(title: 'Support', route: '/support', icon: Icons.support_agent),
  ]);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Marvel Series',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: MainScreen.route,
      onGenerateRoute: (final RouteSettings settings) {
        final route = settings.name;
        if (route == MainScreen.route) {
           return MaterialPageRoute(builder: (context) {
            return MainScreen(
              drawerBLoC: drawerBLoC,
              style: NetworkGridStyle(
                columns: isBigScreen(context) ? 3 : 2, 
                verticalMargin: 2.0, 
                horizontalMargin: 1.0,
                cardStyle: NetworkGridCardStyle(
                  textBackgroundColor: Color(0xee424242),
                  selectedLayerColor: Color(0x66747474),
                  textStyle: TextStyle(
                    fontSize: 18, 
                    color: Color(0xffffffff)
                  ),
                ),
              ),
            );
          });
        } else if (route == DetailsScreen.route) {
          return MaterialPageRoute(builder: (context) {
            final NetworkGridDataWrapper serie = settings.arguments;

            return DetailsScreen(
              serie: serie,
              bloc: DetailsScreenBLoC(), 
              style: DetailsScreenStyle(
                appBarColor: Color(0xff424242), 
                appBarHeight: 50, 
                backgroundColor: Color(0xff242424),
              ),
            );
          });
        } else if (route == SettingsScreen.route) {
          return MaterialPageRoute(builder: (context) {
            return SettingsScreen(
              drawerBLoC: drawerBLoC,
              style: SettingsScreenStyle(
                textStyle: TextStyle(fontSize: 22, color: Color(0xffffffff))
              )
            );
          });
        } else if (route == SupportScreen.route) {
          return MaterialPageRoute(builder: (context) {
            return SupportScreen(
              drawerBLoC: drawerBLoC,
              style: SupportScreenStyle(
                textStyle: TextStyle(fontSize: 22, color: Color(0xffffffff))
              )
            );
          });
        } else {
          return MaterialPageRoute(builder: (context) => Container());
        }
      },
    );
  }
}