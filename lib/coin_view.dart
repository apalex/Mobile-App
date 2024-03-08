import 'package:crypto_app/Models/user_model.dart';
import 'package:crypto_app/buy_or_sell.dart';
import 'package:flutter/material.dart';
import 'package:crypto_app/Models/chart_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class Coin extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  var coin;
  final User? user;
  Coin({super.key, this.coin, this.user});

  @override
  State<Coin> createState() => _CoinState();
}

class _CoinState extends State<Coin> {
  List<Chart>? coinChart;
  late TrackballBehavior trackballBehavior;
  List<String> timeList = ['1H', '2H', '1D', '1W', '6M', '1Y'];
  List<bool> timeChoose = [true, false, false, false, false, false];
  bool isRefresh = true;
  bool isChart = true;
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
    var response = await http.get(
        Uri.parse(
            'https://api.coingecko.com/api/v3/coins/${widget.coin.id}/ohlc?vs_currency=usd&days=${timeAmt.toString()}'),
        headers: {
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
    switch (time) {
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
        // IconButton(
        //     onPressed: () {},
        //     icon: Icon(
        //       Icons.star_border,
        //       size: 28,
        //     )
        //     Icons.star
        //     ),
        // IconButton(
        //     onPressed: () {},
        //     icon: Icon(
        //       Icons.notification_add_outlined,
        //       size: 28,
        //     )
        //     Icons.notifications
        //     ),
      ],
    );
  }

