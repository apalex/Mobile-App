import 'package:crypto_app/home.dart';
import 'package:crypto_app/markets.dart';
import 'package:crypto_app/trade.dart';
import 'package:crypto_app/margins.dart';
import 'package:crypto_app/portfolio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Obx(() => controller.screens[controller.selectedIndex.value]),
        bottomNavigationBar: Obx(
          () => NavigationBar(
            height: 65,
            elevation: 1,
            selectedIndex: controller.selectedIndex.value,
            onDestinationSelected: (index) => controller.selectedIndex.value = index,
            destinations: const [
              NavigationDestination(icon: Icon(Icons.home_sharp), label: "Home"),
              NavigationDestination(icon: Icon(Icons.bar_chart_sharp), label: "Markets"),
              NavigationDestination(icon: Icon(Icons.compare_arrows_sharp), label: "Trade"),
              NavigationDestination(icon: Icon(Icons.keyboard_double_arrow_up_sharp), label: "Margins"),
              NavigationDestination(icon: Icon(Icons.wallet_rounded), label: "Portfolio"),
            ],
          ),
        ),
      ),
  );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  final screens = [
    const Home(),
    const Markets(),
    const Trade(),
    const Margins(),
    const Portfolio(),
  ];
}
