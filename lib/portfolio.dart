import 'package:crypto_app/Models/portfolio_model.dart';
import 'package:crypto_app/Models/user_balance_model.dart';
import 'package:crypto_app/Models/user_model.dart';
import 'package:crypto_app/SQLite/database_helper.dart';
import 'package:crypto_app/deposit.dart';
import 'package:crypto_app/payment_history.dart';
import 'package:crypto_app/withdraw.dart';
import 'package:flutter/material.dart';

class Portfolio extends StatefulWidget {
  final User? user;
  const Portfolio({super.key, this.user});

  @override
  State<Portfolio> createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {
  bool isVisibleBal = false;
  String hidden = "**** **** **** ****";
  late DatabaseHelper handler;
  late Future<List<PortfolioModel>> pm;
  final db = DatabaseHelper();
  late UserBalance bal;

  @override
  void initState() {
    handler = DatabaseHelper();
    pm = handler.getPortolio(widget.user?.userId);
    getBalance();
    handler.open().whenComplete(() {
      pm = getPortfolio();
    });
    super.initState();
  }

  getBalance() async {
    setState(() async {
      bal = await db.getUserBalance(widget.user?.userId);
    });
  }

  Future<List<PortfolioModel>> getPortfolio() {
    return handler.getPortolio(widget.user?.userId);
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text("Portfolio",),
        ),
        body: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: <Widget>[
              _buildCreditCard(
                color: Colors.black87,
              ),
              Container(
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.04),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: MediaQuery.of(context).size.width * 0.04,),
                    const Text("Total Assets", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,),),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
              SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.45,
                  child: Column(
                    children: [
                      Expanded(
                        child: FutureBuilder<List<PortfolioModel>>(
                          future: pm,
                          builder: (BuildContext context, AsyncSnapshot <List<PortfolioModel>> snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                              return const Center(child: Text("None"),);
                            } else if (snapshot.hasError) {
                              return Text(snapshot.hasError.toString());
                            } else {
                              final coins = snapshot.data ?? <PortfolioModel>[];
                              return ListView.builder(
                                itemCount: coins.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    textColor: Colors.black,
                                    title: Text(coins[index].coinName.capitalize(), style: const TextStyle(fontSize: 18),),
                                    trailing: Text(coins[index].coinAmt.toString(), style: const TextStyle(fontSize: 18),),
                                  );
                                },
                              );
                            }
                          },
                        )
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCreditCard({@required color})  {
    return Card(
      elevation: 4,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14)
      ),
      child: Container(
        height: 200,
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            // Logo
            const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 12),
                  child: Text(
                    "Mintless Inc.",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                    ),
                  ),
                ),
              ],
            ),
            // Balance
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Column(
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(bottom: 5, left: 1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "BALANCE (in USDT)",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        isVisibleBal ?
                        bal.userBalance.toString() :
                        hidden,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontFamily: "CourrierPrime",
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            isVisibleBal = !isVisibleBal;
                          });
                        },
                        icon: Icon(isVisibleBal
                        ? Icons.visibility
                        : Icons.visibility_off
                      ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Extra Decoration of Credit Card
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Deposit(user: widget.user,))
                            );
                          },
                          child: Row(
                            children: [
                              const Icon(Icons.account_balance_wallet_sharp, size: 20, color: Colors.white60,),
                              SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
                              const Text(
                                "DEPOSIT",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold
                                ),
                              )
                            ],
                          )
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Withdraw(user: widget.user,))
                            );
                          },
                          child: Row(
                            children: [
                              const Icon(Icons.vertical_align_top_sharp, size: 20, color: Colors.white60,),
                              SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
                              const Text(
                                "WITHDRAW",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold
                                ),
                              )
                            ],
                          )
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PaymentHistory(user: widget.user,)
                              )
                            );
                          },
                          child: Row(
                            children: [
                              const Icon(Icons.history_sharp, size: 20, color: Colors.white60,),
                              SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
                              const Text(
                                "HISTORY",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold
                                ),
                              )
                            ],
                          )
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}
