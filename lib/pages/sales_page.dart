import 'package:cash_book_app4/pages/add_sales.dart';
import 'package:cash_book_app4/pages/sales_grid.dart';
import 'package:cash_book_app4/utils/dimentions.dart';
import 'package:cash_book_app4/widgets/big_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/app_icon.dart';
import '../utils/appcolors.dart';
import '../utils/text_field.dart';

class SalesPage extends StatefulWidget {
  const SalesPage({super.key});

  @override
  State<SalesPage> createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(
                vertical: Dimentions.height10, horizontal: Dimentions.height10),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
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
                          return AddSales();
                        },
                      )),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: Dimentions.height10,
                        horizontal: Dimentions.width20),
                    child: BigText(
                      text: "New Sales",
                      color: Colors.white,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius:
                            BorderRadius.circular(Dimentions.radius15)),
                  ),
                ),
                SizedBox(
                  height: Dimentions.height10,
                ),
                BigText(text: "Date"),
                SizedBox(
                  height: Dimentions.height10,
                ),
                Container(child: SalesGrid()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
