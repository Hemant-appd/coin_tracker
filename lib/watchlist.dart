
import 'dart:convert';


import 'package:coin_tracker/sharedpref.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'coinCard.dart';
import 'coinModel.dart';
import 'Screen2.dart';

class WatchList extends StatefulWidget {

  @override
  _WatchListState createState() => _WatchListState();
}

class _WatchListState extends State<WatchList> {
  List<Coin>coinList = [];
  List<String>wtclist=[];
  bool islistempty=true;
  void fun()async{
    List<String>list=await SharedFunctions.getUserWatchList();
    print(list);
    if(list.length>0){
      setState(() {
        islistempty=false;
        wtclist=list;
      });
    }
  }
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
            // Map<String, dynamic> map = values[i];
            // coinList1.add(Coin.fromJson(map));

            if(islistempty==false){
              for(int j=0;j<wtclist.length;j++) {
                if (values[i]['name'] == wtclist[j]) {
                  Map<String, dynamic> map = values[i];
                  coinList1.add(Coin.fromJson(map));
                }
              }
            }

          }
        }
        setState(() {
          coinList = coinList1;
        });
      }
      //return coinList;
    } else {
      throw Exception('Failed to load coins');
    }
  }

  @override
  void initState() {
    fun();
    fetchCoin();
    //Timer.periodic(Duration(seconds: 10), (timer) => fetchCoin());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   title: Center(
      //     child: Text(
      //       'COIN TRACKER',
      //       style: TextStyle(
      //         color: Colors.grey[900],
      //         fontSize: 20,
      //         fontWeight: FontWeight.w900,
      //       ),
      //     ),
      //   ),
      // ),
      body: islistempty==false?ListView.builder(
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
                return Screen2( coinList[index],);
              },),);
            },
          );
        },
      ):Center(child: Text('WatchList is Empty')),
    );
  }
}

