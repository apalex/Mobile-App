import 'package:crypto_app/home.dart';
import 'package:crypto_app/markets.dart';
import 'package:crypto_app/trade.dart';
import 'package:crypto_app/futures.dart';
import 'package:crypto_app/portfolio.dart';
import 'package:crypto_app/Models/user_model.dart';
import 'package:flutter/material.dart';

class NavigationMenu extends StatefulWidget {
  final User? user;
  const NavigationMenu({super.key, this.user});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  int currentIndex = 0;
  late Home homeScreen = Home(user: widget.user,);
  late Futures futuresScreen = Futures(user: widget.user,);
  late final screens = [
    homeScreen,
    Markets(),
    Trade(),
    futuresScreen,
    Portfolio()
  ];

  @override
  void initState() {
    homeScreen = Home(user: widget.user,);
    futuresScreen = Futures(user: widget.user,);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: screens[currentIndex],
        bottomNavigationBar: NavigationBar(
          selectedIndex: currentIndex,
          height: 65,
          elevation: 1,
          onDestinationSelected: (index) => setState(() {
            currentIndex = index;
          }),
          destinations: const [
            // Home
            NavigationDestination(
              icon: Icon(Icons.home_sharp),
              label: "Home"
            ),
            // Markets
            NavigationDestination(
              icon: Icon(Icons.bar_chart_sharp),
              label: "Markets"
            ),
            // Trade
            NavigationDestination(
              icon: Icon(Icons.compare_arrows_sharp),
              label: "Trade"
            ),
            // Futures
            NavigationDestination(
              icon: Icon(Icons.keyboard_double_arrow_up_sharp),
              label: "Futures"
            ),
            // Portfolio
            NavigationDestination(
              icon: Icon(Icons.wallet_rounded),
              label: "Portfolio"
            ),
          ],
        ),
      ),
    );
  }
}
