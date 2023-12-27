import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home: Scaffold(
    appBar: AppBar(
      title: const Text("Mintless"),
      actions: <Widget>[
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications),
          ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.account_circle),
          ),
      ],
    ),
    body: const Center(
      child: Text("Body"),
    ),
  ),
));
