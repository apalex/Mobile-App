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
    '1H', '2H', '1D', '1W', '6M', '1Y'
  ];
  List<bool> timeChoose = [
    true, false, false, false, false, false
  ];
  bool isRefresh = true;
  int timeAmt = 1;
  
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
    var response = await http.get(Uri.parse('https://api.coingecko.com/api/v3/coins/${widget.coin.id}/ohlc?vs_currency=usd&days=${timeAmt.toString()}'), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
    });

    setState(() {
      isRefresh = true;
    });

    if (response.statusCode == 200) {
      Iterable x = json.decode(response.body);
      List<Chart> modelList = x.map((e) => Chart.fromJson(e)).toList();
      setState(() {
        isRefresh = false;
        coinChart = modelList;
      });
    } else {
      print(response.statusCode);
    }
  }

  setTime(String time) {
    switch(time) {
      case '1H':
      setState(() {
        timeAmt = 1;
      });
      break;
      case '2H':
      setState(() {
        timeAmt = 7;
      });
      break;
      case '1D':
      setState(() {
        timeAmt = 30;
      });
      break;
      case '1W':
      setState(() {
        timeAmt = 90;
      });
      break;
      case '6M':
      setState(() {
        timeAmt = 180;
      });
      break;
      case '1Y':
      setState(() {
        timeAmt = 365;
      });
      break;
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
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.notification_add_outlined, size: 28,)
          // Icons.notifications
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
                        child: const Text(
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
                      child: const Text(
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
              // Chart Container will put a switch to whenever user clicks chart or info button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 6),
                        child: Text(
                          widget.coin.currentPrice.toString(),
                          style: const TextStyle(
                            color: Color.fromARGB(255, 72, 227, 152),
                            fontSize: 24
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4, right: 2, bottom: 2),
                        child: Text(widget.coin.priceChange24H > 0 ? '24h \$ Change: +${widget.coin.priceChange24H.toStringAsFixed(2)}' : '24h \$ Change: ${widget.coin.priceChange24H.toStringAsFixed(2)}', style: const TextStyle(fontSize: 13),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4, right: 2, top: 2),
                        child: Text(widget.coin.priceChangePercentage24H > 0 ? '24h % Change: +${widget.coin.priceChangePercentage24H.toStringAsFixed(2)}%' : '24h % Change: -${widget.coin.priceChangePercentage24H.toStringAsFixed(2)}%', style: const TextStyle(fontSize: 13),),
                      ),
                    ],
                  ),
                  // Coin Short Info Section
                  const Column(
                    children: [
                      Text('Market Cap Rank', style: TextStyle(color: Colors.grey, fontSize: 12),),
                      Text("24h High", style: TextStyle(color: Colors.grey, fontSize: 12),),
                      Text("24h Low", style: TextStyle(color: Colors.grey, fontSize: 12),),
                      Text("24h Volume(USDT)", style: TextStyle(color: Colors.grey, fontSize: 12),),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 4),
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Text('#${widget.coin.marketCapRank.toString()}', style: const TextStyle(fontSize: 12),),
                        Text('\$${widget.coin.high24H.toStringAsFixed(2)}', style: const TextStyle(fontSize: 12),),
                        Text('\$${widget.coin.low24H.toStringAsFixed(2)}', style: const TextStyle(fontSize: 12),),
                        Text('\$${widget.coin.marketCapChange24H.toStringAsFixed(2)}', style: const TextStyle(fontSize: 12),),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
              const Divider(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
              // Time Selector
              Container(
                height: MediaQuery.of(context).size.height * 0.04,
                child: ListView.builder(
                  itemCount: timeList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.035,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            timeChoose = [false, false, false, false, false, false];
                            timeChoose[index] = true;
                          });
                          setTime(timeList[index]);
                          constructChart();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width * 0.02,
                            vertical: MediaQuery.of(context).size.height * 0.005,
                          ),
                          child: Text(
                            timeList[index],
                            style: TextStyle(
                              fontSize: 15,
                              color: timeChoose[index] == true
                              ? Colors.black
                              : Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
              // Chart
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.4,
                child: isRefresh
                ? const Center(
                  child: CircularProgressIndicator(),
                ) : coinChart == null ? const Center(child: Text("This App is using a free API, so cannot send many requests in a short amount of time. Please wait a few minutes"),)
                : SfCartesianChart(
                  trackballBehavior: trackballBehavior,
                  zoomPanBehavior: ZoomPanBehavior(
                    enablePinching: true,
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
              // Buy / Sell Buttons
              Row(
                children: [
                  
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
