import 'package:crypto_app/Models/user_model.dart';
import 'package:crypto_app/Models/user_transfers.dart';
import 'package:crypto_app/SQLite/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CoinHistory extends StatefulWidget {
  final User? user;
  const CoinHistory({super.key, this.user});

  @override
  State<CoinHistory> createState() => _CoinHistoryState();
}

class _CoinHistoryState extends State<CoinHistory> {
  late DatabaseHelper handler;
  late Future<List<UserTransfers>> ut;
  final db = DatabaseHelper();

  @override
  void initState() {
    handler = DatabaseHelper();
    ut = handler.getUserTransfers(widget.user?.userId);
    handler.open().whenComplete(() {
      ut = getUserTransfers();
    });
    super.initState();
  }

  Future<List<UserTransfers>> getUserTransfers() {
    return handler.getUserTransfers(widget.user?.userId);
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
        body: FutureBuilder<List<UserTransfers>>(
            future: ut,
            builder: (BuildContext context,
                AsyncSnapshot<List<UserTransfers>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                return const Center(child: Text("Nothing to see here..."));
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                final items = snapshot.data ?? <UserTransfers>[];
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
                                  "${items[index].action}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                                Text("${items[index].transferAmt.toString()} ${items[index].coinName}"),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                                Text(
                                  "${items[index].usdtAmt.toString()} USDT",
                                  style: TextStyle(
                                      color: items[index].action == "Buy"
                                          ? Colors.green
                                          : Colors.red),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.width * 0.02,
                                ),
                                Text(DateFormat('yyyy-MM-dd hh:mm').format(
                                    DateTime.parse(
                                        items[index].transactionDate))),
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
