import 'package:flutter/material.dart';
import 'package:crypto_app/SQLite/database_helper.dart';
import 'package:crypto_app/Models/user_model.dart';
import 'package:crypto_app/Models/user_activity_model.dart';

class Futures extends StatefulWidget {
  final User? user;
  const Futures({super.key, this.user});

  @override
  State<Futures> createState() => _FuturesState();
}

class _FuturesState extends State<Futures> {
  late DatabaseHelper handler;
  late Future<List<UserActivity>> ua;
  final db = DatabaseHelper();

  @override
  void initState() {
    handler = DatabaseHelper();
    ua = handler.getUserActivities();
    handler.open().whenComplete(() {
      ua = getAllActivity();
    });
    super.initState();
  }

  Future<List<UserActivity>> getAllActivity() {
    return handler.getUserActivities();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<UserActivity>>(
      future: ua,
      builder: (BuildContext context, AsyncSnapshot <List<UserActivity>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasData && snapshot.data!.isEmpty) {
          return const Center(child: Text("No data"));
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        } else {
          final items = snapshot.data ?? <UserActivity>[];
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
            return ListTile(
              title: Center(
                child: Text(items[index].activityTimeStamp),
              ),
            );
          });
        }
      });
}
}
