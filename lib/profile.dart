import 'package:clipboard/clipboard.dart';
import 'package:crypto_app/Models/user_activity_model.dart';
import 'package:flutter/material.dart';
import 'package:crypto_app/Models/user_model.dart';
import 'package:crypto_app/SQLite/database_helper.dart';
import 'package:crypto_app/profile_limits.dart';

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
          icon: const Icon(Icons.dark_mode_outlined, size: 26,)
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
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Limits(user: widget.user,)));
              },
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Row(
                children: [
                  Icon(Icons.account_circle, size: MediaQuery.of(context).size.width * 0.2, color: Colors.black54,),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.02,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.user!.username, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                      Builder(
                        builder: (context) {
                          return GestureDetector(
                            onTap: () {
                                    FlutterClipboard.copy(widget.user!.userId.toString()).then(
                                      (value) {
                                      return ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("UID has been copied!")));
                                    });
                            },
                            child: Row(
                              children: [
                                Text("UID: ${widget.user!.userId.toString()}", style: const TextStyle(fontSize: 16,),),
                                IconButton(
                                  onPressed: () {
                                    FlutterClipboard.copy(widget.user!.userId.toString()).then(
                                      (value) {
                                      return ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("UID has been copied!")));
                                    });
                                  },
                                  icon: const Icon(Icons.content_copy, size: 16,)
                                ),
                              ],
                            ),
                          );
                        }
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    margin: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.02),
                    child: const Icon(Icons.keyboard_arrow_right_sharp, size: 30,))
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.05,
              color: Colors.grey,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
            // Limits
            Row(
              children: [
                SizedBox(width: MediaQuery.of(context).size.width * 0.05,),
                const Icon(Icons.vertical_align_top_sharp, size: 42,),
                SizedBox(width: MediaQuery.of(context).size.width * 0.02,),
                const Text("Limits", style: TextStyle(fontSize: 20),)
              ],
            )
            // History
            // Security
            // Settings
            // Support
          ],
        ),
      ),
    );
  }
}
