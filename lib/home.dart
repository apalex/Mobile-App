import 'package:crypto_app/home_featured.dart';
import 'package:crypto_app/home_recommended.dart';
import 'package:crypto_app/search.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:crypto_app/notifications.dart';
import 'package:crypto_app/Models/user_model.dart';
import 'package:crypto_app/SQLite/database_helper.dart';
import 'package:crypto_app/Models/coin_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:crypto_app/profile.dart';

class Home extends StatefulWidget {
  final User? user;
  const Home({super.key, this.user});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late DatabaseHelper handler;
  late Future<List<User>> users;
  final db = DatabaseHelper();
  bool isRefreshing = true;
  final List<String> imgList = [
    'https://assets.bitdegree.org/crypto/storage/media/Future-of-Bitcoin.o.jpg',
    'https://academy.moralis.io/wp-content/uploads/2022/09/22_09_Ethereum-Post-Merge-Future-of-Ethereum-1-1.jpg',
    'https://upload.wikimedia.org/wikipedia/commons/b/b8/Cryptocurrency_logos.jpg'
  ];

  @override
  void initState() {
    handler = DatabaseHelper();
    users = handler.getUsers();
    getCoinData();
    handler.open().whenComplete(() {
      users = getAllUsers();
    });
    super.initState();
  }

  Future<List<User>> getAllUsers() {
    return handler.getUsers();
  }

  Future<void> _refresh() async {
    setState(() {
      users = getAllUsers();
    });
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
      // ignore: avoid_print
      print(response.statusCode);
    }
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text("Mintless"),
      actions: <Widget>[
        OutlinedButton.icon(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SearchPage(
                          user: widget.user,
                        )));
          },
          style: OutlinedButton.styleFrom(
            minimumSize: Size(MediaQuery.of(context).size.width * 0.485, MediaQuery.of(context).size.height * 0.045),
            foregroundColor: Colors.grey,
            padding: const EdgeInsets.all(6),
            alignment: Alignment.centerLeft,
          ),
          icon: const Icon(Icons.search),
          label: const Text("Search"),
        ),
        IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Notifications(
                            user: widget.user,
                          )));
            },
            icon: const Icon(Icons.notifications)),
        IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Profile(
                            user: widget.user,
                          ))).then((value) => {
                    if (value) {_refresh()}
                  });
            },
            icon: const Icon(Icons.account_circle)),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height -
            MediaQuery.of(context).padding.bottom,
        child: Column(
          children: [
            // Carousel
            CarouselSlider(
                items: imgList
                    .map((e) => Center(
                          child: Image.network(
                            e,
                            fit: BoxFit.cover,
                            height: MediaQuery.of(context).size.height,
                          ),
                        ))
                    .toList(),
                options: CarouselOptions(
                    height: MediaQuery.of(context).size.height * 0.3, autoPlay: true, viewportFraction: 1)),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Featured Coins",
                  style: TextStyle(fontSize: 23),
                ),
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.14,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(bottom: 8, top: 4),
              child: isRefreshing
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
                          scrollDirection: Axis.horizontal,
                          itemCount: 12,
                          itemBuilder: (context, index) {
                            return FeaturedCoin(
                                coin: coinMarket![index], user: widget.user);
                          }),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Recommended",
                  style: TextStyle(
                    fontSize: 23,
                  ),
                ),
              ],
            ),
            Expanded(
              child: isRefreshing
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
                          itemCount: 12,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return RecommendedCoin(
                              coin: coinMarket![index],
                              user: widget.user,
                            );
                          }),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 246, 244, 244),
        appBar: _buildAppBar(context),
        body: _buildBody(context),
      ),
    );
  }
}
