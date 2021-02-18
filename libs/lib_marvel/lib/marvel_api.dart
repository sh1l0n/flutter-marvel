//
// Created by sh1l0n
//
// Licensed by GPLv3
// This file is part of Flutter-Marvel project
//

import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;


class MarvelSerieWrapper {
  const MarvelSerieWrapper(this.id, this.title, this.imagePath);
  final int id;
  final String title;
  final String imagePath;
  Map<String, dynamic> toJson() => {'id': id, 'title': title, 'imagePath': imagePath};
  @override
  String toString() {
    return jsonEncode(toJson());
  }
}

class MarvelApiWrapper {
  const MarvelApiWrapper(this.secret, this.public);
  final String secret;
  final String public;
  Map<String, dynamic> toJson() => {'secret': secret, 'public': public};
  @override
  String toString() {
    return jsonEncode(toJson());
  }
}

class MarvelApi {
  static final MarvelApi _singleton = MarvelApi._internal();
  factory MarvelApi() {
    return _singleton;
  }

  MarvelApi._internal();

  Future<MarvelApiWrapper> getEnv() async {
    var completer = Completer<MarvelApiWrapper>();
    final jsonData = await rootBundle.loadString(environmentFile);
    final jsonResult = json.decode(jsonData);
    final publicKey = jsonResult['apiKey'];
    final privateKey = jsonResult['secretKey'];
    completer.complete(MarvelApiWrapper(privateKey, publicKey));
    return completer.future;
  }

  String get environmentFile => 'assets/env.json';
  String get apiUrl => 'https://gateway.marvel.com:443';

  int generateNone() {
    return (DateTime.now().microsecondsSinceEpoch*1000);
  }

  Future<List<MarvelSerieWrapper>> getSeries(final int offset, final int limit)  async {
    var completer = Completer<List<MarvelSerieWrapper>>();

    final env = await getEnv();
    
    final ts = generateNone().toString();
    final hash = await md5.convert(utf8.encode(ts + env.secret + env.public)).toString();    
    final params = 'ts=$ts&offset=$offset&limit=$limit&apikey=${env.public}&hash=$hash';
    final path = '/v1/public/series'; 
    final url = apiUrl + path + '?' + params;

    final headers = {
      'content-type':	'application/json; charset=utf-8'
    };

    final response = await http.get(url, headers: headers);

    // ignore: omit_local_variable_types
    List<MarvelSerieWrapper> series = [];
    
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      final data = jsonData['data'] as Map<String, dynamic>;
      final results = data['results'] as List;

      results.forEach((final result) { 
        final id = result['id'] as int;
        final title = result['title'] as String;
        final thumbnail = result['thumbnail'] as Map<String, dynamic>;
        final imagePath = thumbnail['path'] as String;
        final imageExtension = thumbnail['extension'] as String;
        final imageUrl = imagePath + '.' + imageExtension;
        series += [MarvelSerieWrapper(id, title, imageUrl)];
      });
    }

    completer.complete(series);
    
    return completer.future;
  }  
}