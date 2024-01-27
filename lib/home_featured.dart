import 'package:flutter/material.dart';
import 'package:crypto_app/coin_view.dart';

class FeaturedCoin extends StatelessWidget {
  var coin;
  FeaturedCoin({this.coin});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Coin(coin: coin,)
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black),
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 25, left: 25, top: 2, bottom: 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                    child: Image.network(coin.image),
                  ),
                  Text(
                    (coin.symbol).toUpperCase(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    '\$${coin.currentPrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 12
                      ),
                    ),
                  Text(
                    coin.priceChangePercentage24H >= 0
                    ? '+${coin.priceChangePercentage24H.toStringAsFixed(2)}%'
                    : coin.priceChangePercentage24H.toStringAsFixed(2) + "%",
                    style: TextStyle(
                      fontSize: 12,
                      color: coin.priceChangePercentage24H > 0
                      ? Colors.green
                      : Colors.red
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
