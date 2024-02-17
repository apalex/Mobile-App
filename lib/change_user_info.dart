import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:crypto_app/Models/user_model.dart';
import 'package:crypto_app/SQLite/database_helper.dart';

class ChangeUserInfo extends StatefulWidget {
  final User? user;
  final String? changeMode;
  const ChangeUserInfo({super.key, this.user, this.changeMode});

  @override
  State<ChangeUserInfo> createState() => _ChangeUserInfoState();
}

class _ChangeUserInfoState extends State<ChangeUserInfo> {
  final newValue = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isEmailInUse = false;
  FocusNode node = FocusNode();
  final db = DatabaseHelper();
  RegExp regExPassword = RegExp(
      r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$");

  checkEmail() async {
    var response = await db.checkEmail(newValue.text);
    if (response == true) {
      setState(() {
        isEmailInUse = false;
      });
    } else {
      setState(() {
        isEmailInUse = true;
      });
    }
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
          title: Text("Change ${widget.changeMode}"),
          centerTitle: true,
        ),
        body: Center(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  margin: const EdgeInsets.only(left: 4, right: 4, bottom: 50),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 241, 238, 238)),
                  child: TextField(
                    enabled: false,
                    decoration: InputDecoration(
                        label: Text(
                      "Current ${widget.changeMode}${widget.changeMode == "Phone" ? " Number" : ""}: ${widget.changeMode == "Email" ? widget.user?.email : widget.changeMode == "Password" ? widget.user?.userPassword : widget.user?.phoneNum}",
                      style: const TextStyle(color: Colors.black),
                    )),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  margin: const EdgeInsets.only(left: 4, right: 4, bottom: 50),
                  child: TextFormField(
                    focusNode: node,
                    controller: newValue,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter a new ${widget.changeMode == "Email" ? "email" : widget.changeMode == "Password" ? "password" : "phone number"}";
                      } else if (widget.changeMode == "Email" &&
                          !EmailValidator.validate(value)) {
                        return "Please enter a valid email";
                      } else if (widget.changeMode == "Email" &&
                          isEmailInUse == true) {
                        return "Email is already in use";
                      } else if (widget.changeMode == "Password" &&
                          !regExPassword.hasMatch(value)) {
                        return "Minimum eight characters, at least one uppercase \nletter, one lowercase letter, one number \nand one special character";
                      } else if (widget.changeMode == "Phone" &&
                          value.length != 10) {
                        return "Please enter a valid phone number";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      label: Text(
                        "Enter New ${widget.changeMode}${widget.changeMode == "Phone" ? " Number" : ""}",
                        style: const TextStyle(color: Colors.black),
                      ),
                      labelStyle: TextStyle(
                          color: node.hasFocus ? Colors.black : Colors.black),
                      enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 5, left: 4, right: 4),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10)),
                  child: TextButton(
                      onPressed: () async {
                        checkEmail();
                        if (formKey.currentState!.validate() &&
                            isEmailInUse == false) {
                          if (widget.changeMode == "Email") {
                            await db
                                .changeEmail(newValue.text, widget.user?.userId)
                                .whenComplete(() {
                              Navigator.pop(context);
                            });
                          } else if (widget.changeMode == "Password") {
                            await db
                                .changePassword(
                                    newValue.text, widget.user?.userId)
                                .whenComplete(() {
                              Navigator.pop(context);
                            });
                          } else {
                            await db
                                .changePhone(newValue.text, widget.user?.userId)
                                .whenComplete(() {
                              Navigator.pop(context);
                            });
                          }
                        }
                      },
                      child: const Text(
                        "Confirm",
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
