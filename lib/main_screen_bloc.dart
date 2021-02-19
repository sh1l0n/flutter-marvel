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

  int _currentOffset = 0;
  bool _isLoading = false;
  int get _limit => 20;
  int get scrollThreshold => (_limit*0.4).round();

  Future<void> shouldUpdate(final int scrollIndex) async {
    final shouldUpdate = _limit - scrollIndex - _currentOffset <= scrollThreshold;
    if (shouldUpdate) {
      _currentOffset += _limit;
      await _reload(force: true);
    }
  }


  Future<void> reset({bool force = false}) async {
    if (_isLoading && !force) {
      return;
    }
    _currentOffset = 0;
    _series.clear();
    if (_reloadSeriesSink!=null) {
      _reloadSeriesSink.add(true);
    }
    await _reload();
  }

  Future<void> _reload({bool force = false}) async {
    if (_isLoading && !force) {
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

  void dispose() {
    _getSeriesController.close();
  }
}