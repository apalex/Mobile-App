import 'package:crypto_app/Models/user_activity_model.dart';
import 'package:flutter/material.dart';
import 'package:crypto_app/Models/user_model.dart';
import 'package:crypto_app/SQLite/database_helper.dart';

class Profile extends StatefulWidget {
  final User? user;
  const Profile({super.key, this.user});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final db = DatabaseHelper();

  activity() async {
    UserActivity uact = await db.getUserActivity(1);
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text("Profile"),
      centerTitle: true,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Icon(Icons.arrow_back_sharp),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.dark_mode_outlined)
          // Icons.dark_mode_sharp
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: _buildAppBar(context),
        body: Column(
          children: [
            Row(
              children: [
                Icon(Icons.account_circle, size: MediaQuery.of(context).size.width * 0.2,),
                SizedBox(width: MediaQuery.of(context).size.width * 0.02,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.user!.username, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                    Text("UID : ${widget.user!.userId.toString()}")

                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
