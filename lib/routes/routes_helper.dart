import 'package:get/get.dart';

import '../pages/home_page.dart';
import '../splash_page.dart';

class RoutesHelper {
  static const String splashPage = "/splash-page";
  static const String homePage = "/home-page";

  static String getSplashPage() => "$splashPage";
  static String getHomePage() => "$homePage";

  static List<GetPage> routes = [
    GetPage(name: splashPage, page: () => SplashPage()),
    GetPage(name: homePage, page: () => HomePage()),
  ];
}
