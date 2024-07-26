import 'package:cash_book_app4/pages/add_sales.dart';
import 'package:cash_book_app4/pages/sales_grid.dart';
import 'package:cash_book_app4/utils/dimentions.dart';
import 'package:cash_book_app4/utils/dropdownmenu_widget.dart';
import 'package:cash_book_app4/widgets/big_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/app_icon.dart';
import '../utils/appcolors.dart';
import '../utils/text_field.dart';

class SalesReport extends StatefulWidget {
  const SalesReport({super.key});

  @override
  State<SalesReport> createState() => _SalesReportState();
}

class _SalesReportState extends State<SalesReport> {
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
              DropdownMenuWidget(),
              BigText(text: "Date"),
              Container(
                //color: Colors.red,
                child: SalesGrid(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
