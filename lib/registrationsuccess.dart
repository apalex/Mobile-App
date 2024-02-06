import 'package:flutter/material.dart';
import 'package:crypto_app/welcome.dart';

class RegistrationSuccess extends StatelessWidget {
  const RegistrationSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Welcome(),
                ),
              );
            },
            child: const Icon(Icons.close_sharp),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(30),
          child: const Center(
            child: Text(
              "Congratulations! You have successfully made an account with Mintless.",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
