
import 'dart:convert';
import 'package:flutter/services.dart';

class MarvelApi {

  MarvelApi() {
    _initialize();
  }

  void _initialize() async {
    final jsonData = await rootBundle.loadString(environmentFile);
    final jsonResult = json.decode(jsonData);
    _publicKey = jsonResult['apiKey'];
    _privateKey = jsonResult['secretKey'];
    print(_publicKey);
    print(_privateKey);
  }

  String get environmentFile => 'assets/env.json';
  String _publicKey = '';
  String _privateKey = '';


  
  // const MarvelApi(this.apiKey, this.secretKey);

  // final String apiKey;
  // final String secretKey;

  //   final apiKey = '00545860849df16b919db440f55b040d';
  // final secretKey = 'ef04bcd2679c8757e96dded805e3816fd7a8e013';
  
}