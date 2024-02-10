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
  late DatabaseHelper handler;
  late Future<List<UserActivity>> userAct;

  @override
  void initState() {
    handler = DatabaseHelper();
    userAct = handler.getUserActivities();
    handler.open().whenComplete(() {
      userAct = getAllActivity();
    });
    super.initState();
  }

  Future<List<UserActivity>> getAllActivity() {
    return handler.getUserActivities();
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
            Row(
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
              ],
            ),
            // Last Login
    // FutureBuilder<List<UserActivity>>(
    //   future: userAct,
    //   builder: (BuildContext context, AsyncSnapshot <List<UserActivity>> snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return const CircularProgressIndicator();
    //     } else if (snapshot.hasData && snapshot.data!.isEmpty) {
    //       return const Center(child: Text("No data"));
    //     } else if (snapshot.hasError) {
    //       return Text(snapshot.error.toString());
    //     } else {
    //       final items = snapshot.data ?? <UserActivity>[];
    //       return ListView.builder(
    //         itemCount: items.length,
    //         itemBuilder: (context, index) {
    //         return ListTile(
    //           title: Center(
    //             child: Text('${items[index].userActivityId}'),
    //           ),
    //         );
    //       });
    //     }
    //   }
    // ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.08,),
            // Limits
            Container(
              margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.017),
              child: Row(
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width * 0.02,),
                  const Icon(Icons.vertical_align_top_sharp, size: 48,),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.02,),
                  const Text("Limits", style: TextStyle(fontSize: 20, letterSpacing: 2),)
                ],
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 1,
                    color: Colors.black
                  )
                )
              ),
            ),
            // History
            Container(
              margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.017, top: MediaQuery.of(context).size.height * 0.018),
              child: Row(
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width * 0.02,),
                  const Icon(Icons.access_time_sharp, size: 48,),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.02,),
                  const Text("History", style: TextStyle(fontSize: 20, letterSpacing: 2),)
                ],
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 1,
                    color: Colors.black
                  )
                )
              ),
            ),
            // Security
            Container(
              margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.017, top: MediaQuery.of(context).size.height * 0.018),
              child: Row(
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width * 0.02,),
                  const Icon(Icons.security_sharp, size: 48,),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.02,),
                  const Text("Security", style: TextStyle(fontSize: 20, letterSpacing: 2),)
                ],
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 1,
                    color: Colors.black
                  )
                )
              ),
            ),
            // Settings
            Container(
              margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.017, top: MediaQuery.of(context).size.height * 0.018),
              child: Row(
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width * 0.02,),
                  const Icon(Icons.settings, size: 48,),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.02,),
                  const Text("Settings", style: TextStyle(fontSize: 20, letterSpacing: 2),)
                ],
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 1,
                    color: Colors.black
                  )
                )
              ),
            ),
            // Support
            Container(
              margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.017, top: MediaQuery.of(context).size.height * 0.018),
              child: Row(
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width * 0.02,),
                  const Icon(Icons.support_agent_rounded, size: 48,),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.02,),
                  const Text("Support", style: TextStyle(fontSize: 20, letterSpacing: 2),)
                ],
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 1,
                    color: Colors.black
                  )
                )
              ),
            ),
            // Logout
            Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.018),
              child: Row(
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width * 0.02,),
                  const Icon(Icons.logout_sharp, size: 46,),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.02,),
                  const Text("Logout", style: TextStyle(fontSize: 20, letterSpacing: 2),)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
