//
// Created by @sh1l0n
//
// Licensed by GPLv3
// This file is part of Flutter-Marvel project
//


import 'package:flutter/material.dart';
import 'package:marvel/main_screen/main_screen_bloc.dart';

import 'main_screen/main_screen.dart';


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

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final isBigScreen = width>600;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: Container(),
      ),
      body: Center(
          child: MainScreen(
            bloc: mainScreenBloC,
            style: MainScreenStyle(columns: isBigScreen ? 3 : 2, verticalMargin: 2.0, horizontalMargin: 1.0),
            ),
      ),
    );
  }
}
