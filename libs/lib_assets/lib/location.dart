//
// Created by @sh1l0n
//
// Licensed by GPLv3
// This file is part of lib_assets package
//

import 'package:intl/intl.dart';


enum LocationId {
  series,
  settings,
  support,
  pullToRefresh
}

String it(final LocationId id, [bool capitalizeFirst = false]) {
  final _it = _translations[id][Intl.defaultLocale];
  final _filteredIt = _it[0].toUpperCase() + _it.substring(1, _it.length);
  return _filteredIt;
}

final Map<LocationId, Map<String, String>> _translations = {
  LocationId.series: {
    'en_US': 'series',
    'es': 'series'
  },
  LocationId.settings: {
    'en_US': 'settings',
    'es': 'opciones'
  },
  LocationId.support: {
    'en_US': 'support',
    'es': 'soporte'
  },
  LocationId.pullToRefresh: {
    'en_US': 'Pull To Refresh',
    'es': 'Tire para refrescar'
  }
};