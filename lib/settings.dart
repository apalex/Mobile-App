import 'package:crypto_app/welcome.dart';
import 'package:flutter/material.dart';

class UserSettings extends StatelessWidget {
  const UserSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Settings",
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
                // Language
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.05,
                            top: MediaQuery.of(context).size.height * 0.03),
                        child: const Text(
                          "Language",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        )),
                    Container(
                        margin: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width * 0.05,
                            top: MediaQuery.of(context).size.height * 0.03),
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton<String>(
                            value: "English",
                            underline: Container(
                              height: 2,
                              color: Colors.grey,
                            ),
                            items: const [
                              DropdownMenuItem<String>(
                                  value: "English", child: Text("English"))
                            ],
                            onChanged: (String? dummy) {},
                          ),
                        )),
                  ],
                ),
                // Currency
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.05,
                            top: MediaQuery.of(context).size.height * 0.04),
                        child: const Text(
                          "Currency",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        )),
                    Container(
                        margin: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width * 0.05,
                            top: MediaQuery.of(context).size.height * 0.03),
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton<String>(
                            value: "USD(\$)",
                            underline: Container(
                              height: 2,
                              color: Colors.grey,
                            ),
                            items: const [
                              DropdownMenuItem<String>(
                                  value: "USD(\$)", child: Text("USD(\$)"))
                            ],
                            onChanged: (String? dummy) {},
                          ),
                        )),
                  ],
                ),
                // Theme
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.05,
                            top: MediaQuery.of(context).size.height * 0.04),
                        child: const Text(
                          "Theme",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        )),
                    Container(
                        margin: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width * 0.05,
                            top: MediaQuery.of(context).size.height * 0.03),
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton<String>(
                            value: "Light",
                            underline: Container(
                              height: 2,
                              color: Colors.grey,
                            ),
                            items: const [
                              DropdownMenuItem<String>(
                                  value: "Light", child: Text("Light"))
                            ],
                            onChanged: (String? dummy) {},
                          ),
                        )),
                  ],
                ),
                // Logout
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Welcome()));
                          },
                          child: const Text(
                            "Logout",
                            style: TextStyle(color: Colors.grey, fontSize: 22),
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
