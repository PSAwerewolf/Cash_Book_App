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
        body: Container(
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
                    builder: (context) => AlertDialog(
                        actions: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              MaterialButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          Dimentions.radius15)),
                                  padding: EdgeInsets.symmetric(
                                      vertical: Dimentions.height10,
                                      horizontal: Dimentions.width10),
                                  color: AppColors.paraColor,
                                  elevation: 0.1,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: BigText(
                                    text: "Cancel",
                                    color: Colors.white,
                                  )),
                              MaterialButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          Dimentions.radius15)),
                                  padding: EdgeInsets.symmetric(
                                      vertical: Dimentions.height10,
                                      horizontal: Dimentions.width10),
                                  color: AppColors.mainColor,
                                  elevation: 0.1,
                                  onPressed: () {},
                                  child: BigText(
                                    text: "Add",
                                    color: Colors.white,
                                  )),
                            ],
                          ),
                        ],
                        title: Center(
                          child: BigText(
                            text: "New Sales",
                          ),
                        ),
                        content: StatefulBuilder(
                          builder: (context, setstate) {
                            return AddSales();
                          },
                        )),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  child: BigText(
                    text: "New Sales",
                    color: Colors.white,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
              SizedBox(
                height: Dimentions.height10,
              ),
              BigText(text: "Date"),
              SizedBox(
                height: Dimentions.height10,
              ),
              SingleChildScrollView(
                child: Container(
                  height: Dimentions.pageView450,
                  color: Colors.red,
                  child: SalesGrid(),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: Dimentions.height15,
                    horizontal: Dimentions.height10),
                width: double.infinity,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      BigText(
                        text: "Total Amount : ",
                      ),
                      BigText(
                        text: "Rs. 150000.00",
                      ),
                    ]),
                decoration: BoxDecoration(
                    //color: Colors.blue,
                    borderRadius: BorderRadius.circular(Dimentions.radius15),
                    border: Border.all(color: Colors.grey, width: 2.0)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
