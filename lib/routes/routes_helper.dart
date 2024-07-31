import 'dart:math';

import 'package:cash_book_app4/pages/auth/login_page.dart';
import 'package:cash_book_app4/pages/Report/sales_report.dart';
import 'package:get/get.dart';

import '../pages/Report/expense_report.dart';
import '../pages/home/home_page.dart';
import '../splash_page.dart';

class RoutesHelper {
  static const String splashPage = "/splash-page";
  static const String homePage = "/home-page";
  static const String salesReport = "/sales-report";
  static const String expenseReport = "/expense-report";
  static const String loginPage = "/login-page";

  static String getSplashPage() => "$splashPage";
  static String getHomePage() => "$homePage";
  static String getSalesReport() => "$salesReport";
  static String getExpenseReport() => "$expenseReport";
  static String getLoginPage() => "$loginPage";

  static List<GetPage> routes = [
    GetPage(name: splashPage, page: () => SplashPage()),
    GetPage(name: homePage, page: () => HomePage()),
    GetPage(name: salesReport, page: () => SalesReport()),
    GetPage(name: expenseReport, page: () => ExpenseReport()),
    GetPage(name: loginPage, page: () => LoginPage()),
  ];
}
