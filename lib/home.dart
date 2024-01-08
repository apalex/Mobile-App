import 'package:flutter/material.dart';
import 'package:crypto_app/main.dart';
import 'package:crypto_app/login.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: const Text("Mintless"),
        actions: <Widget>[
          OutlinedButton.icon(
            onPressed: () {
              showSearch(context: context, delegate: CustomSearchDelegate());
            },
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(199, 20),
              foregroundColor: Colors.grey,
              padding: const EdgeInsets.all(6),
              alignment: Alignment.centerLeft,
            ),
            icon: const Icon(Icons.search),
            label: const Text("Search"),
            ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications),
            ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Login()),
                );
            },
            icon: const Icon(Icons.account_circle),
            ),
        ],
      ),
    ),
  );
}
}
