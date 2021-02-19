//
// Created by @sh1l0n
//
// Licensed by GPLv3
// This file is part of Flutter-Marvel project
//


import 'package:flutter/material.dart';
import 'package:marvel/main_screen/main_screen_bloc.dart';

import 'drawer/drawer.dart';
import 'drawer/drawer_bloc.dart';
import 'main_screen/main_screen.dart';
import 'main_screen/serie_card.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Marvel Series',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Marvel Series'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final mainScreenBloC = MainScreenBLoC();
  final drawerBLoC = MarvelDrawerBLoC();

  bool isBigScreen(final BuildContext c) {
    final width = MediaQuery.of(context).size.width;
    return width>600;
  }

  MainScreenStyle getMainScreenStyle(final BuildContext c) {
    return MainScreenStyle(
      columns: isBigScreen(c) ? 3 : 2, 
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
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar:  PreferredSize(
          preferredSize: Size.fromHeight(50.0), // here the desired height
          child: AppBar(
            title: Text(widget.title),
        ),
      ),
      drawer: MarvelDrawer(bloc: drawerBLoC),
      body: Center(
        child: MainScreen(
          bloc: mainScreenBloC,
          style: getMainScreenStyle(context),
        ),
      ),
    );
  }
}