  Widget _buildChartSection(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.11,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 12),
                child: Column(
                  children: [
                    Text(
                      widget.coin.currentPrice.toString(),
                      style: const TextStyle(
                          color: Color.fromARGB(255, 72, 227, 152),
                          fontSize: 24),
                    ),
                    Text(
                      widget.coin.priceChange24H > 0
                          ? '24h \$ Change: +${widget.coin.priceChange24H.toStringAsFixed(2)}'
                          : '24h \$ Change: ${widget.coin.priceChange24H.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 13),
                    ),
                    Text(
                      widget.coin.priceChangePercentage24H > 0
                          ? '24h % Change: +${widget.coin.priceChangePercentage24H.toStringAsFixed(2)}%'
                          : '24h % Change: -${widget.coin.priceChangePercentage24H.toStringAsFixed(2)}%',
                      style: const TextStyle(fontSize: 13),
                    ),
                  ],
                ),
              ),
              // Coin Short Info Section
              Container(
                margin: const EdgeInsets.only(top: 15),
                child: const Column(
                  children: [
                    Text(
                      'Market Cap Rank',
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                    Text(
                      "24h High",
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                    Text(
                      "24h Low",
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                    Text(
                      "24h Volume(USDT)",
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 4, top: 15),
                padding: const EdgeInsets.only(left: 12, right: 12),
                child: Column(
                  children: [
                    Text(
                      '#${widget.coin.marketCapRank.toString()}',
                      style: const TextStyle(fontSize: 13),
                    ),
                    Text(
                      '\$${widget.coin.high24H.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 13),
                    ),
                    Text(
                      '\$${widget.coin.low24H.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 13),
                    ),
                    Text(
                      '\$${widget.coin.marketCapChange24H.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 13),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
        const Divider(),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
        // Time Selector
        SizedBox(
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
              }),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
        // Chart
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.45,
          child: isRefresh
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : coinChart == null
                  ? const Center(
                      child: Text(
                          "This App is using a free API, so you cannot send many requests in a short amount of time. Please wait a few minutes"),
                    )
                  : SfCartesianChart(
                      trackballBehavior: trackballBehavior,
                      zoomPanBehavior: ZoomPanBehavior(
                          enablePinching: true, zoomMode: ZoomMode.x),
                      series: <CandleSeries>[
                        CandleSeries<Chart, int>(
                          enableSolidCandles: true,
                          enableTooltip: true,
                          bullColor: Colors.green,
                          bearColor: Colors.red,
                          dataSource: coinChart!,
                          xValueMapper: (Chart price, _) => price.time,
                          lowValueMapper: (Chart price, _) => price.low,
                          highValueMapper: (Chart price, _) => price.high,
                          openValueMapper: (Chart price, _) => price.open,
                          closeValueMapper: (Chart price, _) => price.close,
                          animationDuration: 100,
                        ),
                      ],
                    ),
        ),
        // Buy / Sell Buttons
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.09,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 6, left: 6),
                width: MediaQuery.of(context).size.width * 0.45,
                height: MediaQuery.of(context).size.height * 0.055,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BuyOrSell(
                                  user: widget.user,
                                  action: "Buy",
                                  coin: widget.coin,
                                )));
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: const Text(
                    "Buy",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 6, left: 6),
                width: MediaQuery.of(context).size.width * 0.45,
                height: MediaQuery.of(context).size.height * 0.055,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BuyOrSell(
                                  user: widget.user,
                                  action: "Sell",
                                  coin: widget.coin,
                                )));
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text(
                    "Sell",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoSection(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(top: 10),
          child: Row(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
                child: Image.network(widget.coin.image),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.02,
              ),
              Text(
                "${widget.coin.name} (${widget.coin.symbol.toUpperCase()})",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(bottom: 10),
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.013,
              ),
              const Text(
                "Infrastructure",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    decoration: TextDecoration.underline),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(children: [
              Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: const Text(
                    "Ranking",
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  )),
              Container(
                margin: const EdgeInsets.only(bottom: 12),
                child: const Text(
                  "Total Supply",
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: const Text(
                    "Max Supply",
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  )),
              Container(
                margin: const EdgeInsets.only(bottom: 12),
                child: const Text(
                  "Circulating Supply",
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 12),
                child: const Text(
                  'Market Cap',
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 12, left: 6),
                child: const Text(
                  "Fully Diluted Valution (FDV)",
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 12),
                child: const Text(
                  "Total Volume",
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 12),
                child: const Text(
                  "All Time High (ATH)",
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 12),
                child: const Text(
                  "ATH Percentage Change",
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 12),
                child: const Text(
                  "ATH Date",
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 12),
                child: const Text(
                  "All Time Low (ATL)",
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 12),
                child: const Text(
                  "ATL Percentage Change",
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 12),
                child: const Text(
                  "ATL Date",
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 12),
                child: const Text(
                  "Last Updated",
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              )
            ]),
            Column(children: [
              Container(
                margin: const EdgeInsets.only(bottom: 12, right: 12),
                child: Text(
                  "#${widget.coin.marketCapRank.toString()}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 12, right: 12),
                child: Text(
                  widget.coin.totalSupply.toStringAsFixed(0),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 12, right: 12),
                child: Text(
                  widget.coin.maxSupply != null
                      ? widget.coin.maxSupply.toStringAsFixed(0)
                      : "None",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 12, right: 12),
                child: Text(
                  widget.coin.circulatingSupply.toStringAsFixed(0),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 12, right: 12),
                child: Text(
                  widget.coin.marketCap.toString(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 12, right: 12),
                child: Text(
                  widget.coin.fullyDilutedValuation.toString(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 12, right: 12),
                child: Text(
                  widget.coin.totalVolume.toStringAsFixed(0),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 12, right: 12),
                child: Text(
                  "\$${widget.coin.ath.toStringAsFixed(2)}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 12, right: 12),
                child: Text(
                  "${widget.coin.athChangePercentage.toStringAsFixed(2)}%",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 12, right: 12),
                child: Text(
                  DateFormat('yyy-MM-dd - kk:mm').format(widget.coin.athDate),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 12, right: 12),
                child: Text(
                  "\$${widget.coin.atl.toString()}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 12, right: 12),
                child: Text(
                  "+${widget.coin.atlChangePercentage.toStringAsFixed(2)}%",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 12, right: 12),
                child: Text(
                  DateFormat('yyy-MM-dd - kk:mm').format(widget.coin.atlDate),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 12, right: 12),
                child: Text(
                  DateFormat('yyy-MM-dd - kk:mm')
                      .format(widget.coin.lastUpdated),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
            ]),
          ],
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
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Container(
                decoration:
                    const BoxDecoration(border: Border(bottom: BorderSide())),
                child: Row(
                  children: [
                    // Chart
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 3,
                            color: isChart ? Colors.black : Colors.white,
                          ),
                        ),
                      ),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            isChart = true;
                          });
                        },
                        child: Text(
                          "Chart",
                          style: TextStyle(
                              color: isChart ? Colors.black : Colors.grey,
                              fontSize: 16,
                              letterSpacing: 1),
                        ),
                      ),
                    ),
                    // Coin Info
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 3,
                            color:
                                isChart == false ? Colors.black : Colors.white,
                          ),
                        ),
                      ),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            isChart = false;
                          });
                        },
                        child: Text(
                          "Info",
                          style: TextStyle(
                              color:
                                  isChart == false ? Colors.black : Colors.grey,
                              fontSize: 16,
                              letterSpacing: 1),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Main Body
              isChart
                  ? _buildChartSection(context)
                  : _buildInfoSection(context),
            ],
          ),
        ),
      ),
    );
  }
}
