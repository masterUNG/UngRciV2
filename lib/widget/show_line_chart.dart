import 'package:fl_animated_linechart/fl_animated_linechart.dart';
import 'package:flutter/material.dart';

class ShowLineChart extends StatefulWidget {
  @override
  _ShowLineChartState createState() => _ShowLineChartState();
}

class _ShowLineChartState extends State<ShowLineChart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.8,
          padding: const EdgeInsets.all(16.0),
          child: buildAnimatedLineChart(),
        ),
      ),
    );
  }

  AnimatedLineChart buildAnimatedLineChart() {
    return AnimatedLineChart(
      LineChart.fromDateTimeMaps([
        createLine1(),
        createLine2(),
      ], [
        Colors.red,
        Colors.blue,
      ], [
        'UnitRed',
        'UnitBlue',
      ]),
    );
  }

  Map<DateTime, double> createLine1() {
    Map<DateTime, double> map = Map();
    map[DateTime.now().subtract(Duration(days: 40))] = 40.0;
    map[DateTime.now().subtract(Duration(days: 35))] = 60.0;
    map[DateTime.now().subtract(Duration(days: 30))] = 30.0;
    map[DateTime.now().subtract(Duration(days: 25))] = 50.0;
    map[DateTime.now().subtract(Duration(days: 20))] = 40.0;
    map[DateTime.now().subtract(Duration(days: 15))] = 60.0;
    map[DateTime.now().subtract(Duration(days: 10))] = 30.0;
    map[DateTime.now().subtract(Duration(days: 5))] = 50.0;
    return map;
  }

  Map<DateTime, double> createLine2() {
    Map<DateTime, double> map = Map();
    map[DateTime.now().subtract(Duration(days: 40))] = 10.0;
    map[DateTime.now().subtract(Duration(days: 35))] = 20.0;
    map[DateTime.now().subtract(Duration(days: 30))] = 30.0;
    map[DateTime.now().subtract(Duration(days: 25))] = 50.0;
    map[DateTime.now().subtract(Duration(days: 20))] = 40.0;
    map[DateTime.now().subtract(Duration(days: 15))] = 60.0;
    map[DateTime.now().subtract(Duration(days: 10))] = 30.0;
    map[DateTime.now().subtract(Duration(days: 5))] = 50.0;
    return map;
  }
}
