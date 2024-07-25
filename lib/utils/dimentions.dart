import 'package:get/get.dart';

class Dimentions {
  //print("Content Height :" + MediaQuery.of(context).size.width.toString());
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;

  // Size 220
  static double pageView220 = screenHeight / 3.936;
  // Size 120
  static double pageView120 = screenHeight / 7.22;
  // Size 320
  static double pageView320 = screenHeight / 2.71;

  static double pageView450 = screenHeight / 1.92;

  static double height10 = screenHeight / 86.6;
  static double height15 = screenHeight / 57.73;
  static double height20 = screenHeight / 43.3;
  static double height30 = screenHeight / 28.87;
  static double height45 = screenHeight / 19.24;

  static double width5 = screenHeight / 173.2;
  static double width10 = screenHeight / 86.6;
  static double width15 = screenHeight / 57.73;
  static double width20 = screenHeight / 43.3;
  static double width25 = screenHeight / 36.64;
  static double width30 = screenHeight / 28.87;

  static double font16 = screenHeight / 54.125;
  static double font20 = screenHeight / 43.3;
  static double font26 = screenHeight / 33.31;

  static double radius5 = screenHeight / 173.2;
  static double radius15 = screenHeight / 57.73;
  static double radius20 = screenHeight / 43.3;
  static double radius30 = screenHeight / 28.87;

  static double iconSize24 = screenHeight / 36.01;
  static double iconSize16 = screenHeight / 54.125;

  static double listViewImage = screenWidth / 3.425;
  static double listViewTextContSize = screenWidth / 4.11;
}
