import 'package:crypto_app/Models/user_model.dart';
import 'package:crypto_app/Models/user_activity_model.dart';
import 'package:crypto_app/SQLite/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Notifications extends StatefulWidget {
  final User? user;
  const Notifications({super.key, this.user});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  late DatabaseHelper handler;
  late Future<List<UserActivity>> ua;
  final db = DatabaseHelper();

  @override
  void initState() {
    handler = DatabaseHelper();
    ua = handler.getUserActivity(widget.user?.userId);
    handler.open().whenComplete(() {
      ua = getUserActivity();
    });
    super.initState();
  }

  Future<List<UserActivity>> getUserActivity() {
    return handler.getUserActivity(widget.user?.userId);
  }

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
          title: const Text("Notifications"),
          centerTitle: true,
        ),
        body: FutureBuilder<List<UserActivity>>(
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
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.65,
                  height: MediaQuery.of(context).size.height * 0.13,
                  margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.02),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 238, 234, 234)
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                      const Text("New User Login", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                      SizedBox(height: MediaQuery.of(context).size.width * 0.02,),
                      Text(DateFormat('yyyy-MM-dd hh:mm').format(DateTime.parse(items[index].activityTimeStamp)))
                    ],
                  ),
                ),
                //Text(items[index].activityTimeStamp)
              ),
            );
          });
        }
      }),
      ),
    );
  }
}
