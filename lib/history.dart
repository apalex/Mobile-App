import 'package:flutter/material.dart';
import 'package:crypto_app/Models/user_model.dart';

class History extends StatefulWidget {
  final User? user;
  const History({super.key, this.user});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("History"),
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_sharp),
          ),
        ),
        body: Row(),
      ),
    );
  }
}