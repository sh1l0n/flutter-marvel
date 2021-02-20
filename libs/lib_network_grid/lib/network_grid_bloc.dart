//
// Created by @sh1l0n
//
// Licensed by GPLv3
// This file is part of Flutter-Marvel project
//

import 'dart:async';

import 'network_grid_card.dart';

abstract class NetworkGridBLoC {

  final _getSeriesController = StreamController<bool>.broadcast();
  Stream<bool> get reloadSeriesStream => _getSeriesController.stream;
  Sink<bool> get _reloadSeriesSink => _getSeriesController.sink;

  List<NetworkGridDataWrapper> _data = [];
  List<NetworkGridDataWrapper> get data => _data;

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
    _data.clear();
    if (_reloadSeriesSink!=null) {
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
    // final series = await MarvelApi().getSeries(_currentOffset, _limit);
    // series.forEach((element) {
    //   _data.add(NetworkGridDataWrapper(element.id, element.title, element.imagePath));
    // });
    
    _isLoading = false;
    if (_reloadSeriesSink!=null) {
      _reloadSeriesSink.add(true);
    }
  }

  void dispose() {
    _getSeriesController.close();
  }
}