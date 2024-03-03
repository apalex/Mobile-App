import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:crypto_app/Models/user_model.dart';
import 'package:crypto_app/coin_view.dart';
import 'package:flutter/material.dart';

class RecommendedCoin extends StatelessWidget {
  var coin;
  final User? user;
  RecommendedCoin({this.coin, this.user});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Coin(coin: coin, user: user,)
          )
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 6, top: 12, bottom: 12),
        child: Row(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.07,),
            Expanded(
              flex: 1,
              child: SizedBox(
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
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: SizedBox(
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
                    '\$${coin.currentPrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                      ),
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
