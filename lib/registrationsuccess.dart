import 'package:crypto_app/navigation_menu.dart';
import 'package:flutter/material.dart';

class RegistrationSuccess extends StatelessWidget {
  const RegistrationSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              MaterialPageRoute(builder: (context) => const NavigationMenu());
            },
            child: const Icon(Icons.close_sharp),
          ),
        ),
        body: const Center(
          child: Text("Congratulations! You have successfully made an account with Mintless."),
        ),
      ),
    );
  }
}
