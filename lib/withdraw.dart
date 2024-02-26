import 'package:crypto_app/Models/user_model.dart';
import 'package:flutter/material.dart';

class Withdraw extends StatefulWidget {
  final User? user;
  const Withdraw({super.key, this.user});

  @override
  State<Withdraw> createState() => _WithdrawState();
}

class _WithdrawState extends State<Withdraw> {

  Widget buildDeposit(BuildContext context) {
    return Placeholder();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_sharp),
          ),
          title: const Text("Withdraw"),
          centerTitle: true,
        ),
      ),
    );
  }
}