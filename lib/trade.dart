import 'package:flutter/material.dart';
import 'package:crypto_app/Models/coin_model.dart';

class Trade extends StatefulWidget {
  var coin;
  Trade({this.coin});

  @override
  State<Trade> createState() => _TradeState();
}

class _TradeState extends State<Trade> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Center(
        child: Text("BTC"),
      ),
    );
  }
}
