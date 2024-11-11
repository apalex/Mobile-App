import 'package:crypto_app/Models/user_model.dart';
import 'package:crypto_app/search.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:crypto_app/coin_view.dart';
import 'package:crypto_app/Models/coin_model.dart';

class Markets extends StatefulWidget {
  final User? user;
  const Markets({super.key, this.user});

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
  // ignore: prefer_typing_uninitialized_variables
  var coinMarketList;
  // ignore: body_might_complete_normally_nullable
  Future<List<CoinModel>?> getCoinData() async {
    var response = await http.get(
        Uri.parse(
            "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&sparkline=true"),
        headers: {
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SearchPage(
                            user: widget.user,
                          )));
            },
            style: OutlinedButton.styleFrom(
              minimumSize: Size(MediaQuery.of(context).size.height * 0.5, MediaQuery.of(context).size.height * 0.045),
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
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.575),
                    child: const Text(
                      "Name",
                      style: TextStyle(fontSize: 19),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.045),
                    child: const Text(
                      "Price",
                      style: TextStyle(fontSize: 19),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: isRefreshing == true
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : coinMarket == null || coinMarket!.isEmpty
                      ? const Center(
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Text(
                                "This App is using a free API, so you cannot send many requests in a short amount of time. Please wait a few minutes"),
                          ),
                        )
                      : ListView.builder(
                          itemCount: coinMarket!.length,
                          itemBuilder: (context, index) {
                            // ignore: prefer_typing_uninitialized_variables
                            var priceChange;
                            // ignore: prefer_typing_uninitialized_variables
                            var priceChangePercentage;
                            if (coinMarket![index].priceChange24H > 0) {
                              priceChange =
                                  "+${coinMarket![index].priceChange24H.toStringAsFixed(2)}";
                              priceChangePercentage =
                                  "+${coinMarket![index].priceChangePercentage24H.toStringAsFixed(2)}";
                            } else {
                              priceChange =
                                  "${coinMarket![index].priceChange24H.toStringAsFixed(2)}";
                              priceChangePercentage =
                                  "${coinMarket![index].priceChangePercentage24H.toStringAsFixed(2)}";
                            }
                            return ListTile(
                              textColor: Colors.black,
                              leading: Image.network(coinMarket![index].image),
                              title: Text(
                                  '${coinMarket![index].name} - ${coinMarket![index].symbol.toUpperCase()}'),
                              subtitle: Text(
                                  '24h Change: $priceChange | $priceChangePercentage%'),
                              trailing: Text(
                                '\$${coinMarket![index].currentPrice.toStringAsFixed(2)}',
                                style: const TextStyle(fontSize: 15),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Coin(
                                              coin: coinMarket![index],
                                              user: widget.user,
                                            )));
                              },
                            );
                          }),
            ),
          ],
        ),
      ),
    );
  }
}
