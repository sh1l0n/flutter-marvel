//
// Created by @sh1l0n
//
// Licensed by GPLv3
// This file is part of Flutter-Marvel project
//


import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:lib_screens/navigator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeLanguage();
  runApp(NavigatorManager());
}

Future<void> initializeLanguage() async {
  Intl.defaultLocale = 'en_US';
  // if (Intl.defaultLocale.split('_')[0] != 'es') {
  //   Intl.defaultLocale = 'en_US';
  // } else {
  //   Intl.defaultLocale = 'es';
  // }
}