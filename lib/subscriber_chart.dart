import 'package:coin_tracker/SubscriberSeries.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class SubscriberChart extends StatelessWidget {
  List<SubscriberSeries>data=[];
  SubscriberChart( this.data);

  @override
  Widget build(BuildContext context) {
    List<charts.Series<SubscriberSeries,String>>series=[
      charts.Series(
        id: "Price Comparison",
        data: data,
        domainFn : (SubscriberSeries series, _)=>series.condition,
        measureFn : (SubscriberSeries series, _)=>series.price,
        colorFn :  (SubscriberSeries series, _)=>series.barColor,
      )
    ];
    return charts.BarChart(series,animate: true,);
  }
}
