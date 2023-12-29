import 'package:flutter/material.dart';
import 'main.dart';
import 'login.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: const Text("Mintless"),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(),
                );
            },
            icon: const Icon(Icons.search),
            ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications),
            ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Login()),
                );
            },
            icon: const Icon(Icons.account_circle),
            ),
        ],
      ),
      body: const Center(
        child: Text("Body"),
      ),
      bottomNavigationBar: NavigationBar(
        height: 65,
        elevation: 1,
        selectedIndex: 0, // Selected Navigation Icon
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_sharp), label: "Home"),
          NavigationDestination(icon: Icon(Icons.bar_chart_sharp), label: "Markets"),
          NavigationDestination(icon: Icon(Icons.compare_arrows_sharp), label: "Trade"),
          NavigationDestination(icon: Icon(Icons.keyboard_double_arrow_up_sharp), label: "Margins"),
          NavigationDestination(icon: Icon(Icons.wallet_rounded), label: "Portfolio"),
        ],
      ),
    ),
  );
}
}
