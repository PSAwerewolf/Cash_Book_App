import 'package:cash_book_app4/model/sales_model.dart';
import 'package:cash_book_app4/widgets/add_expense.dart';
import 'package:cash_book_app4/widgets/add_sales.dart';
import 'package:cash_book_app4/utils/appcolors.dart';
import 'package:cash_book_app4/utils/dropdownmenu_widget.dart';
import 'package:cash_book_app4/utils/line_chart_widget.dart';
import 'package:cash_book_app4/widgets/big_text.dart';
import 'package:flutter/material.dart';

import '../../utils/app_icon.dart';
import '../../utils/dimentions.dart';
import '../../widgets/small_text.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  DateTime selectedDate = DateTime.now();
  DateTime chartDate = DateTime.now();
  DateTime chartStartDate = DateTime.now().subtract(Duration(days: 7));

  String getMonth(int month) {
    String monthString = " ";
    switch (month) {
      case 1:
        monthString = "January";
      case 2:
        monthString = "February";
      case 3:
        monthString = "March";
      case 4:
        monthString = "April";
      case 5:
        monthString = "May";
      case 6:
        monthString = "June";
      case 7:
        monthString = "July";
      case 8:
        monthString = "August";
      case 9:
        monthString = "September";
      case 10:
        monthString = "October";
      case 11:
        monthString = "November";
      case 12:
        monthString = "December";
    }
    return monthString;
  }

  @override
  Widget build(BuildContext context) {
    double _totalMainSales = context.watch<SalesModel>().getTotalMainSales;
    double _totalExpense = context.read<SalesModel>().getTotalMainExpense;
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(Dimentions.width5),
          child: Column(
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
                      iconColor: AppColors.mainColor,
                    ),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      // Text color
                      shadowColor: Colors.black, // Shadow color
                      elevation: 1, // Elevation
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(Dimentions.radius15),
                      ),
                      padding: EdgeInsets.all(Dimentions.height10),
                    ),
                  ),
                ],
              )),
              SizedBox(height: Dimentions.height20),
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
                                text: "${_totalMainSales}",
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
                                text: "${_totalExpense}",
                                size: Dimentions.font26,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Dimentions.height15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              // Text color
                              shadowColor: Colors.black, // Shadow color
                              elevation: 1, // Elevation
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(Dimentions.radius15),
                              ),
                              padding: EdgeInsets.all(Dimentions.height10 / 2),
                            ),
                            onPressed: () {
                              setState(() {
                                chartDate = chartStartDate;
                                chartStartDate =
                                    chartStartDate.subtract(Duration(days: 7));
                              });
                            },
                            child: AppIcon(
                              iconData: Icons.arrow_back_ios,
                              backgroundColor: Colors.transparent,
                              iconColor: AppColors.mainColor,
                            )),
                        Container(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                BigText(
                                  text:
                                      "${getMonth(chartStartDate.month)} - ${chartStartDate.day}",
                                  color: Colors.black,
                                  size: Dimentions.font26 / 2,
                                ),
                                SizedBox(
                                  width: Dimentions.width10,
                                ),
                                BigText(
                                  text:
                                      "${getMonth(chartDate.month)} - ${chartDate.day} - ${chartDate.year} ",
                                  color: Colors.black,
                                  size: Dimentions.font26 / 2,
                                ),
                              ],
                            )),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              // Text color
                              shadowColor: Colors.black, // Shadow color
                              elevation: 1, // Elevation
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(Dimentions.radius15),
                              ),
                              padding: EdgeInsets.all(Dimentions.height10 / 2),
                            ),
                            onPressed: () {
                              setState(() {
                                chartStartDate = chartDate;
                                chartDate = chartDate.add(Duration(days: 7));
                              });
                            },
                            child: AppIcon(
                              iconData: Icons.arrow_forward_ios,
                              backgroundColor: Colors.transparent,
                              iconColor: AppColors.mainColor,
                            ))
                      ],
                    ),
                    SizedBox(height: Dimentions.height10),
                    Container(
                      alignment: Alignment.center,
                      //color: Colors.red,
                      padding: EdgeInsets.all(Dimentions.width10),
                      child: LineChartWidget(),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Dimentions.height10),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  content: AddSales(),
                                ));
                      },
                      child: Container(
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
                    ),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  content: AddExpense(),
                                ));
                      },
                      child: Container(
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
