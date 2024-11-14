import 'package:crypto_app/SQLite/database_helper.dart';
import 'package:crypto_app/Models/user_model.dart';
import 'package:crypto_app/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:crypto_app/registration.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final username = TextEditingController();
  final password = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isVisible = true;
  bool isWrong = false;
  FocusNode focusNodeUser = FocusNode();
  FocusNode focusNodePass = FocusNode();
  final db = DatabaseHelper();

  @override
  void initState() {
    getIP();
    super.initState();
  }

  login() async {
    User user = await db.getUser(username.text);
    var response = await db.login(username.text, password.text);
    if (response == true) {
      if (!mounted) return;
      insertUserLoginDate();
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => SplashScreen(
                    action: "Login",
                    user: user,
                  )));
    } else {
      setState(() {
        isWrong = true;
      });
    }
  }

  insertUserLoginDate() async {
    User user = await db.getUser(username.text);
    return await db.insertUserLoginDate(
        user.userId, DateTime.now().toIso8601String(), ipAddress);
  }

  String ipAddress = "";
  Future getIP() async {
    var response = await http.get(Uri.parse("https://api.ipify.org/"));
    setState(() {
      ipAddress = response.body;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Login"),
          centerTitle: true,
          elevation: 1,
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
                      // Welcome
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.045,
                      ),
                      Container(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            Expanded(
                              child: Divider(
                                thickness: 0.5,
                                color: Colors.grey[400],
                              ),
                            ),
                            const Text(
                              "Welcome back",
                              style: TextStyle(fontSize: 20),
                            ),
                            Expanded(
                                child: Divider(
                              thickness: 0.5,
                              color: Colors.grey[400],
                            )),
                          ],
                        ),
                      ),
                      // Username Input Box
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        margin: const EdgeInsets.only(
                            left: 4, right: 4, bottom: 10, top: 40),
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
                                color: focusNodeUser.hasFocus
                                    ? Colors.black
                                    : Colors.black),
                            border: InputBorder.none,
                            icon: const Icon(Icons.person),
                          ),
                        ),
                      ),
                      // Password Input Box
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        margin:
                            const EdgeInsets.only(left: 4, right: 4, top: 10),
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
                          obscureText: isVisible,
                          focusNode: focusNodePass,
                          decoration: InputDecoration(
                            label: const Text("Password"),
                            labelStyle: TextStyle(
                                color: focusNodePass.hasFocus
                                    ? Colors.black
                                    : Colors.black),
                            border: InputBorder.none,
                            icon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isVisible = !isVisible;
                                  });
                                },
                                icon: Icon(isVisible
                                    ? Icons.visibility_off
                                    : Icons.visibility)),
                          ),
                        ),
                      ),
                      // Login Button
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.045,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.height * 0.066,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              login();
                            }
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      // If Credentials are wrong
                      Visibility(
                        visible: isWrong,
                        child: Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: const Text(
                            "Wrong information. Please enter again",
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.125,
                      ),
                      // Not a member? Register now
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Not a member?"),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Registration()),
                              );
                            },
                            child: const Text(
                              "Register now",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
