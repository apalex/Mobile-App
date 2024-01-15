import 'package:flutter/material.dart';

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
  final formKey = GlobalKey<FormState>();
  bool isVisiblePass = true;
  bool isVisibleConfirm = true;
  FocusNode focusNodeFirst = FocusNode();
  FocusNode focusNodeLast = FocusNode();
  FocusNode focusNodeUser = FocusNode();
  FocusNode focusNodePhone = FocusNode();
  FocusNode focusNodeEmail = FocusNode();
  FocusNode focusNodePass = FocusNode();
  FocusNode focusNodeConfirm = FocusNode();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Register"),
          centerTitle: true,
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
                            } // Make so if else email is valid/in use etc
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
                            }
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
                        margin: const EdgeInsets.only(left: 4, right: 4, bottom: 25, top: 15),
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
                      // Register Button
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 55,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextButton(
                          onPressed: () {

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
