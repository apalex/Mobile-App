import 'package:crypto_app/Models/user_model.dart';
import 'package:crypto_app/SQLite/database_helper.dart';
import 'package:crypto_app/coin_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:crypto_app/Models/coin_model.dart';

class SearchPage extends StatefulWidget {
  final User? user;
  const SearchPage({super.key, this.user});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  FocusNode focus = FocusNode();
  List? queryCoin = [];

  @override
  void initState() {
    getCoinData();
    queryCoin = coinMarket;
    super.initState();
  }

  List? coinMarket = [];
  var coinMarketList;
  Future<List<CoinModel>?> getCoinData() async {
    var response = await http.get(
        Uri.parse(
            "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&sparkline=true"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
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

  void searchFunction(String queryKeyword) {
    List? results = [];
    if (queryKeyword.isEmpty) {
      results = coinMarket;
    } else {
      results = coinMarket![0].where((element) => element["name"].toLowerCase().contains(queryKeyword.toLowerCase())).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_sharp),
        ),
        title: TextField(
          onChanged: (value) => searchFunction(value),
          focusNode: focus,
          autofocus: true,
          cursorColor: Colors.grey,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            labelStyle: TextStyle(
              color: focus.hasFocus ? Colors.black : Colors.black
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black)
            ),
            hintText: "Search",
            hintStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 20
            )
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
        child: SizedBox(
          height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.bottom,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: coinMarket!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      textColor: Colors.black,
                      leading: Image.network(coinMarket![index].image),
                      title: Text('${coinMarket![index].symbol.toUpperCase()}'),
                      trailing: Text('\$${coinMarket![index].currentPrice.toStringAsFixed(2)}', style: const TextStyle(fontSize: 15),),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Coin(coin: coinMarket![index], user: widget.user,)
                          )
                        );
                      },
                    );
                  }
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}