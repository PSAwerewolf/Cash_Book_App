import 'package:cash_book_app4/pages/add_expense.dart';
import 'package:cash_book_app4/pages/add_sales.dart';
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
  DateTime chartDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(
              top: Dimentions.height15,
              left: Dimentions.height10,
              right: Dimentions.height10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                SizedBox(height: Dimentions.height30),
                Container(
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
                SizedBox(height: Dimentions.height30),
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
                      SizedBox(
                        height: Dimentions.height15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                // Text color
                                shadowColor: Colors.black, // Shadow color
                                elevation: 1, // Elevation
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      Dimentions.radius15),
                                ),
                                padding: EdgeInsets.all(Dimentions.height10),
                              ),
                              onPressed: () {
                                setState(() {
                                  chartDate =
                                      chartDate.subtract(Duration(days: 1));
                                });
                              },
                              child: AppIcon(
                                iconData: Icons.arrow_back_ios,
                                backgroundColor: Colors.transparent,
                                iconColor: AppColors.mainColor,
                              )),
                          Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(Dimentions.width5),
                              width: Dimentions.width30 * 5,
                              child: BigText(
                                text:
                                    "${chartDate.day} - ${chartDate.month} - ${chartDate.year}",
                              )),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                // Text color
                                shadowColor: Colors.black, // Shadow color
                                elevation: 1, // Elevation
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      Dimentions.radius15),
                                ),
                                padding: EdgeInsets.all(Dimentions.height10),
                              ),
                              onPressed: () {
                                setState(() {
                                  chartDate = chartDate.add(Duration(days: 1));
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
      ),
    );
  }
}
