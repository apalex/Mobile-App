import 'package:flutter/material.dart';
import 'package:crypto_app/Models/user_model.dart';

class ChangeUserInfo extends StatefulWidget {
  final User? user;
  final String? changeMode;
  const ChangeUserInfo({super.key, this.user, this.changeMode});

  @override
  State<ChangeUserInfo> createState() => _ChangeUserInfoState();
}

class _ChangeUserInfoState extends State<ChangeUserInfo> {
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
        ),
      ),
    );
  }
}