//
// Created by @sh1l0n
//
// Licensed by GPLv3
// This file is part of Flutter-Marvel project
//

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lib_marvel/marvel_api.dart';
import 'package:marvel/main_screen_bloc.dart';

import 'main_screen.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  final series = await MarvelApi().getSeries(0, 20);
  print('series: $series');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: MainScreen(
            bloc: MainScreenBLoC(),
            style: MainScreenStyle(columns: 2, verticalMargin: 2.0, horizontalMargin: 1.0),
            ),
      ),
    );
  }
}
