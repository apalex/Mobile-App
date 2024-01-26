import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:flutter/material.dart';

class RecommendedCoin extends StatelessWidget {
  var coin;
  RecommendedCoin({this.coin});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 6, top: 12, bottom: 6),
      child: Container(
        child: Row(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.07,),
            Expanded(
              flex: 1,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.06,
                child: Image.network(coin.image)
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.035,),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    coin.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                      ),
                  ),
                  Text(
                    '0.4' + coin.symbol,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.05,
                child: Sparkline(
                  data: coin.sparklineIn7D.price,
                  lineWidth: 2,
                  lineColor: Colors.green,
                  fillMode: FillMode.below,
                  fillGradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const[0, 0.7],
                    colors: [Colors.green, Colors.green.shade100],
                  ),
                ),
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.08,),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '\$' + coin.currentPrice.toStringAsFixed(2),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                      ),
                  ),
                  Text(
                    coin.priceChange24H.toStringAsFixed(2) + '%',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
