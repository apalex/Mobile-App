import 'package:crypto_app/Models/user_model.dart';
import 'package:crypto_app/SQLite/database_helper.dart';
import 'package:crypto_app/navigation_menu.dart';
import 'package:crypto_app/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class SplashScreen extends StatefulWidget {
  String? action;
  User? user;
  SplashScreen({super.key, @required this.action, this.user});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  var username;
  var password;

  void _checkLoginStatus() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    username = sharedPreferences.getString("username");
    password = sharedPreferences.getString("password");

    if (username != null && password != null) {
      final db = DatabaseHelper();
      User userlog = await db.getUser(username);
      Future.delayed(Duration(seconds: 1), () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => NavigationMenu(
          user: userlog,
        )));
      }
      );
    }
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    _checkLoginStatus();

    if (widget.action == "Boot") {
      Future.delayed(Duration(seconds: 3), () {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (_) => Welcome()));
      });
    } else {
      Future.delayed(Duration(seconds: 1), () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (_) => NavigationMenu(
                  user: widget.user,
                )));
      });
    }
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.black45, Colors.white24],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                ),
                Image.asset(
                  'assets/images/logo.png',
                  width: MediaQuery.of(context).size.width * 0.5,
                ),
              ],
            ),
            // Text
            Text(
              "Mintless Cryptocurrency",
              style: TextStyle(fontSize: 26),
            )
          ],
        ),
      ),
    );
  }
}
