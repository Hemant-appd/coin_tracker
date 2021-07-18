import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SubscriberSeries {
  final String condition;
  final double price;
  final charts.Color barColor;

  SubscriberSeries(
      this.condition,
      this.price,
    this.barColor,

  );

}