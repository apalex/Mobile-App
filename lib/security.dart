import 'package:crypto_app/Models/user_model.dart';
import 'package:crypto_app/change_user_info.dart';
import 'package:crypto_app/SQLite/database_helper.dart';
import 'package:crypto_app/welcome.dart';
import 'package:flutter/material.dart';

class UserSecurity extends StatefulWidget {
  final User? user;
  const UserSecurity({super.key, this.user});

  @override
  State<UserSecurity> createState() => _UserSecurityState();
}

class _UserSecurityState extends State<UserSecurity> {
  final db = DatabaseHelper();

  Future<void> confirmDeletion(BuildContext context) async {
    Widget cancel = TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text(
          "Cancel",
          style: TextStyle(color: Colors.black),
        ));
    Widget confirm = TextButton(
        onPressed: () {
          db.deleteUser(widget.user?.userId);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const Welcome()));
        },
        child: const Text(
          "Confirm",
          style: TextStyle(color: Colors.black),
        ));
    AlertDialog message = AlertDialog(
      title: const Text(
        "Account Deletion",
        style: TextStyle(fontSize: 20),
      ),
      content: const Text(
          "Are you sure you want to delete your account? By pressing confirm you will not be able to restore your account again."),
      actions: [cancel, confirm],
    );
    await showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return message;
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Security",
            style: TextStyle(letterSpacing: 1),
          ),
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_sharp),
          ),
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.bottom,
            child: Column(
              children: [
                // Email
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChangeUserInfo(
                                  user: widget.user,
                                  changeMode: "Email",
                                )));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.05,
                              top: MediaQuery.of(context).size.height * 0.03),
                          child: const Text(
                            "Change Email",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )),
                      Container(
                          margin: EdgeInsets.only(
                              right: MediaQuery.of(context).size.width * 0.05,
                              top: MediaQuery.of(context).size.height * 0.03),
                          child: const Icon(
                            Icons.arrow_right_sharp,
                            size: 25,
                          )),
                    ],
                  ),
                ),
                // Password
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChangeUserInfo(
                                  user: widget.user,
                                  changeMode: "Password",
                                )));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.05,
                              top: MediaQuery.of(context).size.height * 0.04),
                          child: const Text(
                            "Change Password",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )),
                      Container(
                          margin: EdgeInsets.only(
                              right: MediaQuery.of(context).size.width * 0.05,
                              top: MediaQuery.of(context).size.height * 0.03),
                          child: const Icon(
                            Icons.arrow_right_sharp,
                            size: 25,
                          )),
                    ],
                  ),
                ),
                // Phone Number
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChangeUserInfo(
                                  user: widget.user,
                                  changeMode: "Phone",
                                )));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.05,
                              top: MediaQuery.of(context).size.height * 0.04),
                          child: const Text(
                            "Change Phone Number",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )),
                      Container(
                          margin: EdgeInsets.only(
                              right: MediaQuery.of(context).size.width * 0.05,
                              top: MediaQuery.of(context).size.height * 0.03),
                          child: const Row(
                            children: [
                              Icon(
                                Icons.arrow_right_sharp,
                                size: 25,
                              )
                            ],
                          )),
                    ],
                  ),
                ),
                // Delete Account
                InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                              title: const Text(
                                "Account Deletion",
                                style: TextStyle(fontSize: 20),
                              ),
                              content: const Text(
                                "Are you sure you want to delete your account? By pressing confirm you will not be able to restore your account again.",
                                style: TextStyle(color: Colors.grey),
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                    },
                                    child: const Text(
                                      "Cancel",
                                      style: TextStyle(color: Colors.black),
                                    )),
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                      db.deleteUser(widget.user?.userId);
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Welcome()));
                                    },
                                    child: const Text(
                                      "Confirm",
                                      style: TextStyle(color: Colors.red),
                                    )),
                              ],
                            ));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.05,
                              top: MediaQuery.of(context).size.height * 0.04),
                          child: const Text(
                            "Delete Account",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent),
                          )),
                      Container(
                          margin: EdgeInsets.only(
                              right: MediaQuery.of(context).size.width * 0.05,
                              top: MediaQuery.of(context).size.height * 0.03),
                          child: const Row(
                            children: [
                              Icon(
                                Icons.arrow_right_sharp,
                                size: 25,
                                color: Colors.redAccent,
                              )
                            ],
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
