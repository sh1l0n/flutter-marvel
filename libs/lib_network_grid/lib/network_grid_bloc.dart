//
// Created by @sh1l0n
//
// Licensed by GPLv3
// This file is part of Flutter-Marvel project
//

import 'dart:async';

import 'network_grid_card.dart';

abstract class NetworkGridBLoC {

  final _reloadSeriesController = StreamController<bool>.broadcast();
  Stream<bool> get reloadSeriesStream => _reloadSeriesController.stream;
  Sink<bool> get _reloadSeriesSink => _reloadSeriesController.sink;

  List<NetworkGridDataWrapper> _data = [];
  List<NetworkGridDataWrapper> get data => _data;

  int _currentOffset = 0;
  int get currentOffset => _currentOffset;

  bool _isLoading = false;
  int get limit => 20;
  int get scrollThreshold => (limit*0.4).round();

  Future<void> shouldUpdate(final int scrollIndex) async {
    final shouldUpdate = limit - scrollIndex - _currentOffset <= scrollThreshold;
    if (shouldUpdate) {
      _currentOffset += limit;
      await _reload(force: true);
    }
  }

  Future<void> reset({bool force = false}) async {
    if (_isLoading && !force) {
      return;
    }
    _currentOffset = 0;
    _data.clear();
    
    
    if (_reloadSeriesController.hasListener && _reloadSeriesSink!=null) {
      _reloadSeriesSink.add(true);
    }
    await _reload();
  }

  Future<List<NetworkGridDataWrapper>> reload();

  Future<void> _reload({bool force = false}) async {
    if (_isLoading && !force) {
      return;
    }
    _isLoading = true;
    _data.addAll(await reload());
    _isLoading = false;
    if (_reloadSeriesController.hasListener && _reloadSeriesSink!=null) {
      _reloadSeriesSink.add(true);
    }
  }

  void dispose() {
    _reloadSeriesController.close();
  }
}