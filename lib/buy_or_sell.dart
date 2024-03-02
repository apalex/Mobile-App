import 'package:crypto_app/Models/portfolio_model.dart';
import 'package:crypto_app/Models/user_balance_model.dart';
import 'package:crypto_app/Models/user_model.dart';
import 'package:crypto_app/SQLite/database_helper.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BuyOrSell extends StatefulWidget {
  final User? user;
  final String? action;
  // ignore: prefer_typing_uninitialized_variables
  var coin;
  BuyOrSell({super.key, this.user, this.action, this.coin});

  @override
  State<BuyOrSell> createState() => _BuyOrSellState();
}

class _BuyOrSellState extends State<BuyOrSell> {
  final amount = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final focusNodeSelect = FocusNode();
  final db = DatabaseHelper();
  late PortfolioModel pm;
  bool isVisible = false;

  @override
  void initState() {
    db.open();
    super.initState();
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
          title: Text(widget.action.toString()),
          centerTitle: true,
        ),
        body: Container(
          color: const Color.fromARGB(255, 246, 244, 244),
          child: Center(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * 0.05, child: Image.network("${widget.coin.image}")),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.02,),
                      Text(widget.coin?.name, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: 1),),
                    ],
                  ),
                  // User Input
                  Container(
                    height: MediaQuery.of(context).size.height * 0.07,
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05, right: MediaQuery.of(context).size.width * 0.05, bottom: 10, top: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white
                    ),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: amount,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Select a valid amount";
                        } else if (double.parse(value) <= 0) {
                          return "Please enter an amount greater than 0";
                        }
                        return null;
                      },
                      focusNode: focusNodeSelect,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                          color: focusNodeSelect.hasFocus
                          ? Colors.black
                          : Colors.black
                        ),
                        border: InputBorder.none,
                        icon: const Icon(Icons.attach_money_sharp, color: Colors.black, size: 30,)
                      ),
                    ),
                  ),
                  // If not enough USDT
                  Visibility(
                    visible: isVisible,
                    child: Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: Text(widget.action == "Buy" ? "Insufficient USDT in balance" : "Insufficient ${widget.coin.name.toString()} in portfolio", style: const TextStyle(color: Colors.red),),
                    )
                  ),
                  // Button
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05, right: MediaQuery.of(context).size.width * 0.05, bottom: 10, top: 20),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black
                    ),
                    child: TextButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          PortfolioModel usdt = await db.getCoinAmt(widget.user?.userId, 'tether');
                          // Buy
                          if (widget.action.toString() == "Buy") {
                            if (double.parse(amount.text.replaceAll(",", "")) > usdt.coinAmt) {
                              setState(() {
                                isVisible = true;
                              });
                            } else {

                            }
                          }
                          // Sell
                          else {

                          }
                        }
                      },
                      child: Text(widget.action.toString(), style: const  TextStyle(color: Colors.white),)
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}