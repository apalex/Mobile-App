import 'package:crypto_app/Models/user_address_model.dart';
import 'package:crypto_app/Models/user_model.dart';
import 'package:crypto_app/Models/user_payment_mode.dart';
import 'package:crypto_app/SQLite/database_helper.dart';
import 'package:crypto_app/portfolio.dart';
import 'package:flutter/material.dart';

class Deposit extends StatefulWidget {
  final User? user;
  const Deposit({super.key, this.user});

  @override
  State<Deposit> createState() => _DepositState();
}

class _DepositState extends State<Deposit> {
  final address1 = TextEditingController();
  final address2 = TextEditingController();
  final province = TextEditingController();
  final city = TextEditingController();
  final zipCode = TextEditingController();
  final paymentAmt = TextEditingController();
  final formKey = GlobalKey<FormState>();
  FocusNode focusNodeA1 = FocusNode();
  FocusNode focusNodeA2 = FocusNode();
  FocusNode focusNodeProvince = FocusNode();
  FocusNode focusNodeCity = FocusNode();
  FocusNode focusNodeZipCode = FocusNode();
  FocusNode focusNodePaymentAmt = FocusNode();
  final db = DatabaseHelper();
  String paymentMethod = "Visa";

  @override
  void initState() {
    super.initState();
    db.open();
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
          title: const Text("Deposit USDT"),
          centerTitle: true,
        ),
        body: Container(
          color: const Color.fromARGB(255, 246, 244, 244),
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      // Address 1
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        margin: const EdgeInsets.only(left: 4, right: 4, top: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white
                        ),
                        child: TextFormField(
                          controller: address1,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter an address!";
                            }
                            return null;
                          },
                          focusNode: focusNodeA1,
                          decoration: InputDecoration(
                            label: const Text("Address 1"),
                            labelStyle: TextStyle(
                              color: focusNodeA1.hasFocus
                              ? Colors.black
                              : Colors.black
                            ),
                            border: InputBorder.none
                          ),
                        ),
                      ),
                      // Address 2
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        margin: const EdgeInsets.only(left: 4, right: 4, top: 25),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white
                        ),
                        child: TextFormField(
                          controller: address2,
                          validator: (value) {
                            if (value!.isEmpty) {
                              setState(() {
                                address2.text = "";
                              });
                            }
                            return null;
                          },
                          focusNode: focusNodeA2,
                          decoration: InputDecoration(
                            label: const Text("Address 2"),
                            labelStyle: TextStyle(
                              color: focusNodeA2.hasFocus
                              ? Colors.black
                              : Colors.black
                            ),
                            border: InputBorder.none
                          ),
                        ),
                      ),
                      // Country
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        margin: const EdgeInsets.only(left: 4, right: 4, top: 25),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white
                        ),
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton<String>(
                            value: "Canada",
                            underline: Container(
                              height: 2,
                              color: Colors.grey,
                            ),
                            items: const [
                              DropdownMenuItem<String>(
                                value: "Canada",
                                child: Text("Canada")
                              ),
                            ],
                            onChanged: (String? dummy) {},
                          )
                        ),
                      ),
                      // Province
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        margin: const EdgeInsets.only(left: 4, right: 4, top: 25),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white
                        ),
                        child: TextFormField(
                          controller: province,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter a Province!";
                            }
                            return null;
                          },
                          focusNode: focusNodeProvince,
                          decoration: InputDecoration(
                            label: const Text("Province"),
                            labelStyle: TextStyle(
                              color: focusNodeProvince.hasFocus
                              ? Colors.black
                              : Colors.black
                            ),
                            border: InputBorder.none
                          ),
                        ),
                      ),
                      // City
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        margin: const EdgeInsets.only(left: 4, right: 4, top: 25),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white
                        ),
                        child: TextFormField(
                          controller: city,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter a City!";
                            }
                            return null;
                          },
                          focusNode: focusNodeCity,
                          decoration: InputDecoration(
                            label: const Text("City"),
                            labelStyle: TextStyle(
                              color: focusNodeCity.hasFocus
                              ? Colors.black
                              : Colors.black
                            ),
                            border: InputBorder.none
                          ),
                        ),
                      ),
                      // Zip Code
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        margin: const EdgeInsets.only(left: 4, right: 4, top: 25),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white
                        ),
                        child: TextFormField(
                          controller: zipCode,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter a Zip Code!";
                            }
                            return null;
                          },
                          focusNode: focusNodeZipCode,
                          decoration: InputDecoration(
                            label: const Text("Zip Code"),
                            labelStyle: TextStyle(
                              color: focusNodeZipCode.hasFocus
                              ? Colors.black
                              : Colors.black
                            ),
                            border: InputBorder.none
                          ),
                        ),
                      ),
                      // Payment Method
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        margin: const EdgeInsets.only(left: 4, right: 4, top: 25),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white
                        ),
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton<String>(
                            value: paymentMethod,
                            underline: Container(
                              height: 2,
                              color: Colors.grey,
                            ),
                            items: const [
                              DropdownMenuItem<String>(
                                value: "Visa",
                                child: Text("Visa")
                              ),
                              DropdownMenuItem<String>(
                                value: "Mastercard",
                                child: Text("Mastercard")
                              ),
                              DropdownMenuItem<String>(
                                value: "Debit",
                                child: Text("Debit")
                              ),
                            ],
                            onChanged: (String? newValue) {
                              setState(() {
                                paymentMethod = newValue!;
                              });
                            },
                          )
                        ),
                      ),
                      // Payment Amount
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        margin: const EdgeInsets.only(left: 4, right: 4, top: 25),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white
                        ),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: paymentAmt,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter a value!";
                            } else if (double.parse(value) == 0 || double.parse(value) <= 0) {
                              return "Please enter a valid number";
                            }
                            return null;
                          },
                          focusNode: focusNodePaymentAmt,
                          decoration: InputDecoration(
                            label: const Text("Payment Amount"),
                            labelStyle: TextStyle(
                              color: focusNodePaymentAmt.hasFocus
                              ? Colors.black
                              : Colors.black
                            ),
                            border: InputBorder.none
                          ),
                        ),
                      ),
                      // Confirm Button
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        margin: const EdgeInsets.only(left: 4, right: 4, top: 25),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black
                        ),
                        child: TextButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              await db.insertUserAddress(UserAddress(
                                userId: widget.user?.userId,
                                address1: address1.text,
                                address2: address2.text,
                                country: "Canada",
                                province: province.text,
                                city: city.text,
                                zipCode: zipCode.text
                              )
                            ).whenComplete(() async{
                              await db.insertUserPayment(UserPayment(
                                userId: widget.user?.userId,
                                paymentMethod: paymentMethod,
                                paymentAmt: double.parse(paymentAmt.text.replaceAll(",", "")),
                                paymentDate: DateTime.now().toIso8601String()
                              )).whenComplete(() {
                                showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    title: const Text("Payment Notification", style: TextStyle(fontSize: 20),),
                                    content: Text("Payment was successfully placed! ${double.parse(paymentAmt.text.replaceAll(",", ""))} USDT to your account!", style: const TextStyle(color: Colors.grey),),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Portfolio(user: widget.user,)
                                            )
                                          );
                                        },
                                        child: const Text("OK", style: TextStyle(color: Colors.black),)
                                      ),
                                    ],
                                  ),
                                );
                              });
                            });
                          }
                        },
                          child: const Text("Confirm", style: TextStyle(color: Colors.white),)
                        ),
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