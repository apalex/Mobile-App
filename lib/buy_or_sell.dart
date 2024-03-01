import 'package:crypto_app/Models/user_model.dart';
import 'package:crypto_app/SQLite/database_helper.dart';
import 'package:flutter/material.dart';

class BuyOrSell extends StatefulWidget {
  final User? user;
  final String? action;
  var coin;
  BuyOrSell({this.user, this.action, this.coin});

  @override
  State<BuyOrSell> createState() => _BuyOrSellState();
}

class _BuyOrSellState extends State<BuyOrSell> {
  final amount = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final focusNodeSelect = FocusNode();
  final db = DatabaseHelper();

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
                  Text(widget.coin?.name, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: 1),),
                  Text("Current ${widget.coin.name} Owned: 0"),
                  Text("USDT Available: 0.00", style: TextStyle(fontSize: 16, color: Colors.grey),),
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
                      onPressed: () {
                        
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