import 'package:cash_book_app4/utils/dropdownmenu_widget.dart';
import 'package:cash_book_app4/utils/line_chart_widget.dart';
import 'package:cash_book_app4/widgets/big_text.dart';
import 'package:flutter/material.dart';

import '../utils/app_icon.dart';
import '../widgets/small_text.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0, left: 10, right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BigText(
                      text: "Hello Axis Shop !!!",
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    SmallText(
                      text: "Your Finance is Here!!!",
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  DropdownMenuWidget(),
                  AppIcon(
                    iconData: Icons.calendar_month,
                    size: 50,
                    backgroundColor: Colors.transparent,
                    iconSize: 30,
                  ),
                ],
              )),
              SizedBox(height: 15),
              Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  color: Colors.lightGreen, width: 2.0)),
                          child: Column(
                            children: [
                              BigText(
                                text: "Todays Income",
                                color: Colors.green,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              BigText(
                                text: "15000.00",
                                size: 24,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  color: Colors.redAccent, width: 2.0)),
                          child: Column(
                            children: [
                              BigText(
                                text: "Todays Expense",
                                color: Colors.red,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              BigText(
                                text: "15000.00",
                                size: 24,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      //color: Colors.red,
                      child: LineChartWidget(),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 150,
                      alignment: Alignment.center,
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(15)),
                      child: BigText(
                        text: "Sales",
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      width: 150,
                      alignment: Alignment.center,
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(15)),
                      child: BigText(
                        text: "Expense",
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
