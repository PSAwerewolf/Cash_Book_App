import 'dart:math';

import 'package:cash_book_app4/utils/appcolors.dart';
import 'package:cash_book_app4/widgets/small_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/big_text.dart';
import 'dimentions.dart';

class LineChartWidget extends StatefulWidget {
  const LineChartWidget({super.key});

  @override
  State<LineChartWidget> createState() => _LineChartWidgetState();
}

class _LineChartWidgetState extends State<LineChartWidget> {
  List<FlSpot> salesSpots() => [
        FlSpot(0, 20000),
        FlSpot(1, 30000),
        FlSpot(2, 15000),
        FlSpot(3, 25000),
        FlSpot(4, 40000),
        FlSpot(5, 80000),
        FlSpot(6, 80000),
      ];

  List<FlSpot> expenseSpots() => [
        FlSpot(0, 50000),
        FlSpot(1, 60000),
        FlSpot(2, 95000),
        FlSpot(3, 25000),
        FlSpot(4, 10000),
        FlSpot(5, 30000),
        FlSpot(6, 70000),
      ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.only(top: Dimentions.height10 * 5),
        //color: Colors.red,
        child: Column(
          children: [
            Container(
              color: Colors.blueGrey[200]?.withOpacity(0.2),
              height: Dimentions.pageView220,
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.all(Dimentions.height20),
                child: LineChart(
                  LineChartData(
                      minY: 0,
                      maxY: 100000,
                      lineBarsData: [
                        LineChartBarData(
                            spots: salesSpots(),
                            color: Colors.green,
                            barWidth: Dimentions.width5,
                            isCurved: true),
                        LineChartBarData(
                            spots: expenseSpots(),
                            color: Colors.red,
                            barWidth: Dimentions.width5,
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
                          ),
                          bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              switch (value) {
                                case 0:
                                  return BigText(text: 'M');
                                case 1:
                                  return BigText(text: 'T');
                                case 2:
                                  return BigText(text: 'W');
                                case 3:
                                  return BigText(text: 'T');
                                case 4:
                                  return BigText(text: 'F');
                                case 5:
                                  return BigText(text: 'S');
                                case 6:
                                  return BigText(text: 'S');
                              }
                              return BigText(text: '');
                            },
                          )))),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
