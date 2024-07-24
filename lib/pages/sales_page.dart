import 'package:cash_book_app4/pages/sales_grid.dart';
import 'package:cash_book_app4/widgets/big_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/appcolors.dart';

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
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BigText(text: "Enter your sales here"),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: BigText(
                  text: "New Sales",
                  color: Colors.white,
                ),
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(12)),
              ),
              SizedBox(
                height: 10,
              ),
              BigText(text: "Date"),
              SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                child: Container(
                  height: 500,
                  color: Colors.red,
                  child: SalesGrid(),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
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
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey, width: 2.0)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
