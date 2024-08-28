import 'package:cash_book_app4/list_grids/expense_list_grid.dart';
import 'package:cash_book_app4/list_grids/expense_report_grid.dart';
import 'package:cash_book_app4/list_grids/sales_list_grid.dart';
import 'package:cash_book_app4/model/sales_model.dart';
import 'package:cash_book_app4/utils/dimentions.dart';
import 'package:cash_book_app4/utils/dropdownmenu_widget.dart';
import 'package:cash_book_app4/widgets/big_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseReport extends StatefulWidget {
  const ExpenseReport({super.key});

  @override
  State<ExpenseReport> createState() => ExpenseReportState();
}

class ExpenseReportState extends State<ExpenseReport> {
  final GlobalKey<DropdownMenuWidgetState> dropDownKey =
      GlobalKey<DropdownMenuWidgetState>();

  String? selectedValue;
  @override
  void initState() {
    selectedValue = dropDownKey.currentState?.getSelectedDate();
    super.initState();
  }

  void _updateSelectedValue(String value) {
    setState(() {
      selectedValue = value; // Update the selected value
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(
              vertical: Dimentions.height10, horizontal: Dimentions.height10),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BigText(text: "Expense Report"),
              DropdownMenuWidget(
                key: dropDownKey,
                onValueChanged: _updateSelectedValue,
              ),
              Container(
                //color: Colors.red,
                child: ExpenseReportGrid(
                  selectedValue: selectedValue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
