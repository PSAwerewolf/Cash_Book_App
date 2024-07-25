import 'package:cash_book_app4/routes/routes_helper.dart';
import 'package:cash_book_app4/utils/app_icon.dart';
import 'package:cash_book_app4/utils/appcolors.dart';
import 'package:cash_book_app4/utils/bluetooth_printer.dart';
import 'package:cash_book_app4/utils/dimentions.dart';
import 'package:cash_book_app4/utils/text_field.dart';
import 'package:cash_book_app4/widgets/big_text.dart';
import 'package:cash_book_app4/widgets/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _printerState = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.only(
              top: Dimentions.height45,
              left: Dimentions.width10,
              right: Dimentions.width10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: BigText(
                  text: "Axis Shop",
                  size: Dimentions.font20 * 2,
                ),
              ),
              SizedBox(height: Dimentions.height10),
              Container(
                child: SmallText(
                  text: "Address",
                  size: Dimentions.font26,
                ),
              ),
              SizedBox(height: Dimentions.height45),
              GestureDetector(
                onTap: () {
                  TextEditingController categoryController =
                      TextEditingController();

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
                          text: "Sales Category",
                        ),
                      ),
                      content: Material(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFieldWidget(
                                preIcon: AppIcon(
                                  iconData: Icons.add,
                                  backgroundColor: Colors.transparent,
                                ),
                                placeHolder: "Enter the Category",
                                controller: categoryController),
                            SizedBox(
                              height: Dimentions.height10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                child: Row(
                  children: [
                    AppIcon(
                      iconData: Icons.category,
                      iconColor: AppColors.mainColor,
                      backgroundColor: Colors.white,
                    ),
                    SizedBox(width: Dimentions.width10),
                    BigText(text: "Sales Category")
                  ],
                ),
              ),
              SizedBox(height: Dimentions.height10),
              GestureDetector(
                onTap: () {
                  TextEditingController categoryController =
                      TextEditingController();

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
                          text: "Expense Category",
                        ),
                      ),
                      content: Material(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFieldWidget(
                                preIcon: AppIcon(
                                  iconData: Icons.add,
                                  backgroundColor: Colors.transparent,
                                ),
                                placeHolder: "Enter the Category",
                                controller: categoryController),
                            SizedBox(
                              height: Dimentions.height10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                child: Row(
                  children: [
                    AppIcon(
                        iconData: Icons.category_outlined,
                        iconColor: AppColors.mainColor,
                        backgroundColor: Colors.white),
                    SizedBox(
                      width: Dimentions.width10,
                    ),
                    BigText(text: "Expense Category")
                  ],
                ),
              ),
              SizedBox(height: Dimentions.height10),
              GestureDetector(
                onTap: () {
                  TextEditingController categoryController =
                      TextEditingController();

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
                          text: "Report - Sales",
                        ),
                      ),
                      content: Material(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFieldWidget(
                                preIcon: AppIcon(
                                  iconData: Icons.add,
                                  backgroundColor: Colors.transparent,
                                ),
                                placeHolder: "Report - Sales",
                                controller: categoryController),
                            SizedBox(
                              height: Dimentions.height10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                child: Row(
                  children: [
                    AppIcon(
                        iconData: Icons.file_copy,
                        iconColor: AppColors.mainColor,
                        backgroundColor: Colors.white),
                    SizedBox(
                      width: Dimentions.width10,
                    ),
                    BigText(text: "Report - Sales")
                  ],
                ),
              ),
              SizedBox(height: Dimentions.height10),
              GestureDetector(
                onTap: () {
                  TextEditingController categoryController =
                      TextEditingController();

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
                          text: "Report - Expenses",
                        ),
                      ),
                      content: Material(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFieldWidget(
                                preIcon: AppIcon(
                                  iconData: Icons.add,
                                  backgroundColor: Colors.transparent,
                                ),
                                placeHolder: "Report - Expenses",
                                controller: categoryController),
                            SizedBox(
                              height: Dimentions.height10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                child: Row(
                  children: [
                    AppIcon(
                        iconData: Icons.file_copy_outlined,
                        iconColor: AppColors.mainColor,
                        backgroundColor: Colors.white),
                    SizedBox(width: Dimentions.width10),
                    BigText(text: "Report - Expenses")
                  ],
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  TextEditingController categoryController =
                      TextEditingController();

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
                          text: "Sales Category",
                        ),
                      ),
                      content: Material(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFieldWidget(
                                preIcon: AppIcon(
                                  iconData: Icons.add,
                                  backgroundColor: Colors.transparent,
                                ),
                                placeHolder: "Enter the Category",
                                controller: categoryController),
                            SizedBox(
                              height: Dimentions.height10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                child: Row(
                  children: [
                    AppIcon(
                        iconData: Icons.settings,
                        iconColor: AppColors.paraColor,
                        backgroundColor: Colors.white),
                    SizedBox(width: Dimentions.width10),
                    BigText(text: "Store Settings")
                  ],
                ),
              ),
              SizedBox(height: Dimentions.height10),
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
                                  text: "Scan",
                                  color: Colors.white,
                                )),
                          ],
                        ),
                      ],
                      title: Center(
                        child: BigText(
                          text: "Printer Settings",
                        ),
                      ),
                      content: StatefulBuilder(
                        builder: (context, StateSetter setState) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    BigText(text: "Bluetooth"),
                                    CupertinoSwitch(
                                      value: _printerState,
                                      onChanged: (bool value) {
                                        setState(() {
                                          _printerState = !_printerState;
                                        });
                                      },
                                    )
                                  ],
                                ),
                              ),
                              BluetoothPrinter(),
                            ],
                          );
                        },
                      ),
                    ),
                  );
                },
                child: Row(
                  children: [
                    AppIcon(
                        iconData: Icons.print,
                        iconColor: AppColors.paraColor,
                        backgroundColor: Colors.white),
                    SizedBox(width: Dimentions.width10),
                    BigText(text: "Printer Settings")
                  ],
                ),
              ),
              SizedBox(height: Dimentions.height10),
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
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: BigText(
                                  text: "Yes",
                                  color: Colors.white,
                                )),
                          ],
                        ),
                      ],
                      title: Center(
                        child: BigText(
                          text: "Logout ?",
                        ),
                      ),
                    ),
                  );
                },
                child: Row(
                  children: [
                    AppIcon(
                        iconData: Icons.logout,
                        iconColor: Colors.red,
                        backgroundColor: Colors.white),
                    SizedBox(width: Dimentions.width10),
                    BigText(text: "Logout")
                  ],
                ),
              ),
              SizedBox(height: Dimentions.height45),
            ],
          ),
        ),
      ),
    );
  }
}
