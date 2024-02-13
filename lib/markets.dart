import 'package:crypto_app/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:crypto_app/coin_view.dart';
import 'package:crypto_app/Models/coin_model.dart';

class Markets extends StatefulWidget {
  const Markets({Key? key}) : super(key: key);

  @override
  State<Markets> createState() => _MarketsState();
}

class _MarketsState extends State<Markets> {
  bool isRefreshing = true;

  @override
  void initState() {
    getCoinData();
    super.initState();
  }

  List? coinMarket = [];
  var coinMarketList;
  Future<List<CoinModel>?>  getCoinData() async {
    var response = await http.get(Uri.parse("https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&sparkline=true"), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
    });
    setState(() {
      isRefreshing = false;
    });
    if (response.statusCode == 200) {
      var x = response.body;
      coinMarketList = coinModelFromJson(x);
      setState(() {
        coinMarket = coinMarketList;
      });
    } else {
      print(response.statusCode);
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
              showSearch(context: context, delegate: SearchFeature());
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
            child: isRefreshing == true
            ? const Center(
              child: CircularProgressIndicator(),
            ) : coinMarket == null || coinMarket!.isEmpty ? const Center(child: Padding(
              padding: EdgeInsets.all(20),
              child: Text("This App is using a free API, so you cannot send many requests in a short amount of time. Please wait a few minutes"),
            ),)
            : ListView.builder(
              itemCount: coinMarket!.length,
              itemBuilder: (context, index) {
                var priceChange;
                var priceChangePercentage;
                if (coinMarket![index].priceChange24H > 0) {
                  priceChange = "+${coinMarket![index].priceChange24H.toStringAsFixed(2)}";
                  priceChangePercentage = "+${coinMarket![index].priceChangePercentage24H.toStringAsFixed(2)}";
                } else {
                  priceChange = "${coinMarket![index].priceChange24H.toStringAsFixed(2)}";
                  priceChangePercentage = "${coinMarket![index].priceChangePercentage24H.toStringAsFixed(2)}";
                }
                return ListTile(
                  textColor: Colors.black,
                  leading: Image.network(coinMarket![index].image),
                  title: Text('${coinMarket![index].name} - ${coinMarket![index].symbol.toUpperCase()}'),
                  subtitle: Text('24h Change: $priceChange | $priceChangePercentage%'),
                  trailing: Text('\$${coinMarket![index].currentPrice.toStringAsFixed(2)}', style: const TextStyle(fontSize: 15),),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Coin(coin: coinMarket![index],)
                      )
                    );
                  },
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
