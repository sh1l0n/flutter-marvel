//
// Created by @sh1l0n
//
// Licensed by GPLv3
// This file is part of Flutter-Marvel project
//

import 'package:flutter/foundation.dart';
import 'package:lib_marvel/marvel_api.dart';
import 'dart:async';


class MainScreenBLoC {

  final _getSeriesController = StreamController<bool>.broadcast();
  Stream<bool> get reloadSeriesStream => _getSeriesController.stream;
  Sink<bool> get _reloadSeriesSink => _getSeriesController.sink;

  List<MarvelSerieWrapper> _series = [];
  List<MarvelSerieWrapper> get series => _series;
  // MarvelSerieNotifier _notifier = MarvelSerieNotifier();
  // MarvelSerieNotifier get notifier => _notifier;

  final _limit = 20;
  int _currentOffset = 0;
  bool _isLoading = false;


  Future<void> reset() async {
    if (_isLoading) {
      return;
    }
    _currentOffset = 0;
    _series.clear();
    if (_reloadSeriesSink!=null) {
      _reloadSeriesSink.add(true);
    }
    await _reload();
  }

  Future<void> _reload() async {
    if (_isLoading) {
      return;
    }
    _isLoading = true;
    final series = await MarvelApi().getSeries(_currentOffset, _limit);
    _series.addAll(series);
    _isLoading = false;
    if (_reloadSeriesSink!=null) {
      _reloadSeriesSink.add(true);
    }
  }

  Future<void> getNext() async {
    if (_isLoading) {
        return;
    }
    _currentOffset += _limit;
    await _reload();
  }
  
  Future<void> getLast() async {
    if (_isLoading && _currentOffset>_limit) {
        return;
    }
    _currentOffset -= _limit;
    await _reload();
  }

  void dispose() {
    _getSeriesController.close();
  }
}