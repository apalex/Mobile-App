import 'package:flutter/material.dart';
import 'package:crypto_app/login.dart';
import 'package:crypto_app/registration.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    'https://www.icegif.com/wp-content/uploads/2022/02/icegif-538.gif'),
                fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Welcome to",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text(
              "Mintless",
              style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              height: MediaQuery.of(context).size.height * 0.07,
              width: MediaQuery.of(context).size.width * 0.23,
              child: TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Login()));
                  },
                  style: TextButton.styleFrom(backgroundColor: Colors.black),
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              height: MediaQuery.of(context).size.height * 0.07,
              width: MediaQuery.of(context).size.width * 0.45,
              child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Registration()));
                  },
                  style: TextButton.styleFrom(backgroundColor: Colors.black),
                  child: const Text(
                    "Make an account",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
