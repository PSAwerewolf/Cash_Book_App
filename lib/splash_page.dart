import 'dart:async';

import 'package:cash_book_app4/routes/routes_helper.dart';
import 'package:cash_book_app4/utils/appcolors.dart';
import 'package:cash_book_app4/utils/dimentions.dart';
import 'package:cash_book_app4/widgets/big_text.dart';
import 'package:cash_book_app4/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Timer(const Duration(seconds: 10),
        () => Get.toNamed(RoutesHelper.getLoginPage()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            decoration: BoxDecoration(),
            child: Image.asset(
              "assets/images/cashBookBg.jpg",
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
