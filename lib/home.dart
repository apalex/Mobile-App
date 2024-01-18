import 'package:flutter/material.dart';
import 'package:crypto_app/main.dart';
import 'package:crypto_app/login.dart';
import 'package:crypto_app/notifications.dart';
import 'package:crypto_app/Models/user_model.dart';
import 'package:crypto_app/SQLite/database_helper.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late DatabaseHelper handler;
  late Future<List<User>> users;
  final db = DatabaseHelper();

  @override
  void initState() {
    handler = DatabaseHelper();
    users = handler.getUsers();
    handler.open().whenComplete(() {
      users = getAllUsers();
    });
    super.initState();
  }

  Future<List<User>> getAllUsers() {
    return handler.getUsers();
  }

  Future<void> _refresh() async {
    setState(() {
      users = getAllUsers();
    });
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text("Mintless"),
      actions: <Widget>[
        OutlinedButton.icon(
          onPressed: () {
            showSearch(
              context: context, 
              delegate: CustomSearchDelegate(),
              );
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
          onPressed: () {
            Navigator.push(
              context, 
              MaterialPageRoute(
                builder: (context) => const Notifications()
                )
              );
          }, 
          icon: const Icon(Icons.notifications)),
        IconButton(onPressed: () {
          Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (context) => const Login()
              )
            ).then((value) => {
              if (value) {
                _refresh()
              }
            });
        },
        icon: const Icon(Icons.account_circle))
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return FutureBuilder<List<User>>(
      future: users,
      builder: (BuildContext context, AsyncSnapshot <List<User>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasData && snapshot.data!.isEmpty) {
          return const Center(child: Text("No data"));
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        } else {
          final items = snapshot.data ?? <User>[];
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
            return ListTile(
              title: Center(
                child: Text(items[index].username),
              ),
            );
          });
        }
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Color.fromARGB(255, 246, 244, 244),
      appBar: _buildAppBar(context),
      body: _buildBody(context),
      // body: Container(
      //   height: myHeight,
      //   width: myWidth,
      //   decoration: const BoxDecoration(
      //     gradient: LinearGradient(
      //       begin: Alignment.topLeft,
      //       end: Alignment.bottomRight,
      //       colors: [
      //         Colors.blue,
      //         Colors.grey
      //       ],
      //       ),
      //   ),
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.end,
      //     children: [
      //       Container(
      //         height: myHeight * 0.65,
      //         width: myWidth,
      //         decoration: const BoxDecoration(
      //           color: Colors.white,
      //           borderRadius: BorderRadius.only(
      //             topLeft: Radius.circular(50),
      //             topRight: Radius.circular(50),
      //           )
      //         ),
      //       )
      //     ],
      //   ),
      // ),
    ),
  );
}
}
