
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
// import 'package:http/http.dart' as http;


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

  Future<String> getSeries(final int offset, final int limit)  async {
    var completer = Completer<String>();

    final env = await getEnv();
    // md5(ts+privateKey+publicKey)
    
    final ts = '1';
    
    final hash = await md5.convert(utf8.encode(ts + env.secret + env.public)).toString();    

    final params = 'ts=$ts&offset=$offset&limit=$limit&apikey=${env.public}&hash=$hash';
    final path = '/v1/public/series'; 
    final url = apiUrl + path + '?' + params;

    final headers = {
      'content-type':	'application/json; charset=utf-8'
    };

    print('url: $url');
    // final response = await http.Client().get(url, headers: headers);
    // print(response.headers);

    // String url2 = "https://jsonplaceholder.typicode.com/posts"; 
    final response = await http.get(url, headers: headers);

    /*
      final result = results[0];
      final id = result[id] as int;
      final title = result['title'];
      final thumbnail = results['thumbnail'];

    */

    /*
    {id: 26024, title:  Superior Spider-Man Vol. 2: Otto-matic (2019), description: null, 
    resourceURI: http://gateway.marvel.com/v1/public/series/26024, urls: [{type: detail, url:
     http://marvel.com/comics/series/26024/_superior_spider-man_vol_2_otto-matic_2019?utm_campaign=apiRef&utm_source=
     00545860849df16b919db440f55b040d}], startYear: 2019, endYear: 2019, rating: , type: collection, modified: 2019-12-13T16:23:45-0500, 
     thumbnail: {path: http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available, extension: jpg}, creators: {available: 4, 
     collectionURI: http://gateway.marvel.com/v1/public/series/26024/creators, 
     items: [{resourceURI: http://gateway.marvel.com/v1/public/creators/11765, name: Christos Gage, role: writer}, 
     {resourceURI: http://gateway.marvel.com/v1/public/creators/942, name: Mike Hawthorne, role: penciller (cover)},
      {resourceURI: http://gateway.marvel.com/v1/public/creators/437, name: Lan Medina, role: penciller}, 
      {resourceURI: http://gateway.marvel.com/v1/public/creators/4430, name: Jeff Youngquist, role: editor}], returned: 4},
       characters: {available: 1, collectionURI: http://gateway.marvel.com/v1/public/series/26024/characters, 
       items: [{resourceURI: http://gateway.marvel.com/v1/public/characters/1009610, name: Spider-Man}], returned: 1}, 
       stories: {available: 2, collectionURI: http://gateway.marvel.com/v1/public/series/26024/stories, 
       items: [{resourceURI: http://gateway.marvel.com/v1/public/stories/158776, name: cover from SUPERIOR SPIDER-MAN VOL. 2 TPB (2020) #2,
        type: cover}, {resourceURI: http://gateway.marvel.com/v1/public/stories/158777, name: story from SUPERIOR SPIDER-MAN VOL. 2 TPB (2020) #2, 
        type: interiorStory}], returned: 2}, comics: {available: 1, collectionURI: http://gateway.marvel.com/v1/public/series/26024/comics, 
        items: [{resourceURI: http://gateway.marvel.com/v1/public/comics/71400, name:  Superior Spider-Man Vol. 2: Otto-matic (Trade Paperback)}], 
        returned: 1}, events: {available: 0, collectionURI: http://gateway.marvel.com/v1/public/series/26024/events, items: [], returned: 0}, 
        next: null, previous: null}

    */

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
     
      print('series: $series');
      print(results.length);
    }
    

    // final request = await HttpClient().getUrl(Uri.parse(url));
    // print('request: $request');
    // final response = await request.close();
    // print('response: $response');

    // response.transform(Utf8Decoder()).listen((final String decoded) {
    //   print('response decoded: $decoded');
    //   completer.complete('');
    //   // completer.complete([decoded]);
    // }, onError: (final Object error) {
    //   print('response error: $error');
    //   completer.complete('');
    //   // completer.completeError([]);
    // });
    
    return completer.future;
  }

  
  // const MarvelApi(this.apiKey, this.secretKey);

  // final String apiKey;
  // final String secretKey;

  //   final apiKey = '00545860849df16b919db440f55b040d';
  // final secretKey = 'ef04bcd2679c8757e96dded805e3816fd7a8e013';
  
}