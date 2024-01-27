import 'package:flutter/material.dart';

class Coin extends StatefulWidget {
  var coin;
  Coin({this.coin});

  @override
  State<Coin> createState() => _CoinState();
}

class _CoinState extends State<Coin> {

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(4),
        child: Container(
          color: Colors.black,
          height: 2,
        ),
      ),
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Icon(Icons.arrow_back_sharp),
      ),
      title: Text(widget.coin.symbol.toUpperCase()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: _buildAppBar(context),

      ),
    );
  }
}
