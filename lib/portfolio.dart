import 'package:crypto_app/Models/user_model.dart';
import 'package:crypto_app/deposit_or_withdraw.dart';
import 'package:flutter/material.dart';

class Portfolio extends StatefulWidget {
  final User? user;
  const Portfolio({super.key, this.user});

  @override
  State<Portfolio> createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {
  bool isVisibleBal = true;
  var bal = "\$111.11";
  showBalance() {
    if (isVisibleBal) {
      setState(() {
        bal = "\$111.11";
      });
      } else {
      setState(() {
        bal = "**** **** **** ****";
      });
    }
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
                        bal,
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
                            showBalance();
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
                              MaterialPageRoute(builder: (context) => DepositOrWithdraw(user: widget.user, action: "Deposit",))
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
                              MaterialPageRoute(builder: (context) => DepositOrWithdraw(user: widget.user, action: "Withdraw",))
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
