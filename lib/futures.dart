import 'package:flutter/material.dart';
import 'package:crypto_app/SQLite/database_helper.dart';
import 'package:crypto_app/Models/user_model.dart';
import 'package:crypto_app/Models/user_activity_model.dart';
import 'package:crypto_app/Models/user_address_model.dart';
import 'package:crypto_app/Models/portfolio_model.dart';
import 'package:crypto_app/Models/user_payment_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:crypto_app/Models/user_balance_model.dart';

class Futures extends StatefulWidget {
  final User? user;
  const Futures({super.key, this.user});

  @override
  State<Futures> createState() => _FuturesState();
}

class _FuturesState extends State<Futures> {
  late DatabaseHelper handler;
  late Future<List<UserBalance>> ua;
  final db = DatabaseHelper();

  @override
  void initState() {
    handler = DatabaseHelper();
    ua = handler.getAllBalances();
    handler.open().whenComplete(() {
      ua = getAllBalances();
    });
    super.initState();
  }

  Future<List<UserBalance>> getAllBalances() {
    return handler.getAllBalances();
  }

  // Future<List<PortfolioModel>> getAllPortfolios() {
  //   return handler.getAllPortfolios();
  // }

  // Future<List<UserPayment>> getAllPayments() {
  //   return handler.getAllPayments();
  // }

  // Future<List<UserAddress>> getAllAddress() {
  //   return handler.getUserAddresses();
  // }

  // Future<List<UserActivity>> getAllActivity() {
  //   return handler.getUserActivities();
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<UserBalance>>(
      future: ua,
      builder: (BuildContext context, AsyncSnapshot <List<UserBalance>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasData && snapshot.data!.isEmpty) {
          return const Center(child: Text("No data"));
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        } else {
          final items = snapshot.data ?? <UserBalance>[];
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
            return ListTile(
              title: Center(
                child: Text(items[index].userBalance.toString()),
              ),
            );
          });
        }
      });
}
}
