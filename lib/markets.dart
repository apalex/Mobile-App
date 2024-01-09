import 'package:crypto_app/main.dart';
import 'package:flutter/material.dart';
import 'package:crypto_app/coin.dart';
import 'package:get/get.dart';

class Markets extends StatefulWidget {
  const Markets({Key? key}) : super(key: key);

  @override
  State<Markets> createState() => _MarketsState();
}

class _MarketsState extends State<Markets> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: OutlinedButton.icon(
            onPressed: () {
              showSearch(context: context, delegate: CustomSearchDelegate());
            },
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(380, 35),
              foregroundColor: Colors.grey,
              padding: const EdgeInsets.all(6),
              alignment: Alignment.centerLeft,
            ),
            icon: const Icon(Icons.search), 
            label: const Text("Search"),
            ),
          centerTitle: true,
      ),
      body: OutlinedButton(onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => Coin()));
      }, child: const Text("Bitcoin")),
    ),
  );
}
}
