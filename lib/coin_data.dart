import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;


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

const String apiKey='BE7F3947-381C-4BE6-B0B0-F6D9C4695D9E';
const String baseUrl='https://rest.coinapi.io/v1/exchangerate';



class CoinData {
  
  String currency;

  Map<String,dynamic> cryptoCurrencyDataList={

  };

  CoinData( { @required this.currency});




  Future getCoinData() async{

    for(String cryptoCurrency in cryptoList){
      Uri url = Uri.parse(
          '$baseUrl/${cryptoCurrency}/${currency}?apikey=${apiKey}');

      var response = await http.get(url);

      var data = jsonDecode(response.body);

      cryptoCurrencyDataList['$cryptoCurrency'] = data;
      print(cryptoCurrencyDataList[cryptoCurrency] );

  }


    return cryptoCurrencyDataList;


  }





}















