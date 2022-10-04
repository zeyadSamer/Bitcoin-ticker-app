import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;
import 'dart:math';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();


}

class _PriceScreenState extends State<PriceScreen> {



  String selectedCurrency ='USD';
  String cryptoCurrency='BTC';
  int rate=19020;
  List<Widget> cryptoCards=[];

Future <List> getCryptoCards({String cryptoCurrency='USD'})async{


  CoinData coinData=CoinData(currency: cryptoCurrency);
   var coinInfo= await coinData.getCoinData();


   print('coinInfo:$coinInfo');


   return  cryptoList.map((cryptoCoin){

    rate=coinInfo[cryptoCoin]['rate'].toInt();

    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child:Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 ${cryptoCoin} = ${rate} ${selectedCurrency}',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }).toList();

}



  DropdownButton<String> androidDropDown(){

    List dropDownMenuItems= currenciesList.map((currency) {
      return DropdownMenuItem(child: Text(currency), value: currency);

    }).toList();

    return DropdownButton<String>(


        menuMaxHeight: 300,
        value: selectedCurrency,
        onChanged: (value) async{



          selectedCurrency = value;
          cryptoCards=await getCryptoCards(cryptoCurrency:value);

          setState((){


          });



        },
        items:dropDownMenuItems

    );
  }

  CupertinoPicker iosPicker(){

    List pickerItems=currenciesList.map((currency) {
      return Text(currency);

    }).toList();

    return  CupertinoPicker(
      itemExtent: 32,
      onSelectedItemChanged: (selectedIndex){
        setState(() {
          selectedCurrency=currenciesList[selectedIndex];
        });

      },
      children: pickerItems,
    );

  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,


        children:<Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children:cryptoCards,
          ),

            Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child:Platform.isAndroid?androidDropDown():iosPicker()
            ),
        ]
      ),
    );
  }
}


