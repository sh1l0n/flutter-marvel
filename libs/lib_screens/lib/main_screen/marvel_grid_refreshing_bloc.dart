//
// Created by @sh1l0n
//
// Licensed by GPLv3
// This file is part of Flutter-Marvel project
//

import 'package:lib_marvel/marvel_api.dart';
import 'dart:async';

import 'package:lib_network_grid/network_grid_bloc.dart';
import 'package:lib_network_grid/network_grid_card.dart';


class MarvelGridRefreshingBLoC extends NetworkGridBLoC {
  @override
  Future<List<NetworkGridDataWrapper>> reload() async {
    var completer = Completer<List<NetworkGridDataWrapper>>();
    final List<NetworkGridDataWrapper> data =  [];
    final series = await MarvelApi().getSeries(currentOffset, limit);
    series.forEach((element) {
      data.add(NetworkGridDataWrapper(element.id, element.title, element.imagePath));
    });
    completer.complete(data);
    return completer.future;
  }
}