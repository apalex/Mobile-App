import 'package:flutter/material.dart';

class Coin extends StatelessWidget {
  // final String? title;
  // final double percentChange;

  // Coin({
  //   required this.percentChange,
  //   this.title,
  // });

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Icon(Icons.arrow_back_sharp),
      ),
      title: const Text("BTC"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: _buildAppBar(context),

      ),
    );
  }
}
