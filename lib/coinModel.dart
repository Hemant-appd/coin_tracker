import 'package:flutter/material.dart';

class Coin {
  Coin(
     this.name,
     this.symbol,
     this.imageUrl,
     this.price,
     this.change,
     this.changePercentage,
     this.rank,
     this.marketcap,
     this.high24,
     this.low24,
     this.circulating,
  );

  String name;
  String symbol;
  String imageUrl;
  num price;
  num change;
  num changePercentage;
  num rank;
  num marketcap;
  num high24;
  num low24;
  num circulating;

  factory Coin.fromJson(Map<String, dynamic> json) {
    return Coin(
       json['name'],
       json['symbol'],
       json['image'],
       json['current_price'],
       json['price_change_24h'],
       json['price_change_percentage_24h'],
       json['market_cap_rank'],
       json['market_cap'],
       json['high_24h'],
       json['low_24h'],
       json['circulating_supply'],

    );
  }
}

List<Coin> coinList = [];
