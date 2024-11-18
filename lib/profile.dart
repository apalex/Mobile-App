import 'dart:io';
import 'package:clipboard/clipboard.dart';
import 'package:crypto_app/Models/user_activity_model.dart';
import 'package:crypto_app/payment_history.dart';
import 'package:crypto_app/security.dart';
import 'package:crypto_app/settings.dart';
import 'package:crypto_app/support.dart';
import 'package:crypto_app/welcome.dart';
import 'package:flutter/material.dart';
import 'package:crypto_app/Models/user_model.dart';
import 'package:crypto_app/SQLite/database_helper.dart';
import 'package:image_picker/image_picker.dart';

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
  File? _selectedImage;

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

  Widget bottomSheet() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            TextButton.icon(
              icon: Icon(Icons.camera),
              onPressed: () {
                _pickImageFromCamera();
              },
              label: Text("Camera"),
            ),
            TextButton.icon(
              icon: Icon(Icons.image),
              onPressed: () {
                _pickImageFromGallery();
              },
              label: Text("Gallery"),
            ),
          ])
        ],
      ),
    );
  }

  Future _pickImageFromGallery() async {
    final returnedImaged =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnedImaged == null) return;
      
    setState(() {
      _selectedImage = File(returnedImaged!.path);
    });
  }

  Future _pickImageFromCamera() async {
    final returnedImaged =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (returnedImaged == null) return;
      
    setState(() {
      _selectedImage = File(returnedImaged!.path);
    });
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
        // IconButton(
        //     onPressed: () {},
        //     icon: const Icon(
        //       Icons.dark_mode_outlined,
        //       size: 26,
        //     )
        //     Icons.dark_mode_sharp
        //     )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: _buildAppBar(context),
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.bottom,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.02,
                    ),
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: ((builder) => bottomSheet()),
                        );
                      },
                      child: Stack(
                        children: [
                          _selectedImage == null ? 
                          Icon(
                            Icons.account_circle,
                            size: MediaQuery.of(context).size.width * 0.25,
                            color: Colors.black54,
                          ) : 
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: Image.file(_selectedImage!).image,
                            // Image.file(_selectedImage!)
                          ),
                          Positioned(
                            bottom: 10.0,
                            right: 5.0,
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.teal,
                              size: 26.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.02,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.user!.username,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Builder(builder: (context) {
                          return GestureDetector(
                            onTap: () {
                              FlutterClipboard.copy(
                                      widget.user!.userId.toString())
                                  .then((value) {
                                return ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                        content: Text("UID has been copied!")));
                              });
                            },
                            child: Row(
                              children: [
                                Text(
                                  "UID: ${widget.user!.userId.toString()}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      FlutterClipboard.copy(
                                              widget.user!.userId.toString())
                                          .then((value) {
                                        return ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    "UID has been copied!")));
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.content_copy,
                                      size: 16,
                                    )),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                // Limits
                const Text(
                  "User Daily Limits",
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.01),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Withdrawals",
                            style: TextStyle(color: Colors.grey, fontSize: 15),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          const Text(
                            "Fiat Purchases",
                            style: TextStyle(color: Colors.grey, fontSize: 15),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          const Text(
                            "Crypto Deposits",
                            style: TextStyle(color: Colors.grey, fontSize: 15),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          const Text(
                            "Futures Leverage",
                            style: TextStyle(color: Colors.grey, fontSize: 15),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      margin: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width * 0.02),
                      child: Column(
                        children: [
                          const Text("999,999 USDT"),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          const Text("999,999 USDT"),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          const Icon(Icons.check),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          const Text("Up to 100x")
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                Container(
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 1, color: Colors.black))),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                // History
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PaymentHistory(
                                  user: widget.user,
                                )));
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.02,
                        top: MediaQuery.of(context).size.height * 0.016),
                    child: Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        const Icon(
                          Icons.access_time_sharp,
                          size: 48,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        const Text(
                          "History",
                          style: TextStyle(fontSize: 20, letterSpacing: 2),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 1, color: Colors.black))),
                ),
                // Security
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserSecurity(
                                  user: widget.user,
                                )));
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.02,
                        top: MediaQuery.of(context).size.height * 0.018),
                    child: Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        const Icon(
                          Icons.security_sharp,
                          size: 48,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        const Text(
                          "Security",
                          style: TextStyle(fontSize: 20, letterSpacing: 2),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 1, color: Colors.black))),
                ),
                // Settings
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserSettings(
                                  user: widget.user,
                                )));
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.02,
                        top: MediaQuery.of(context).size.height * 0.018),
                    child: Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        const Icon(
                          Icons.settings,
                          size: 48,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        const Text(
                          "Settings",
                          style: TextStyle(fontSize: 20, letterSpacing: 2),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 1, color: Colors.black))),
                ),
                // Support
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Support(
                                  user: widget.user,
                                )));
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.02,
                        top: MediaQuery.of(context).size.height * 0.018),
                    child: Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        const Icon(
                          Icons.support_agent_rounded,
                          size: 48,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        const Text(
                          "Support",
                          style: TextStyle(fontSize: 20, letterSpacing: 2),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 1, color: Colors.black))),
                ),
                // Logout
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Welcome()));
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.018),
                    child: Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        const Icon(
                          Icons.logout_sharp,
                          size: 46,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        const Text(
                          "Logout",
                          style: TextStyle(fontSize: 20, letterSpacing: 2),
                        )
                      ],
                    ),
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
