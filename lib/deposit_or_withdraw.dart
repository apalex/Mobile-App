import 'package:crypto_app/Models/user_model.dart';
import 'package:flutter/material.dart';

class DepositOrWithdraw extends StatefulWidget {
  final User? user;
  final String? action;
  const DepositOrWithdraw({super.key, this.user, this.action});

  @override
  State<DepositOrWithdraw> createState() => _DepositOrWithdrawState();
}

class _DepositOrWithdrawState extends State<DepositOrWithdraw> {
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
          title: Text(widget.action.toString()),
          centerTitle: true,
        ),
      ),
    );
  }
}