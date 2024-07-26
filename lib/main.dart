import 'package:cash_book_app4/pages/login_page.dart';
import 'package:cash_book_app4/routes/routes_helper.dart';
import 'package:cash_book_app4/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //print("Content Height :" + MediaQuery.of(context).size.width.toString());
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashPage(),
      initialRoute: RoutesHelper.getSplashPage(),
      getPages: RoutesHelper.routes,
    );
  }
}
