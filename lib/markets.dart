import 'package:crypto_app/main.dart';
import 'package:flutter/material.dart';
import 'package:crypto_app/coin.dart';

class Markets extends StatefulWidget {
  const Markets({Key? key}) : super(key: key);

  @override
  State<Markets> createState() => _MarketsState();
}

class _MarketsState extends State<Markets> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            showSearch(
              context: context,
              delegate: CustomSearchDelegate(),
              );
          },
          child: const TextField(
            decoration: InputDecoration(
              hintText: "search",
            ),
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              showSearch(
                context: context, 
                delegate: CustomSearchDelegate(),
                );
            }, 
            icon: const Icon(Icons.search)
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20.0,
          right: 20.0,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: 20.0
              ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ListView.builder(
                  itemCount: 11,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey[700]!,
                                  offset: const Offset(2, 15),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
}
