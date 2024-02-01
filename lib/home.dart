import 'package:crypto_app/home_featured.dart';
import 'package:crypto_app/home_recommended.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:crypto_app/main.dart';
import 'package:crypto_app/login.dart';
import 'package:crypto_app/notifications.dart';
import 'package:crypto_app/Models/user_model.dart';
import 'package:crypto_app/SQLite/database_helper.dart';
import 'package:crypto_app/Models/coin_model.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

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
    'https://www.analyticsinsight.net/wp-content/uploads/2022/10/Solana-SOL-Spirals-Out-Of-Control-The-Hideaways-HDWY-Skyrockets-To-Second-Presale.jpg'
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

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text("Mintless"),
      actions: <Widget>[
        OutlinedButton.icon(
          onPressed: () {
            showSearch(
              context: context, 
              delegate: CustomSearchDelegate(),
              );
          },
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(199, 20),
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
                builder: (context) => const Notifications()
                )
              );
          }, 
          icon: const Icon(Icons.notifications)
        ),
        IconButton(onPressed: () {
          Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (context) => const Login()
              )
            ).then((value) => {
              if (value) {
                _refresh()
              }
            });
        },
        icon: const Icon(Icons.account_circle))
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.bottom,
        child: Column(
          children: [
            // Carousel
            CarouselSlider(
              items: imgList.map((e) => Center(
                child: Image.network(
                  e,
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height,
                ),
              )).toList(),
              options: CarouselOptions(
                height: 250,
                autoPlay: true,
                viewportFraction: 1
              )
            ),
            Container(
              margin: const EdgeInsets.only(top: 8),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Featured Coins",
                    style: TextStyle(
                      fontSize: 23
                      ),
                    ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.14,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(bottom: 8, top: 4),
              child: isRefreshing
              ? const Center(
                child: CircularProgressIndicator(),
              ) : coinMarket == null || coinMarket!.isEmpty ? const Center(child: Text("This App is using a free API, so you cannot send many requests in a short amount of time. Please wait a few minutes"),)
              : ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 12,
                itemBuilder: (context, index) {
                  return FeaturedCoin(coin: coinMarket![index]);
                }
              ),
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
              ) : coinMarket == null || coinMarket!.isEmpty ? const Center(child: Text("This App is using a free API, so you cannot send many requests in a short amount of time. Please wait a few minutes"),)
              : ListView.builder(
                itemCount: 12,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return RecommendedCoin(coin: coinMarket![index],
                );
                }
              ),
            ),
          ],
        ),
      ),
    );
    // FutureBuilder<List<User>>(
    //   future: users,
    //   builder: (BuildContext context, AsyncSnapshot <List<User>> snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return const CircularProgressIndicator();
    //     } else if (snapshot.hasData && snapshot.data!.isEmpty) {
    //       return const Center(child: Text("No data"));
    //     } else if (snapshot.hasError) {
    //       return Text(snapshot.error.toString());
    //     } else {
    //       final items = snapshot.data ?? <User>[];
    //       return ListView.builder(
    //         itemCount: items.length,
    //         itemBuilder: (context, index) {
    //         return ListTile(
    //           title: Center(
    //             child: Text('${items[index].username}'),
    //           ),
    //         );
    //       });
    //     }
    //   }
    // );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: const Color.fromARGB(255, 246, 244, 244),
      appBar: _buildAppBar(context),
      body: _buildBody(context),
      // body: Container(
      //   height: myHeight,
      //   width: myWidth,
      //   decoration: const BoxDecoration(
      //     gradient: LinearGradient(
      //       begin: Alignment.topLeft,
      //       end: Alignment.bottomRight,
      //       colors: [
      //         Colors.blue,
      //         Colors.grey
      //       ],
      //       ),
      //   ),
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.end,
      //     children: [
      //       Container(
      //         height: myHeight * 0.65,
      //         width: myWidth,
      //         decoration: const BoxDecoration(
      //           color: Colors.white,
      //           borderRadius: BorderRadius.only(
      //             topLeft: Radius.circular(50),
      //             topRight: Radius.circular(50),
      //           )
      //         ),
      //       )
      //     ],
      //   ),
      // ),
    ),
  );
}
}
