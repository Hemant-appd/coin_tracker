
import 'dart:convert';

import 'package:coin_tracker/coinCard.dart';
import 'package:coin_tracker/watchlist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'coinModel.dart';
import 'Screen2.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            bottom: TabBar(
              labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              unselectedLabelColor: Colors.grey,
              labelColor: Colors.grey[900],
              indicatorColor: Colors.grey[900],
              tabs: [
                Tab(text: 'All',),
                Tab(text: 'WatchList',),
              ],
            ),
            title: Center(child: Text('COIN TRACKER',
              style: TextStyle(
                color: Colors.grey[900],
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            ),
          ),
          body: TabBarView(
            children: [
              HomePage(),
              WatchList(),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  List<Coin>coinList = [];
  void fetchCoin() async {

    final response = await http.get(Uri.parse(
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=inr&order=market_cap_desc&per_page=100&page=1&sparkline=false'));

    if (response.statusCode == 200) {
      List<Coin>coinList1=[];
      List<dynamic> values = [];
      values = json.decode(response.body);
      if (values.length > 0) {
        for (int i = 0; i < 50; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            coinList1.add(Coin.fromJson(map));
          }
        }
        setState(() {
          coinList = coinList1;
        });
      }
    } else {
      throw Exception('Failed to load coins');
    }
  }

  @override
  void initState() {
    fetchCoin();
    //Timer.periodic(Duration(seconds: 10), (timer) => fetchCoin());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        body: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: coinList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              child: CoinCard(
                 coinList[index].name,
                 coinList[index],
                 coinList[index].symbol,
                 coinList[index].imageUrl,
                 coinList[index].price.toDouble(),
                 coinList[index].change.toDouble(),
                 coinList[index].changePercentage.toDouble(),
              ),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return Screen2(coinList[index],);
                },),);
              },
            );
          },
        ));
  }
}

