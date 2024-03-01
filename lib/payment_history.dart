import 'package:crypto_app/Models/user_model.dart';
import 'package:crypto_app/Models/user_payment_model.dart';
import 'package:crypto_app/SQLite/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PaymentHistory extends StatefulWidget {
  final User? user;
  const PaymentHistory({super.key, this.user});

  @override
  State<PaymentHistory> createState() => _PaymentHistoryState();
}

class _PaymentHistoryState extends State<PaymentHistory> {
  late DatabaseHelper handler;
  late Future<List<UserPayment>> up;
  final db = DatabaseHelper();

  @override
  void initState() {
    handler = DatabaseHelper();
    up = handler.getUserPayments(widget.user?.userId);
    handler.open().whenComplete(() {
      up = getUserPayments();
    });
    super.initState();
  }

  Future<List<UserPayment>> getUserPayments() {
    return handler.getUserPayments(widget.user?.userId);
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
          title: const Text("Transaction History"),
          centerTitle: true,
        ),
        body: FutureBuilder<List<UserPayment>>(
            future: up,
            builder: (BuildContext context,
                AsyncSnapshot<List<UserPayment>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                return const Center(child: Text("Nothing to see here..."));
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                final items = snapshot.data ?? <UserPayment>[];
                return ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.65,
                            height: MediaQuery.of(context).size.height * 0.16,
                            margin: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).size.height * 0.02),
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 238, 234, 234)),
                            child: Column(
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                                Text(
                                  items[index].action,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                                Text(items[index].paymentMethod),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                                Text(
                                    "${items[index].paymentAmt.toString()} USDT"),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.width * 0.02,
                                ),
                                Text(DateFormat('yyyy-MM-dd hh:mm').format(
                                    DateTime.parse(items[index].paymentDate))),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              }
            }),
      ),
    );
  }
}
