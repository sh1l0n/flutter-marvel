
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
// import 'package:http/http.dart' as http;


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
    print(response.body); 

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