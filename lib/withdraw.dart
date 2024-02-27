import 'package:crypto_app/Models/portfolio_model.dart';
import 'package:crypto_app/Models/user_balance_model.dart';
import 'package:crypto_app/Models/user_model.dart';
import 'package:crypto_app/SQLite/database_helper.dart';
import 'package:flutter/material.dart';

class Withdraw extends StatefulWidget {
  final User? user;
  const Withdraw({super.key, this.user});

  @override
  State<Withdraw> createState() => _WithdrawState();
}

class _WithdrawState extends State<Withdraw> {
  final withdrawalAmt = TextEditingController();
  FocusNode focusNodeWithdraw = FocusNode();
  final formKey = GlobalKey<FormState>();
  final db = DatabaseHelper();
  late DatabaseHelper handler;
  late UserBalance balance;
  late PortfolioModel portfolio;
  late Future<List<PortfolioModel>> currentTether;

  @override
  void initState() {
    handler = DatabaseHelper();
    currentTether = handler.getSumTether(widget.user?.userId);
    getBalance();
    handler.open().whenComplete(() {
      currentTether = getSumTether();
    });
    super.initState();
  }

  getBalance() async {
    setState(() async {
      balance = await db.getUserBalance(widget.user?.userId);
    });
  }

  Future<List<PortfolioModel>> getSumTether() {
    return handler.getSumTether(widget.user?.userId);
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
        body: Container(
          color: const Color.fromARGB(255, 246, 244, 244),
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const Text("Minimum Withdrawable amount is \$10 USDT", style: TextStyle(fontSize: 15),),
                      Text(""),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        margin: const EdgeInsets.only(left: 4, right: 4, top: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white
                        ),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: withdrawalAmt,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter an amount greater than or equal to \$10";
                            } else if (double.parse(value) < 10) {
                              return "Please enter an amount greater than or equal to \$10";
                            }
                            return null;
                          },
                          focusNode: focusNodeWithdraw,
                          decoration: InputDecoration(
                            label: const Text("Withdraw"),
                            labelStyle: TextStyle(
                              color: focusNodeWithdraw.hasFocus
                              ? Colors.black
                              : Colors.black
                            ),
                            border: InputBorder.none
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        margin:
                            const EdgeInsets.only(left: 4, right: 4, top: 25),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black),
                        child: TextButton(
                            onPressed: () async {
                              getBalance();
                              if (formKey.currentState!.validate()) {

                              }
                            },
                            child: const Text(
                              "Confirm",
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                    ],
                  )
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}