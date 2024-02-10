import 'package:flutter/material.dart';
import 'package:crypto_app/Models/user_model.dart';

class Limits extends StatelessWidget {
  final User? user;
  const Limits({super.key, this.user});

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text("Limits"),
      centerTitle: true,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Icon(Icons.arrow_back_sharp),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: _buildAppBar(context),
      ),
    );
  }
}