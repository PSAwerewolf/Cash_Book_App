import 'package:cash_book_app4/utils/appcolors.dart';
import 'package:cash_book_app4/utils/dropdownmenu_widget.dart';
import 'package:cash_book_app4/utils/line_chart_widget.dart';
import 'package:cash_book_app4/widgets/big_text.dart';
import 'package:flutter/material.dart';

import '../utils/app_icon.dart';
import '../utils/dimentions.dart';
import '../widgets/small_text.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
              top: Dimentions.height15,
              left: Dimentions.height10,
              right: Dimentions.height10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: Dimentions.pageView120 / 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BigText(
                      text: "Hello Axis Shop !!!",
                    ),
                    SizedBox(
                      width: Dimentions.width5,
                    ),
                    SmallText(
                      text: "Your Finance is Here!!!",
                      color: AppColors.paraColor,
                    ),
                  ],
                ),
              ),
              Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  DropdownMenuWidget(),
                  ElevatedButton(
                    onPressed: () async {
                      final DateTime? datetime = await showDatePicker(
                          context: context,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(3000),
                          initialDate: selectedDate);

                      if (datetime != null) {
                        setState(() {
                          selectedDate = datetime;
                        });
                      }
                    },
                    child: AppIcon(
                      iconData: Icons.calendar_month,
                      size: Dimentions.height45,
                      backgroundColor: Colors.transparent,
                      iconSize: Dimentions.iconSize24,
                    ),
                  ),
                ],
              )),
              //SizedBox(height: Dimentions.height15),
              Container(
                height: Dimentions.pageView120 / 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BigText(
                      text:
                          "${selectedDate.day} - ${selectedDate.month} - ${selectedDate.year}",
                    ),
                  ],
                ),
              ),
              //SizedBox(height: Dimentions.height10),
              Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: Dimentions.width30 * 6,
                          padding: EdgeInsets.symmetric(
                              vertical: Dimentions.height10,
                              horizontal: Dimentions.height15),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimentions.radius15),
                              border: Border.all(
                                  color: Colors.lightGreen, width: 2.0)),
                          child: Column(
                            children: [
                              BigText(
                                text: "Todays Income",
                                color: Colors.green,
                                size: Dimentions.font16,
                              ),
                              SizedBox(
                                height: Dimentions.height10,
                              ),
                              BigText(
                                text: "15000.00",
                                size: Dimentions.font26,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: Dimentions.width30 * 6,
                          padding: EdgeInsets.symmetric(
                              vertical: Dimentions.height10,
                              horizontal: Dimentions.height15),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimentions.radius15),
                              border: Border.all(
                                  color: Colors.redAccent, width: 2.0)),
                          child: Column(
                            children: [
                              BigText(
                                text: "Todays Expense",
                                color: Colors.red,
                                size: Dimentions.font16,
                              ),
                              SizedBox(
                                height: Dimentions.height10,
                              ),
                              BigText(
                                text: "15000.00",
                                size: Dimentions.font26,
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
                      width: Dimentions.width10 * 15,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                          vertical: Dimentions.height15,
                          horizontal: Dimentions.height20),
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius:
                              BorderRadius.circular(Dimentions.radius15)),
                      child: BigText(
                        text: "Sales",
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      width: Dimentions.width10 * 15,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                          vertical: Dimentions.height15,
                          horizontal: Dimentions.height20),
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius:
                              BorderRadius.circular(Dimentions.radius15)),
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
