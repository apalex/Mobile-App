import 'package:flutter/material.dart';
import 'package:crypto_app/Models/chart_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:syncfusion_flutter_charts/charts.dart';

class Coin extends StatefulWidget {
  var coin;
  Coin({this.coin});

  @override
  State<Coin> createState() => _CoinState();
}

class _CoinState extends State<Coin> {
  List<Chart>? coinChart;
  late TrackballBehavior trackballBehavior;
  List<String> timeList = [
    '1D', '1W', '1M', '3M', '6M', '1Y'
  ];
  
  @override
  void initState() {
    constructChart();
    trackballBehavior = TrackballBehavior(
      enable: true,
      activationMode: ActivationMode.singleTap,
    );
    super.initState();
  }
  
  Future<void> constructChart() async {
    var response = await http.get(Uri.parse('https://api.coingecko.com/api/v3/coins/bitcoin/ohlc?vs_currency=usd&days=1'), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
    });

    if (response.statusCode == 200) {
      Iterable x = json.decode(response.body);
      List<Chart> modelList = x.map((e) => Chart.fromJson(e)).toList();
      setState(() {
        coinChart = modelList;
      });
    } else {
      print(response.statusCode);
    }

  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Icon(Icons.arrow_back_sharp),
      ),
      title: Text(widget.coin.symbol.toUpperCase()),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.star_border, size: 28,)
          // Icons.star
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: _buildAppBar(context),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide())
                ),
                child: Row(
                  children: [
                    // Chart
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 3,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "Chart",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            letterSpacing: 1
                          ),
                        ),
                      ),
                    ),
                    // Coin Info
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Info",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          letterSpacing: 1
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Text(
                          widget.coin.currentPrice.toString(),
                          style: TextStyle(
                            color: Color.fromARGB(255, 72, 227, 152),
                            fontSize: 26
                          ),
                        ),
                        Text(
                          "+\$100   +25%",
                          style: TextStyle(
                            color: Color.fromARGB(255, 72, 227, 152),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Text("TestTestTestTestTest"),
                        Text("Test"),
                        Text("TestTestTestTestTest"),
                        Text("Test"),
                      ],
                    ),
                  ),
                ],
              ),
              Divider(),
              // Time Selector
              Row(
                children: [
                  Text(
                    '1D',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              // Chart
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.4,
                child: SfCartesianChart(
                  trackballBehavior: trackballBehavior,
                  zoomPanBehavior: ZoomPanBehavior(
                    enablePanning: true,
                    zoomMode: ZoomMode.x
                  ),
                  series: <CandleSeries>[
                    CandleSeries <Chart, int>(
                      enableSolidCandles: true,
                      enableTooltip: true,
                      bullColor: Colors.green,
                      bearColor: Colors.red,
                      dataSource: coinChart!,
                      xValueMapper: (Chart price, _) => price.time,
                      lowValueMapper:(Chart price, _) => price.low,
                      highValueMapper: (Chart price, _) => price.high,
                      openValueMapper: (Chart price, _) => price.open,
                      closeValueMapper: (Chart price, _) => price.close,
                      animationDuration: 100,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
