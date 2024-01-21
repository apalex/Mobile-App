import 'package:crypto_app/main.dart';
import 'package:flutter/material.dart';

class Portfolio extends StatefulWidget {
  const Portfolio({Key? key}) : super(key: key);

  @override
  State<Portfolio> createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
        ),
        body: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: <Widget>[
              _buildCreditCard(
                color: Colors.black87,
                cardNumber: "1234 1234 1234 1234",
                cardHolder: "TEST TEST",
                cardExpiration: "08/2022"
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCreditCard({@required color, @required cardNumber, @required cardHolder, @required cardExpiration})  {
    return Card(
      elevation: 4,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14)
      ),
      child: Container(
        height: 200,
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            // Logo
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 12),
                  child: Text(
                    "Mintless Inc.",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20
                    ),
                  ),
                ),
              ],
            ),
            // Balance
            Padding(
              padding: EdgeInsets.only(left: 12),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 5, left: 1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "BALANCE",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "\$111.11",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 21,
                          fontFamily: "CourrierPrime",
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "CARDHOLDER",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "VALID THRU",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
