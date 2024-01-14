import 'package:flutter/material.dart';
import 'package:crypto_app/main.dart';
import 'package:crypto_app/login.dart';
import 'package:crypto_app/notifications.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

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
            );
        },
        icon: const Icon(Icons.account_circle))
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return const Column(
      children: [
        SizedBox(
          height: 25,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [],
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Colors.blueGrey[50],
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
