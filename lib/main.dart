//
// Created by @sh1l0n
//
// Licensed by GPLv3
// This file is part of Flutter-Marvel project
//

import 'package:intl/intl.dart';
import 'package:intl/intl_standalone.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:lib_screens/navigator.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([]);
  await initializeLanguage();
  runApp(NavigatorManager());
}

Future<void> initializeLanguage() async {
  final String lan = (await findSystemLocale()) ?? 'en_US';
  if (lan != 'es_ES') {
    Intl.defaultLocale = 'en_US';
  } 
}