//
// Created by sh1l0n
//
// Licensed by GPLv3
// This file is part of Flutter-Marvel project
//

import 'package:lib_marvel/marvel_api.dart';
import 'dart:async';

class MainScreenBLoC {

  final _getSeriesController = StreamController<List<MarvelSerieWrapper>>.broadcast();
  Stream<List<MarvelSerieWrapper>> get getSeriesStream => _getSeriesController.stream;

  Future<List<MarvelSerieWrapper>> getSeries(final int offset, final int limit) async {
    var completer = Completer<List<MarvelSerieWrapper>>();
    if (offset<0 || limit<=0) {
      completer.complete([]);
      return completer.future;
    }

    if (offset + limit>_series.length) {
      _series += await MarvelApi().getSeries(offset, limit);
    } 

    completer.complete(_series.sublist(offset, limit).toList());
    return completer.future;
  }

  List<MarvelSerieWrapper> _series = [];

  void dispose() {
    _getSeriesController.close();
  }
}