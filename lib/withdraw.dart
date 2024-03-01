import 'package:crypto_app/Models/portfolio_model.dart';
import 'package:crypto_app/Models/user_balance_model.dart';
import 'package:crypto_app/Models/user_model.dart';
import 'package:crypto_app/Models/user_payment_model.dart';
import 'package:crypto_app/SQLite/database_helper.dart';
import 'package:crypto_app/navigation_menu.dart';
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
  bool isVisible = false;
  final db = DatabaseHelper();

  @override
  void initState() {
    super.initState();
  }

  Future<dynamic> successPopup(BuildContext context) {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(
          "Withdrawal Notification",
          style: TextStyle(fontSize: 20),
        ),
        content: Text(
          "Withdrawal was successfully made! ${double.parse(withdrawalAmt.text.replaceAll(",", ""))} USDT has been withdrawed from your account!",
          style: const TextStyle(color: Colors.grey),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NavigationMenu(
                              user: widget.user,
                            )));
              },
              child: const Text(
                "OK",
                style: TextStyle(color: Colors.black),
              )),
        ],
      ),
    );
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
                      const Text("Minimum Withdrawable amount is 10 USDT", style: TextStyle(fontSize: 15),),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
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
                      // If not enough USDT
                      Visibility(
                        visible: isVisible,
                        child: Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: const Text("Not enough USDT owned", style: TextStyle(color: Colors.red),),
                        )
                      ),
                      // Confirm Button
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
                              if (formKey.currentState!.validate()) {
                                PortfolioModel usdt = await db.getCoinAmt(widget.user?.userId, 'tether');
                                if (double.parse(withdrawalAmt.text.replaceAll(",", "")) > usdt.coinAmt) {
                                  setState(() {
                                    isVisible = true;
                                  });
                                } else {
                                  await db.editCoinPortfolio(widget.user?.userId, 'tether', usdt.coinAmt - double.parse(withdrawalAmt.text.replaceAll(",", ""))).whenComplete(() async {
                                    UserBalance balance = await db.getUserBalance(widget.user?.userId);
                                    await db.insertDepositBalance(widget.user?.userId, balance.userBalance - double.parse(withdrawalAmt.text.replaceAll(",", ""))).whenComplete(() async {
                                      await db.insertUserPayment(UserPayment(
                                        userId: widget.user?.userId,
                                        paymentMethod: 'Bank',
                                        paymentAmt: double.parse(withdrawalAmt.text.replaceAll(",", "")),
                                        paymentDate: DateTime.now().toIso8601String(),
                                        action: 'Withdrawal')
                                        ).whenComplete(() {
                                          successPopup(context);
                                        });
                                    });
                                  });
                                }
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