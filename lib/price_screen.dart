// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'coin_data.dart' as coin;
import 'package:flutter/cupertino.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({Key? key}) : super(key: key);

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  late String currentCurrency = 'AUD';
  late String BTC = '?';
  late String ETH = '?';
  late String DOGE = '?';
  List<Widget> getList() {
    List<Widget> currencyList = [];

    for (String i in coin.currenciesList) {
      Widget temp = Text(
        i,
        style: const TextStyle(
          color: Colors.white,
        ),
      );
      currencyList.add(temp);
    }
    return currencyList;
  }

  void getData(String currency) async {
    try {
      List<double> data = await coin.CoinData().getCoinData(currency: currency);
      setState(() {
        BTC = data[0].toStringAsFixed(2);
        ETH = data[1].toStringAsFixed(2);
        DOGE = data[2].toStringAsFixed(2);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getData('AUD');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              RateCard(
                Rate: BTC,
                CryptoName: 'BTC',
                CurrencyName: currentCurrency,
              ),
              RateCard(
                Rate: ETH,
                CryptoName: 'ETH',
                CurrencyName: currentCurrency,
              ),
              RateCard(
                Rate: DOGE,
                CryptoName: 'DOGE',
                CurrencyName: currentCurrency,
              ),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: CupertinoPicker(
                itemExtent: 32.0,
                onSelectedItemChanged: (item) {
                  setState(() {
                    currentCurrency = coin.currenciesList[item];
                    getData(coin.currenciesList[item]);
                  });
                },
                children: getList()),
          ),
        ],
      ),
    );
  }
}

class RateCard extends StatelessWidget {
  const RateCard({
    Key? key,
    required this.Rate,
    required this.CurrencyName,
    required this.CryptoName,
  }) : super(key: key);

  final String Rate;
  final String CryptoName;
  final String CurrencyName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            "1 $CryptoName = $Rate $CurrencyName",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

// DropdownButton<String>(
//               value: initialCurrency,
//               style: const TextStyle(
//                 color: Colors.white,
//               ),
//               dropdownColor: Colors.grey[900],
//               items: coin.currenciesList.map((String value) {
//                 return DropdownMenuItem<String>(
//                   value: value,
//                   child: Text(
//                     value,
//                   ),
//                 );
//               }).toList(),
//               onChanged: (value) {
//                 setState(() {
//                   initialCurrency = value!;
//                 });
//               },
//             ),
