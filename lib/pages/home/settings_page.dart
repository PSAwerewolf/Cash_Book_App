import 'package:cash_book_app4/main.dart';
import 'package:cash_book_app4/model/product_sales.dart';
import 'package:cash_book_app4/model/sales_model.dart';
import 'package:cash_book_app4/pages/auth/login_page.dart';
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
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _printerState = false;
  bool successAdded = false;

  @override
  Widget build(BuildContext context) {
    context.read<SalesModel>().fetchShopExpenseCategoryCache();
    List<ProductSales> mainSales = context.read<SalesModel>().getMainSales;

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
              //Shop Name
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      Container(
                        child: BigText(
                          text: "Axis Shop",
                          size: Dimentions.font20 * 2,
                        ),
                      ),
                      SizedBox(height: Dimentions.height10), // Address
                      Container(
                        child: SmallText(
                          text: "Address",
                          size: Dimentions.font26,
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    //Y-m-d H:i:s
                    onPressed: () {
                      mainSales.forEach((sales) {
                        String response = context
                                .read<SalesModel>()
                                .backupSalesData(
                                    sales.productName,
                                    sales.totalAmount as String,
                                    '${sales.addedDate.year}-${sales.addedDate.month}-${sales.addedDate.day} ${sales.addedDate.hour}:${sales.addedDate.minute}:${sales.addedDate.second}')
                            as String;
                        print(response);
                      });
                    },
                    child: AppIcon(
                      iconData: Icons.backup,
                      backgroundColor: Colors.transparent,
                      iconColor: Colors.blue,
                      iconSize: Dimentions.iconSize16 * 2,
                    ),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      // Text color
                      shadowColor: Colors.black, // Shadow color
                      elevation: 1, // Elevation
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(Dimentions.radius15),
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: Dimentions.height10,
                          horizontal: Dimentions.width20),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: Dimentions.height30,
              ),

              //Sales Category
              GestureDetector(
                onTap: () {
                  TextEditingController categoryController =
                      TextEditingController();
                  TextEditingController unitPriceController =
                      TextEditingController();

                  successAdded = false;

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
                                  try {
                                    String response = context
                                        .watch<SalesModel>()
                                        .addOrUpdateProductItem(
                                            categoryController.text,
                                            unitPriceController.text) as String;

                                    setState(() {
                                      successAdded = true;
                                    });
                                  } catch (error) {
                                    setState(() {
                                      successAdded = false;
                                    });
                                  }

                                  categoryController.clear();
                                  unitPriceController.clear();
                                },
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
                            TextFieldWidget(
                                preIcon: AppIcon(
                                  iconData: Icons.attach_money,
                                  backgroundColor: Colors.transparent,
                                ),
                                keyBoardType: TextInputType.number,
                                placeHolder: "Enter the Unit Price",
                                controller: unitPriceController),
                            SizedBox(
                              height: Dimentions.height10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                BigText(text: "Status"),
                                AppIcon(
                                  iconData: successAdded
                                      ? Icons.done_outline_rounded
                                      : Icons.close,
                                  backgroundColor: Colors.transparent,
                                  iconSize: Dimentions.iconSize24,
                                  iconColor:
                                      successAdded ? Colors.green : Colors.red,
                                )
                              ],
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

              //Expense Category
              GestureDetector(
                onTap: () {
                  TextEditingController categoryController =
                      TextEditingController();
                  successAdded = false;

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
                                  try {
                                    context
                                        .read<SalesModel>()
                                        .addExpenseCategory(
                                            categoryController.text);
                                    setState(() {
                                      successAdded = true;
                                    });
                                  } catch (error) {
                                    setState(() {
                                      successAdded = false;
                                    });
                                  }

                                  categoryController.clear();
                                },
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
                                  iconData:
                                      successAdded ? Icons.done : Icons.add,
                                  backgroundColor: Colors.transparent,
                                ),
                                placeHolder: "Enter the Category",
                                controller: categoryController),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                BigText(text: "Status"),
                                AppIcon(
                                  iconData: successAdded
                                      ? Icons.done_outline_rounded
                                      : Icons.close,
                                  backgroundColor: Colors.transparent,
                                  iconSize: Dimentions.iconSize24,
                                  iconColor:
                                      successAdded ? Colors.green : Colors.red,
                                )
                              ],
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

              //Report Sales
              GestureDetector(
                onTap: () {
                  TextEditingController categoryController =
                      TextEditingController();

                  successAdded = false;

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
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(RoutesHelper.salesReport);
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
              ),
              SizedBox(height: Dimentions.height10),

              //Report Expense
              GestureDetector(
                onTap: () {
                  Get.toNamed(RoutesHelper.getExpenseReport());
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

              //Store Settings
              GestureDetector(
                onTap: () {
                  TextEditingController categoryController =
                      TextEditingController();
                  successAdded = false;

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

              //Printer Settings
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

              //Logout
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
                                  context.read<SalesModel>().clearUserData();
                                  //Get.toNamed(RoutesHelper.getLoginPage());
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginPage()),
                                      (Route<dynamic> route) => false);
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
