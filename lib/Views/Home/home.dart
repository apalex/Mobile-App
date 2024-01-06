import 'package:flutter/material.dart';
import '../../main.dart';
import 'login.dart';

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
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(),
                );
            },
            icon: const Icon(Icons.search),
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
