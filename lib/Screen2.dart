import 'package:coin_tracker/coinModel.dart';
import 'package:coin_tracker/sharedpref.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
//import 'package:shared_preferences/shared_preferences.dart';
import 'coinModel.dart';
import 'SubscriberSeries.dart';
import 'subscriber_chart.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Screen2 extends StatefulWidget {

  Screen2(
    this.coinmodel,
  );
  Coin coinmodel;

  @override
  _Screen2State createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  bool ispresent=false;
  void fun()async{
    List<String>list=await SharedFunctions.getUserWatchList();
    //print(list);
    for(int i=0;i<list.length;i++){
      if(list[i]==widget.coinmodel.name){
        setState(() {
          ispresent=true;
        });
        break;
      }
    }
  }
  @override
  void initState() {
    fun();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    List<SubscriberSeries>data=[
      SubscriberSeries( '1D High', widget.coinmodel.high24.toDouble(), charts.ColorUtil.fromDartColor(Colors.green)),
      SubscriberSeries('Current Price', widget.coinmodel.price.toDouble(), charts.ColorUtil.fromDartColor(Colors.blue)),
      SubscriberSeries( '1D Low',  widget.coinmodel.low24.toDouble(), charts.ColorUtil.fromDartColor(Colors.red)),
    ];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.coinmodel.symbol.toUpperCase(),
              style: TextStyle(
                color: Colors.grey[900],
                fontSize: 25,
                fontWeight: FontWeight.w500,
              ),
            ),
            IconButton(
              icon: ispresent==true?Icon(Icons.star):Icon(Icons.star_border),
              onPressed: ()async{
                // List<String>st=await SharedFunctions.getUserWatchList();
                //   setState(() {
                //     st.add(widget.coinmodel.name);
                //   });
                // await SharedFunctions.saveUserWatchList(st);
                if(ispresent){
                  List<String>st=await SharedFunctions.getUserWatchList();
                  st.remove(widget.coinmodel.name);
                  // for(int i=0;i<st.length;i++){
                  //   if(st[i]==widget.coinmodel.name)
                  // }
                  await SharedFunctions.saveUserWatchList(st);
                  setState(() {
                    ispresent=false;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${widget.coinmodel.symbol.toUpperCase()} removed from Watchlist'),));
                }
                else{
                  List<String>st=await SharedFunctions.getUserWatchList();
                  setState(() {
                    st.add(widget.coinmodel.name);
                  });
                  await SharedFunctions.saveUserWatchList(st);
                  setState(() {
                    ispresent=true;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${widget.coinmodel.name} added to Watchlist'),));
                }
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(20),

                    ),
                    height: 60,
                    width: 60,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.network(widget.coinmodel.imageUrl),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Current Buying Price',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.grey[900],
                        fontSize: 15,
                      ),
                    ),
                    Row(
                      children: [
                        Text('₹',style: TextStyle(
                          color: Colors.grey[900],
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),),
                        Text(
                          widget.coinmodel.price.toDouble().toStringAsFixed(2),
                          style: TextStyle(
                            color: Colors.grey[900],
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 10,),
                        Text(
                          widget.coinmodel.changePercentage.toDouble() < 0
                              ? widget.coinmodel.changePercentage.toDouble().toStringAsFixed(2) + '%'
                              : '+' + widget.coinmodel.changePercentage.toDouble().toStringAsFixed(2) + '%',
                          style: TextStyle(
                            color: widget.coinmodel.changePercentage.toDouble() < 0
                                ? Colors.red
                                : Colors.green,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10,
              width: double.infinity,
            ),
            Container(
              height: 60,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '1 Day Highest:  ',
                        style: TextStyle(
                          color: Colors.grey[900],
                          fontSize: 12,
                        ),
                      ),
                      Row(
                        children: [
                          Text('₹',style: TextStyle(
                            color: Colors.grey[900],
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),),
                          Text(
                            widget.coinmodel.high24.toStringAsFixed(2),
                            style: TextStyle(
                              color: Colors.grey[900],
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    height: 17,
                    child: VerticalDivider(
                      color: Colors.grey[500],
                      thickness: 2,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '1 Day Lowest:  ',
                        style: TextStyle(
                          color: Colors.grey[900],
                          fontSize: 12,
                        ),
                      ),
                      Row(
                        children: [
                          Text('₹',style: TextStyle(
                            color: Colors.grey[900],
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),),
                          Text(
                            widget.coinmodel.low24.toStringAsFixed(2),
                            style: TextStyle(
                              color: Colors.grey[900],
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),
                ],
              ),
            ),
            // SizedBox(
            //   height: 10,
            //   width: double.infinity,
            // ),

            // SizedBox(
            //   height: 10,
            //   width: double.infinity,
            // ),
            // SizedBox(
            //   height: 20,
            //   width: double.infinity,
            // ),

            SizedBox(
              height: 20,
              width: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.only(left: 10),
                color: Colors.white,
                height: 200,
                //width: 300,
                child: Center(
                  child: SubscriberChart(
                     data,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
              width: double.infinity,
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        'About ${widget.coinmodel.name}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,

                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              FaIcon(
                                FontAwesomeIcons.chartBar,
                              ),
                              SizedBox(width:5),
                              Text(
                                  'Market Rank'
                              ),
                            ],
                          ),
                          Text(
                            '#${widget.coinmodel.rank}',
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              FaIcon(
                                FontAwesomeIcons.globe,
                              ),
                              SizedBox(width:5),
                              Text(
                                  'Market Cap'
                              ),
                            ],
                          ),
                          Text(
                            '₹${widget.coinmodel.marketcap}',
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              FaIcon(
                                FontAwesomeIcons.chartLine,
                              ),
                              SizedBox(width:5),
                              Text(
                                  'Price Change'
                              ),
                            ],
                          ),
                          Text(
                            widget.coinmodel.change.toDouble() < 0
                                ? widget.coinmodel.change.toDouble().toStringAsFixed(2)
                                : '+' + widget.coinmodel.change.toDouble().toStringAsFixed(2),
                            style: TextStyle(
                              color: widget.coinmodel.change.toDouble() < 0 ? Colors.red : Colors.green,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              FaIcon(
                                FontAwesomeIcons.coins,
                              ),
                              SizedBox(width:5),
                              Text(
                                  'Circulating Supply'
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                '${widget.coinmodel.circulating}',
                              ),
                              SizedBox(width:5),
                              Text(
                                '${widget.coinmodel.symbol.toUpperCase()}',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}







