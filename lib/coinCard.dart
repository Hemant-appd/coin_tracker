import 'package:flutter/material.dart';
import 'Screen2.dart';
import 'coinModel.dart';

class CoinCard extends StatelessWidget {
  CoinCard(
     this.name,
     this.coinmodel,
    this.symbol,
    this.imageUrl,
    this.price,
     this.change,
    this.changePercentage,
  );

  String name;
  Coin coinmodel;
  String symbol;
  String imageUrl;
  double price;
  double change;
  double changePercentage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
      child: Container(
        height: 90,
        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius: BorderRadius.circular(20),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey[500],
          //     offset: Offset(4, 4),
          //     blurRadius: 10,
          //     spreadRadius: 1,
          //   ),
          //   BoxShadow(
          //     color: Colors.white,
          //     offset: Offset(-4, -4),
          //     blurRadius: 10,
          //     spreadRadius: 1,
          //   ),
          // ],
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.grey[500],
                  //     offset: Offset(4, 4),
                  //     blurRadius: 5,
                  //     spreadRadius: 1,
                  //   ),
                  //   BoxShadow(
                  //     color: Colors.white,
                  //     offset: Offset(-4, -4),
                  //     blurRadius: 5,
                  //     spreadRadius: 1,
                  //   ),
                  // ],
                ),
                height: 50,
                width: 50,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.network(coinmodel.imageUrl),
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        name,
                        style: TextStyle(
                          color: Colors.grey[900],
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                    ),
                    Text(
                      symbol.toUpperCase(),
                      style: TextStyle(
                        color: Colors.grey[900],
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Text('₹',style: TextStyle(
                        color: Colors.grey[900],
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),),
                      Text(
                        price.toDouble().toStringAsFixed(2),
                        style: TextStyle(
                          color: Colors.grey[900],
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    change.toDouble() < 0
                        ? change.toDouble().toStringAsFixed(2)
                        : '+' + change.toDouble().toStringAsFixed(2),
                    style: TextStyle(
                      color: change.toDouble() < 0 ? Colors.red : Colors.green,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    changePercentage.toDouble() < 0
                        ? changePercentage.toDouble().toStringAsFixed(2) + '%'
                        : '+' + changePercentage.toDouble().toStringAsFixed(2) + '%',
                    style: TextStyle(
                      color: changePercentage.toDouble() < 0
                          ? Colors.red
                          : Colors.green,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
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
