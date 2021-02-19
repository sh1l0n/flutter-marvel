//
// Created by @sh1l0n
//
// Licensed by GPLv3
// This file is part of Flutter-Marvel project
//

import 'package:flutter/foundation.dart';
import 'package:lib_marvel/marvel_api.dart';
import 'dart:async';

class MarvelSerieNotifier extends ValueNotifier<List<MarvelSerieWrapper>> {
  MarvelSerieNotifier() : super(null);

  List<MarvelSerieWrapper> _series = [];

  @override
  List<MarvelSerieWrapper> get value => _series;
  @override
  set value(List<MarvelSerieWrapper> newValue) {
    _series = newValue;
    notifyListeners();
  }
}

class MainScreenBLoC {

  final _getSeriesController = StreamController<List<MarvelSerieWrapper>>.broadcast();
  Stream<List<MarvelSerieWrapper>> get getSeriesStream => _getSeriesController.stream;

  List<MarvelSerieWrapper> _series = [];
  MarvelSerieNotifier _notifier = MarvelSerieNotifier();
  MarvelSerieNotifier get notifier => _notifier;

  final _limit = 20;
  int _currentOffset = 0;
  bool _isLoading = false;

  // Future<List<MarvelSerieWrapper>> getSeries(final int offset, final int limit) async {
  //   var completer = Completer<List<MarvelSerieWrapper>>();
  //   if (offset<0 || limit<=0) {
  //     completer.complete([]);
  //     return completer.future;
  //   }

  //   if (offset + limit>_series.length) {
  //     _series += await MarvelApi().getSeries(offset, limit);
  //   } 

  //   completer.complete(_series.sublist(offset, limit).toList());
  //   return completer.future;
  // }

  Future<void> reload() async {
    if (_isLoading) {
      return;
    }
    _isLoading = true;
    final series = await MarvelApi().getSeries(_currentOffset, _limit);
    _isLoading = false;
    notifier.value = series;
  }

  Future<void> getNext() async {
    if (_isLoading) {
        return;
    }
    _currentOffset += _limit;
    await reload();
  }
  
  Future<void> getLast() async {
    if (_isLoading && _currentOffset>_limit) {
        return;
    }
    _currentOffset -= _limit;
    await reload();
  }

  void dispose() {
    _getSeriesController.close();
    _notifier.dispose();
  }
}