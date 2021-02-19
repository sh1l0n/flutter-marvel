//
// Created by @sh1l0n
//
// Licensed by GPLv3
// This file is part of Flutter-Marvel project
//


import 'package:flutter/material.dart';

import 'main_screen/main_screen_bloc.dart';
import 'main_screen/main_screen.dart';
import 'main_screen/serie_card.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  bool isBigScreen(final BuildContext c) {
    final width = MediaQuery.of(c).size.width;
    return width>600;
  }

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
              bloc: MainScreenBLoC(),
              style: MainScreenStyle(
                columns: isBigScreen(context) ? 3 : 2, 
                verticalMargin: 2.0, 
                horizontalMargin: 1.0,
                cardStyle: SerieGridCardStyle(
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
        } else {
          return MaterialPageRoute(builder: (context) => Container());
        }
      },
    );
  }
}