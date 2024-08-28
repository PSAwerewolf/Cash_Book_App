import 'package:cash_book_app4/list_grids/expense_list_grid.dart';
import 'package:cash_book_app4/widgets/add_expense.dart';
import 'package:cash_book_app4/widgets/add_sales.dart';
import 'package:cash_book_app4/list_grids/sales_list_grid.dart';
import 'package:cash_book_app4/utils/dimentions.dart';
import 'package:cash_book_app4/widgets/big_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../model/sales_model.dart';
import '../../utils/app_icon.dart';
import '../../utils/appcolors.dart';
import '../../utils/text_field.dart';

class ExpensePage extends StatefulWidget {
  const ExpensePage({super.key});

  @override
  State<ExpensePage> createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  String getDay(int day) {
    String dayString = " ";
    switch (day) {
      case 1:
        dayString = "Monday";
      case 2:
        dayString = "Tuesday";
      case 3:
        dayString = "Wednesday";
      case 4:
        dayString = "Thursday";
      case 5:
        dayString = "Friday";
      case 6:
        dayString = "Saturday";
      case 7:
        dayString = "Sunday";
    }
    return dayString;
  }

  @override
  Widget build(BuildContext context) {
    DateTime chartDate = DateTime.now();
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: Dimentions.width5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: Dimentions.height10,
                ),
                BigText(text: "Enter your sales here"),
                SizedBox(
                  height: Dimentions.height10,
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) =>
                          AlertDialog(content: StatefulBuilder(
                        builder: (context, setstate) {
                          return AddExpense();
                        },
                      )),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: Dimentions.height10,
                        horizontal: Dimentions.width20),
                    child: BigText(
                      text: "New Expense",
                      color: Colors.white,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius:
                            BorderRadius.circular(Dimentions.radius15)),
                  ),
                ),
                SizedBox(
                  height: Dimentions.height20,
                ),
                BigText(
                  text:
                      "Today : ${chartDate.day} - ${chartDate.month} - ${chartDate.year} (${getDay(chartDate.weekday)})",
                  size: Dimentions.font16,
                ),
                SizedBox(
                  height: Dimentions.height20,
                ),
                Container(child: ExpenseListGrid()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
