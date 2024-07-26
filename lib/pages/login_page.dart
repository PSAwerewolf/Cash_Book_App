import 'dart:async';
import 'dart:convert';

import 'package:cash_book_app4/utils/app_icon.dart';
import 'package:cash_book_app4/utils/password_text_field.dart';
import 'package:cash_book_app4/utils/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/routes_helper.dart';
import '../utils/appcolors.dart';
import '../utils/dimentions.dart';
import '../widgets/big_text.dart';
import '../widgets/small_text.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _shopIdController = TextEditingController();
  TextEditingController _userIdController = TextEditingController();
  TextEditingController _passwordIdController = TextEditingController();

  @override
  void initState() {
    Timer(const Duration(seconds: 5),
        () => Get.toNamed(RoutesHelper.getHomePage()));
    super.initState();
  }

  Future<String> _login(
      String shopIdPHP, String emailPHP, String passwordPHP) async {
    //var url = Uri.parse("http://192.168.8.153/Flutter_demoApp/login.php");
    var url = Uri.parse("http://172.20.10.4/CashBookApp/login.php");

    final response = await http.post(url, body: {
      'shop_id': shopIdPHP,
      'user_id': emailPHP,
      'user_password': passwordPHP
    });
    var dataReceived = await json.decode(response.body);
    print(dataReceived);

    Get.toNamed(RoutesHelper.getHomePage());

    return "loginState";
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
              vertical: Dimentions.height10, horizontal: Dimentions.width20),
          child: Column(
            children: [
              Container(
                height: Dimentions.height45 * 5,
                width: Dimentions.height45 * 5,
                decoration: BoxDecoration(color: Colors.transparent),
                child: Image.asset(
                  "assets/images/cashBookLogo.png",
                  fit: BoxFit.cover,
                ),
              ),
              BigText(
                text: "Cash BOOK",
                color: AppColors.mainColor,
                size: 40,
              ),
              SmallText(
                text: "Simplified Cash Entry & Tracking App",
                color: AppColors.paraColor,
                size: 16,
              ),
              SizedBox(
                height: Dimentions.height30,
              ),
              TextFieldWidget(
                  preIcon: AppIcon(
                    iconData: Icons.other_houses_rounded,
                    backgroundColor: Colors.transparent,
                    iconColor: AppColors.mainColor,
                  ),
                  placeHolder: 'Enter Shop Id',
                  controller: _shopIdController),
              TextFieldWidget(
                  preIcon: AppIcon(
                    iconData: Icons.person,
                    backgroundColor: Colors.transparent,
                    iconColor: AppColors.mainColor,
                  ),
                  placeHolder: 'Enter User Id',
                  controller: _userIdController),
              PasswordTextField(
                controller: _passwordIdController,
                placeHolder: 'Enter Password',
                prefIcon: Icons.lock,
                mainBorderColor: AppColors.mainColor,
                errorBorderColor: Colors.red,
              ),
              SizedBox(
                height: Dimentions.height10,
              ),

              SizedBox(
                height: Dimentions.height10,
              ),

              //Sign in Button
              GestureDetector(
                onTap: () async {
                  var userId = _userIdController.text;
                  var shopId = _shopIdController.text;
                  var userPassword = _passwordIdController.text;

                  if (!(userId.isEmpty && userPassword.isEmpty)) {
                    String loginStatus =
                        await _login(shopId, userId, userPassword);

                    if (loginStatus != 'Success') {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                          'Login UnSuccessful',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              fontFamily: 'Roboto'),
                        ),
                        backgroundColor: Color(0xFFe07e22),
                      ));
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                        'Fill the Fields',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            fontFamily: 'Roboto'),
                      ),
                      backgroundColor: Color(0xFFe07e22),
                    ));
                  }
                },
                child: Container(
                  width: Dimentions.screenWidth / 2,
                  padding: EdgeInsets.symmetric(
                      vertical: Dimentions.height10 / 2,
                      horizontal: Dimentions.width20),
                  decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(Dimentions.radius20)),
                  child: Center(
                    child: BigText(
                      text: "Sign in",
                      color: Colors.white,
                      size: Dimentions.font26,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
