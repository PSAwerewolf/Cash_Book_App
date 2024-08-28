import 'dart:async';
import 'dart:convert';

import 'package:cash_book_app4/model/sales_model.dart';
import 'package:cash_book_app4/utils/app_icon.dart';
import 'package:cash_book_app4/utils/custom_snackbar.dart';
import 'package:cash_book_app4/utils/password_text_field.dart';
import 'package:cash_book_app4/utils/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../routes/routes_helper.dart';
import '../../utils/appcolors.dart';
import '../../utils/dimentions.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var ipAddress = '192.168.8.153';

  TextEditingController _shopIdController = TextEditingController();
  TextEditingController _userIdController = TextEditingController();
  TextEditingController _passwordIdController = TextEditingController();

  @override
  void initState() {
    /*Timer(const Duration(seconds: 5),
        () => Get.toNamed(RoutesHelper.getHomePage()));*/
    super.initState();
  }

  @override
  void dispose() {
    _shopIdController.dispose();
    _userIdController.dispose();
    _passwordIdController.dispose();
    super.dispose();
  }

  Future<Map> _login(
      String shopIdPHP, String emailPHP, String passwordPHP) async {
    var url = Uri.parse("http://${ipAddress}/CashBookApp/login.php");

    final response = await http.post(url, body: {
      'shop_id': shopIdPHP,
      'user_id': emailPHP,
      'user_password': passwordPHP
    });
    var dataReceived = await json.decode(response.body);
    print(dataReceived);

    return dataReceived;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
                vertical: Dimentions.height10, horizontal: Dimentions.width20),
            child: Column(
              children: [
                SizedBox(
                  height: Dimentions.height30,
                ),
                Container(
                  height: Dimentions.height45 * 5,
                  width: Dimentions.height45 * 5,
                  decoration: BoxDecoration(color: Colors.transparent),
                  child: Image.asset(
                    "assets/images/cashBookLogo.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: Dimentions.height30,
                ),
                TextFieldWidget(
                    preIcon: AppIcon(
                      iconData: Icons.other_houses_rounded,
                      backgroundColor: Colors.transparent,
                      iconColor: Colors.black,
                      iconSize: Dimentions.iconSize24,
                    ),
                    placeHolder: 'Enter Shop Id',
                    controller: _shopIdController),
                TextFieldWidget(
                    preIcon: AppIcon(
                      iconData: Icons.person,
                      backgroundColor: Colors.transparent,
                      iconColor: Colors.black,
                      iconSize: Dimentions.iconSize24,
                    ),
                    placeHolder: 'Enter User Id',
                    controller: _userIdController),
                PasswordTextField(
                  controller: _passwordIdController,
                  placeHolder: 'Enter Password',
                  prefIcon: AppIcon(
                    iconData: Icons.lock,
                    backgroundColor: Colors.transparent,
                    iconColor: Colors.black,
                    iconSize: Dimentions.iconSize24,
                  ),
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
                      var loginStatus =
                          await _login(shopId, userId, userPassword);

                      if (loginStatus['status'] != 'Login Successful') {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
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
                      } else {
                        context
                            .read<SalesModel>()
                            .addUserId(int.parse(_userIdController.text));
                        context
                            .read<SalesModel>()
                            .addShopId(int.parse(_shopIdController.text));
                        context.read<SalesModel>().fetchProductSales();
                        context.read<SalesModel>().fetchShopExpense();
                        context.read<SalesModel>().fetchProductItems();
                        context.read<SalesModel>().fetchShopExpenseCategory();
                        context.read<SalesModel>().fetchProductSalesCache();
                        context.read<SalesModel>().fetchShopExpenseCache();
                        Get.toNamed(RoutesHelper.getHomePage());
                        CustomSnackbar(
                          message: '${loginStatus['status']}',
                          textStyle: TextStyle(
                              color: AppColors.mainColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                          duration: Duration(seconds: 2),
                        ).show(context);
                      }
                    } else if (_userIdController == null &&
                        _shopIdController == null &&
                        _passwordIdController == null) {
                      CustomSnackbar(
                        message: 'Fill the Fields',
                        textStyle: TextStyle(
                            color: AppColors.mainColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                        duration: Duration(seconds: 2),
                      ).show(context);
                    }
                    Get.toNamed(RoutesHelper.getHomePage());
                    _shopIdController.clear();
                    _userIdController.clear();
                    _passwordIdController.clear();
                  },
                  child: Container(
                    width: Dimentions.screenWidth,
                    padding: EdgeInsets.symmetric(
                        vertical: Dimentions.height10 / 2,
                        horizontal: Dimentions.width20),
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius:
                            BorderRadius.circular(Dimentions.radius20)),
                    child: Center(
                      child: BigText(
                        text: "Log in",
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
      ),
    );
  }
}
