import 'dart:math';

import 'package:cash_book_app4/widgets/small_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/big_text.dart';

class LineChartWidget extends StatefulWidget {
  const LineChartWidget({super.key});

  @override
  State<LineChartWidget> createState() => _LineChartWidgetState();
}

class _LineChartWidgetState extends State<LineChartWidget> {
  List<FlSpot> salesSpots() => [
        FlSpot(0, 80000),
        FlSpot(1, 20000),
        FlSpot(2, 30000),
        FlSpot(3, 15000),
        FlSpot(4, 25000),
        FlSpot(5, 40000),
        FlSpot(6, 80000),
        FlSpot(7, 80000),
      ];

  List<FlSpot> expenseSpots() => [
        FlSpot(0, 70000),
        FlSpot(1, 50000),
        FlSpot(2, 60000),
        FlSpot(3, 95000),
        FlSpot(4, 25000),
        FlSpot(5, 10000),
        FlSpot(6, 30000),
        FlSpot(7, 70000),
      ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.only(top: 50),
        //color: Colors.red,
        child: Column(
          children: [
            Container(
              //color: Colors.blue,
              height: 250,
              width: double.infinity,
              child: AspectRatio(
                aspectRatio: 2.0,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: LineChart(
                    LineChartData(
                        minY: 0,
                        maxY: 100000,
                        lineBarsData: [
                          LineChartBarData(
                              spots: salesSpots(),
                              color: Colors.green,
                              barWidth: 5,
                              isCurved: true),
                          LineChartBarData(
                              spots: expenseSpots(),
                              color: Colors.red,
                              barWidth: 5,
                              isCurved: true)
                        ],
                        clipData: FlClipData.all(),
                        borderData: FlBorderData(show: false),
                        titlesData: FlTitlesData(
                            topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: false,
                                getTitlesWidget: (value, meta) {
                                  return Text(value.toInt().toString());
                                },
                              ),
                            ))),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
