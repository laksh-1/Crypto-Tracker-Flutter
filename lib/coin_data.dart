// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  Future getCoinData({String currency = 'USD'}) async {
    late double BTC;
    late double ETH;
    late double DOGE;
    var api_key = dotenv.env["API_KEY"];
    List<double> rate = [];
    String requestURL1 =
        'http://api.coinlayer.com/live?access_key=$api_key&target=$currency';

    http.Response response1 = await http.get(Uri.parse(requestURL1));
    if (response1.statusCode == 200) {
      var decodedData1 = jsonDecode(response1.body);
      BTC = decodedData1['rates']['BTC'];
      ETH = decodedData1['rates']['ETH'];
      DOGE = decodedData1['rates']['DOGE'];
      rate.add(BTC);
      rate.add(ETH);
      rate.add(DOGE);
      // print(rate);
      // return rate;
    } else {
      // print(response1.statusCode);
      throw 'Problem with the get request';
    }
  }
}
