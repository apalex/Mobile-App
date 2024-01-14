import 'dart:convert';
import 'package:crypto_app/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:crypto_app/coin.dart';
import 'package:get/get.dart';

class Markets extends StatefulWidget {
  const Markets({Key? key}) : super(key: key);

  @override
  State<Markets> createState() => _MarketsState();
}

class _MarketsState extends State<Markets> {
  List<dynamic> cryptoData = [];

  @override
  void initState() {
    super.initState();
    fetchCryptoData();
  }

  Future<void> fetchCryptoData() async {
    final response = await http.get(Uri.parse('https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=50&page=1&sparkline=false'));

    if (response.statusCode == 200) {
      setState(() {
        cryptoData = json.decode(response.body);
      });
    } else {
      throw Exception("Failed to load Data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    debugShowCheckedModeBanner: false,
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
      body: Column(
        children: [
          SizedBox(
            height: 40,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 230),
                  child: const Text("Name",
                  style: TextStyle(fontSize: 19),),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 20),
                  child: const Text("Price",
                  style: TextStyle(fontSize: 19),),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cryptoData.length,
              itemBuilder: (context, index) {
                final coin = cryptoData[index];
                final name = coin['name'];
                final symbol = coin['symbol'];
                final image = coin['image'];
                final price = coin['current_price'];
                var priceChange = coin['price_change_24h'];
                var priceChangePercentage = coin['price_change_percentage_24h'];
                if (priceChange > 0) {
                  priceChange = "+${priceChange.toStringAsFixed(2)}";
                  priceChangePercentage = "+${priceChangePercentage.toStringAsFixed(2)}";
                } else {
                  priceChange = "${priceChange.toStringAsFixed(2)}";
                  priceChangePercentage = "${priceChangePercentage.toStringAsFixed(2)}";
                }
                return ListTile(
                  textColor: Colors.black,
                  leading: Image.network(image),
                  title: Text('$name - ${symbol.toUpperCase()}'),
                  subtitle: Text('24h Change: $priceChange | $priceChangePercentage%'),
                  trailing: Text('\$${price.toStringAsFixed(2)}', style: const TextStyle(fontSize: 15),),
                  onTap: () => Coin(),
                );
              }
              ),
          ),
        ],
      ),
    ),
  );
}
}
