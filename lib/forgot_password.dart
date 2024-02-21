import 'package:crypto_app/SQLite/database_helper.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final email = TextEditingController();
  final newPass = TextEditingController();
  final confirmNewPass = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isVisible = false;
  FocusNode focusNodeEmail = FocusNode();
  FocusNode focusNodeNew = FocusNode();
  FocusNode focusNodeConfirm = FocusNode();
  final db = DatabaseHelper();

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
        ),
        body: Container(
          color: const Color.fromARGB(255, 246, 244, 244),
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const Text("Enter Email linked to your account", style: TextStyle(fontSize: 16),),
                      // Email
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        margin: const EdgeInsets.only(left: 4, right: 4, bottom: 10, top: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white
                        ),
                        child: TextFormField(
                          controller: email,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Email is empty";
                            }
                            return null;
                          },
                          focusNode: focusNodeEmail,
                          decoration: InputDecoration(
                            label: const Text("Email"),
                            labelStyle: TextStyle(
                              color: focusNodeEmail.hasFocus
                              ? Colors.black
                              : Colors.black
                            ),
                            border: InputBorder.none,
                            icon: const Icon(Icons.person),
                          ),
                        ),
                      )
                    ],
                  )
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}