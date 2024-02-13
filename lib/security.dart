import 'package:crypto_app/Models/user_model.dart';
import 'package:flutter/material.dart';

class UserSecurity extends StatefulWidget {
  final User? user;
  const UserSecurity({super.key, this.user});

  @override
  State<UserSecurity> createState() => _UserSecurityState();
}

class _UserSecurityState extends State<UserSecurity> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Security", style: TextStyle(letterSpacing: 1),),
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_sharp  ),
          ),
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.bottom,
            child: Column(
              children: [
                // Add InkWell to ontap material page route
                // Email
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05, top: MediaQuery.of(context).size.height * 0.03),
                      child: const Text("Change Email", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
                    ),
                    Container(
                      margin: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.05, top: MediaQuery.of(context).size.height * 0.03),
                      child: const Icon(Icons.arrow_right_sharp, size: 25,)
                    ),
                  ],
                ),
                // Password
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05, top: MediaQuery.of(context).size.height * 0.04),
                      child: const Text("Change Password", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
                    ),
                    Container(
                      margin: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.05, top: MediaQuery.of(context).size.height * 0.03),
                      child: const Icon(Icons.arrow_right_sharp, size: 25,)

                    ),
                  ],
                ),
                // Phone Number
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05, top: MediaQuery.of(context).size.height * 0.04),
                      child: const Text("Change Phone Number", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
                    ),
                    Container(
                      margin: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.05, top: MediaQuery.of(context).size.height * 0.03),
                      child: Row(
                        children: [
                          Text("(**${widget.user?.phoneNum})"),
                          const Icon(Icons.arrow_right_sharp, size: 25,)
                        ],
                      )
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}