import 'package:crypto_app/Models/user_model.dart';
import 'package:crypto_app/SQLite/database_helper.dart';
import 'package:crypto_app/registrationsuccess.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final username = TextEditingController();
  final phoneNum = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final referralId = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isVisiblePass = true;
  bool isVisibleConfirm = true;
  bool isVisibleReferral = true;
  bool isAgree = true;
  bool isAgreeColor = true;
  bool isUsernameInUse = false;
  bool isEmailInUse = false;
  FocusNode focusNodeFirst = FocusNode();
  FocusNode focusNodeLast = FocusNode();
  FocusNode focusNodeUser = FocusNode();
  FocusNode focusNodePhone = FocusNode();
  FocusNode focusNodeEmail = FocusNode();
  FocusNode focusNodePass = FocusNode();
  FocusNode focusNodeConfirm = FocusNode();
  FocusNode focusNodeReferral = FocusNode();
  RegExp regExPassword = RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$");
  final db = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    db.open();
  }

  checkUsername() async {
    var response = await db.checkUsername(username.text);
    if (response == true) {
      setState(() {
        isUsernameInUse = false;
      });
    } else {
      setState(() {
        isUsernameInUse = true;
      });
    }
  }

  checkEmail() async {
    var response = await db.checkEmail(email.text);
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
          elevation: 1,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.close_sharp),
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
                      // Register New Account
                      const ListTile(
                        title: Text(
                          "Register New Account",
                          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                      ),
                      // First Name Input Box
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        margin: const EdgeInsets.only(left: 4, right: 4, top: 25),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: TextFormField(
                          controller: firstName,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "First Name is required";
                            }
                            return null;
                          },
                          focusNode: focusNodeFirst,
                          decoration: InputDecoration(
                            label: const Text("First Name"),
                            labelStyle: TextStyle(
                              color: focusNodeFirst.hasFocus ? Colors.black : Colors.black
                            ),
                            border: InputBorder.none,
                            icon: const Icon(Icons.person),
                          ),
                        ),
                      ),
                      // Last Name Input Box
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        margin: const EdgeInsets.only(left: 4, right: 4, top: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: TextFormField(
                          controller: lastName,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Last Name is required";
                            }
                            return null;
                          },
                          focusNode: focusNodeLast,
                          decoration: InputDecoration(
                            label: const Text("Last Name"),
                            labelStyle: TextStyle(
                              color: focusNodeLast.hasFocus ? Colors.black : Colors.black
                            ),
                            border: InputBorder.none,
                            icon: const Icon(Icons.person),
                          ),
                        ),
                      ),
                      // Username Input Box
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        margin: const EdgeInsets.only(left: 4, right: 4, top: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: TextFormField(
                          controller: username,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Username is required";
                            } else if (value.length < 3) {
                              return "Minimum of 4 characters required";
                            } else if (isUsernameInUse == true) {
                              return "Username is already in use";
                            }
                            return null;
                          },
                          focusNode: focusNodeUser,
                          decoration: InputDecoration(
                            label: const Text("Username"),
                            labelStyle: TextStyle(
                              color: focusNodeUser.hasFocus ? Colors.black : Colors.black
                            ),
                            border: InputBorder.none,
                            icon: const Icon(Icons.person),
                          ),
                        ),
                      ),
                      // Phone Number Input Box
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        margin: const EdgeInsets.only(left: 4, right: 4, top: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: TextFormField(
                          controller: phoneNum,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Phone Number is required";
                            } else if (value.length != 10) {
                              return "Please enter a valid phone number";
                            }
                            return null;
                          },
                          focusNode: focusNodePhone,
                          decoration: InputDecoration(
                            label: const Text("Phone Number"),
                            labelStyle: TextStyle(
                              color: focusNodePhone.hasFocus ? Colors.black : Colors.black
                            ),
                            border: InputBorder.none,
                            icon: const Icon(Icons.local_phone_sharp),
                          ),
                        ),
                      ),
                      // Email Input Box
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        margin: const EdgeInsets.only(left: 4, right: 4, top: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: TextFormField(
                          controller: email,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Email is required";
                            } else if (!EmailValidator.validate(value)) {
                              return "Email must be valid";
                            } else if (isEmailInUse == true) {
                              return "Email is already in use";
                            }
                            return null;
                          },
                          focusNode: focusNodeEmail,
                          decoration: InputDecoration(
                            label: const Text("Email"),
                            labelStyle: TextStyle(
                              color: focusNodeEmail.hasFocus ? Colors.black : Colors.black
                            ),
                            border: InputBorder.none,
                            icon: const Icon(Icons.email_sharp),
                          ),
                        ),
                      ),
                      // Password Input Box
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        margin: const EdgeInsets.only(left: 4, right: 4, top: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: TextFormField(
                          controller: password,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Password is required";
                            } else if (!regExPassword.hasMatch(value)) {
                              return "Minimum eight characters, at least one uppercase \nletter, one lowercase letter, one number \nand one special character";
                            } // else return true
                            return null;
                          },
                          obscureText: isVisiblePass,
                          focusNode: focusNodePass,
                          decoration: InputDecoration(
                            label: const Text("Password"),
                            labelStyle: TextStyle(
                              color: focusNodePass.hasFocus ? Colors.black : Colors.black
                            ),
                            border: InputBorder.none,
                            icon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isVisiblePass = !isVisiblePass;
                                });
                              },
                              icon: Icon(isVisiblePass
                              ? Icons.visibility_off
                              : Icons.visibility)
                              ),
                          ),
                        ),
                      ),
                      // Confirm Password Input Box
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        margin: const EdgeInsets.only(left: 4, right: 4, bottom: 10, top: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: TextFormField(
                          controller: confirmPassword,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Confirm Password is required";
                            } else if (password.text != confirmPassword.text) {
                              return "Passwords don't match";
                            }
                            return null;
                          },
                          obscureText: isVisibleConfirm,
                          focusNode: focusNodeConfirm,
                          decoration: InputDecoration(
                            label: const Text("Confirm Password"),
                            labelStyle: TextStyle(
                              color: focusNodeConfirm.hasFocus ? Colors.black : Colors.black
                            ),
                            border: InputBorder.none,
                            icon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isVisibleConfirm = !isVisibleConfirm;
                                });
                              },
                              icon: Icon(isVisibleConfirm
                              ? Icons.visibility_off
                              : Icons.visibility)
                              ),
                          ),
                        ),
                      ),
                      // Referral ID Input Box
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        margin: const EdgeInsets.only(left: 4, right: 4),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isVisibleReferral = !isVisibleReferral;
                            });
                          },
                          child: Row(
                            children: [
                              const Text(
                                "Referral ID (Optional)",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(width: 5,),
                              Icon(
                                isVisibleReferral
                                ? Icons.keyboard_arrow_up_sharp
                                : Icons.keyboard_arrow_down_sharp,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: !isVisibleReferral,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          margin: const EdgeInsets.only(left: 4, right: 4, bottom: 10, top: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: TextFormField(
                            controller: referralId,
                            validator: (value) {
                              return null;
                            },
                            focusNode: focusNodeReferral,
                            decoration: InputDecoration(
                              label: const Text("Referral ID"),
                              labelStyle: TextStyle(
                                color: focusNodeReferral.hasFocus ? Colors.black : Colors.black
                              ),
                              border: InputBorder.none,
                              icon: const Icon(Icons.mobile_friendly_sharp),
                            ),
                          ),
                        ),
                      ),
                      // ToS agree
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        margin: const EdgeInsets.only(left: 4, right: 4, bottom: 15, top: 5),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isAgree = !isAgree;
                            });
                          },
                          child: Row(
                            children: [
                              Icon(
                                isAgree
                                ? Icons.radio_button_off_sharp
                                : Icons.radio_button_on_sharp,
                                size: 20,
                              ),
                              RichText(
                                text: TextSpan(
                                  text: 'By creating an account, I agree to Mintless\'\n',
                                  style: TextStyle(
                                    color: isAgreeColor ? Colors.black : Colors.redAccent,
                                    fontSize: 15,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: "Terms of Service ",
                                      style: TextStyle(
                                        color: isAgreeColor ? Colors.black : Colors.redAccent,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15
                                      ),
                                    ),
                                    TextSpan(
                                      text: "and ",
                                      style: TextStyle(
                                        color: isAgreeColor ? Colors.black : Colors.redAccent
                                      ),
                                    ),
                                    TextSpan(
                                      text: "Privacy Policy",
                                      style: TextStyle(
                                        color: isAgreeColor ? Colors.black : Colors.redAccent,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15
                                      ),
                                    ),
                                  ],
                                ),
                                ),
                            ],
                          ),
                        ),
                      ),
                      // Register Button
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        width: MediaQuery.of(context).size.width,
                        height: 55,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextButton(
                          onPressed: () async {
                            checkUsername();
                            if (isAgree == true) {
                              setState(() {
                                isAgreeColor = false;
                              });
                            } else {
                              setState(() {
                                isAgreeColor = true;
                              });
                            }
                            if (formKey.currentState!.validate() && isAgreeColor == true && isUsernameInUse == false && isEmailInUse == false) {
                              await db.insertUser(User(
                                firstName: firstName.text,
                                lastName: lastName.text,
                                username: username.text,
                                email: email.text,
                                phoneNum: phoneNum.text,
                                userPassword: password.text,
                                createdOn: DateTime.now().toIso8601String(),
                                isActive: 1,
                                permissions: "User"
                                )
                              ).whenComplete(() {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const RegistrationSuccess()
                                  ),
                                );
                              });
                            }
                          },
                          child: const Text(
                            "Register",
                            style: TextStyle(
                              color: Colors.white
                            ),
                          ),
                        ),
                      ),
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
