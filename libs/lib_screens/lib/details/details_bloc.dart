//
// Created by @sh1l0n
//
// Licensed by GPLv3
// This file is part of lib_screens package
//

import 'dart:async';

import 'package:lib_marvel/marvel_api.dart';
import 'package:lib_network_grid/network_grid_card.dart';


class DetailsScreenBLoC {
  DetailsScreenBLoC();

  final _reloadSerieInfoController = StreamController<bool>.broadcast();
  Stream<bool> get reloadSerieInfoStream => _reloadSerieInfoController.stream;
  Sink<bool> get _reloadSerieInfoSink => _reloadSerieInfoController.sink;

  List<NetworkGridDataWrapper> _creators = [];
  List<NetworkGridDataWrapper> get creators => _creators;

  Future<void> udpateInfo(final int serieId) async {
    final creators = await MarvelApi().getCreators(serieId.toString());
    _creators.clear();
    creators.forEach((element) { 
      _creators += [NetworkGridDataWrapper(element.id, element.title, element.imagePath)];
    });

    if(_reloadSerieInfoController.hasListener && _reloadSerieInfoSink!=null) {
      _reloadSerieInfoSink.add(true);
    }
  }

  void dispose() {
    _reloadSerieInfoController.close();
  }
}