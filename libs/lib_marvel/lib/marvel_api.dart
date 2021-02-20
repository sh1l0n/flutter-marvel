//
// Created by @sh1l0n
//
// Licensed by GPLv3
// This file is part of lib_marvel package
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

  static MarvelSerieWrapper fromJson(final Map<String, dynamic> data) {
    final id = data['id'] as int;
    final title = data['title'] as String;
    final thumbnail = data['thumbnail'] as Map<String, dynamic>;
    final imagePath = thumbnail['path'] as String;
    final imageExtension = thumbnail['extension'] as String;
    final imageUrl = imagePath + '.' + imageExtension;
    return MarvelSerieWrapper(id, title, imageUrl);
  }
  
  @override
  String toString() {
    return jsonEncode(toJson());
  }
}

class MarvelCreatorWrapper extends MarvelSerieWrapper {
  const MarvelCreatorWrapper(final int id, final String title, final String imagePath) : super(id, title, imagePath);
  
  static MarvelCreatorWrapper fromJson(final Map<String, dynamic> data) {
    final id = data['id'] as int;
    final fullname = data['fullName'] as String;
    final thumbnail = data['thumbnail'] as Map<String, dynamic>;
    final imagePath = thumbnail['path'] as String;
    final imageExtension = thumbnail['extension'] as String;
    final imageUrl = imagePath + '.' + imageExtension;
    return MarvelCreatorWrapper(id, fullname, imageUrl);
  }
}

class MarvelApiWrapper {
  const MarvelApiWrapper(this.secret, this.public);
  final String secret;
  final String public;
  Map<String, dynamic> toJson() => {'secret': secret, 'public': public};

  static MarvelApiWrapper fromJson(final Map<String, dynamic> data) {
    final publicKey = data['apiKey'];
    final privateKey = data['secretKey'];
    return MarvelApiWrapper(privateKey, publicKey);
  }

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

  Future<MarvelApiWrapper> _getEnv() async {
    var completer = Completer<MarvelApiWrapper>();
    final jsonData = await rootBundle.loadString(environmentFile);
    final jsonResult = json.decode(jsonData);
    completer.complete( MarvelApiWrapper.fromJson(jsonResult) );
    return completer.future;
  }

  String get environmentFile => 'assets/env2.json';
  String get apiUrl => 'https://gateway.marvel.com:443';

  Map<String, String> get headers => {
    'content-type':	'application/json; charset=utf-8'
  };

  int generateNone() {
    return (DateTime.now().microsecondsSinceEpoch*1000);
  }

  Future<String> getHash(final MarvelApiWrapper env, final String nonce) async {
    var completer = Completer<String>();
    final hash = await md5.convert(utf8.encode(nonce + env.secret + env.public)).toString();
    completer.complete(hash);
    return completer.future;
  }

  Future<List<MarvelSerieWrapper>> getSeries(final int offset, final int limit)  async {
    var completer = Completer<List<MarvelSerieWrapper>>();

    final env = await _getEnv();
    final ts = generateNone().toString();
    final hash = await getHash(env, ts);    
    final params = 'ts=$ts&offset=$offset&limit=$limit&apikey=${env.public}&hash=$hash';
    final path = '/v1/public/series'; 
    final url = apiUrl + path + '?' + params;

    final response = await http.get(url, headers: headers);

    // ignore: omit_local_variable_types
    List<MarvelSerieWrapper> series = [];
    
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      final data = jsonData['data'] as Map<String, dynamic>;
      final results = data['results'] as List;

      results.forEach((final result) { 
        series += [MarvelSerieWrapper.fromJson(result)];
      });
    }

    completer.complete(series);
    return completer.future;
  }  

   Future<List<MarvelCreatorWrapper>> getCreators(final String serieId)  async {
    var completer = Completer<List<MarvelCreatorWrapper>>();

    final env = await _getEnv();
    
    final ts = generateNone().toString();
    final hash = await getHash(env, ts);    
    final params = 'ts=$ts&apikey=${env.public}&hash=$hash';
    final path = '/v1/public/series/$serieId/creators'; 
    final url = apiUrl + path + '?' + params;

    final response = await http.get(url, headers: headers);

    // ignore: omit_local_variable_types
    List<MarvelCreatorWrapper> creators = [];
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      final data = jsonData['data'] as Map<String, dynamic>;
      final results = data['results'] as List;
      results.forEach((final result) { 
        creators += [MarvelCreatorWrapper.fromJson(result)];
      });
    }

    completer.complete(creators);
    return completer.future;
  }  
}