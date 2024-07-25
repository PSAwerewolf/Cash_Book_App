import 'package:cash_book_app4/utils/app_icon.dart';
import 'package:cash_book_app4/utils/text_field.dart';
import 'package:cash_book_app4/widgets/big_text.dart';
import 'package:cash_book_app4/widgets/small_text.dart';
import 'package:flutter/material.dart';

import '../utils/appcolors.dart';
import '../utils/dimentions.dart';
import '../utils/dropdownmenu_widget.dart';

class AddSales extends StatefulWidget {
  const AddSales({super.key});

  @override
  State<AddSales> createState() => _AddSalesState();
}

class _AddSalesState extends State<AddSales> {
  TextEditingController _priceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Dimentions.pageView450 * 2,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BigText(text: "Enter Your Sales Here"),
          SizedBox(
            height: Dimentions.height15,
          ),
          DropdownMenuWidget(),
          SizedBox(
            height: Dimentions.height15,
          ),
          BigText(text: "Default Price : \$ 1000.00"),
          SizedBox(
            height: Dimentions.height15,
          ),
          GestureDetector(
            onTap: () {},
            child: AbsorbPointer(
              child: TextFieldWidget(
                  preIcon: AppIcon(
                    iconData: Icons.add,
                    backgroundColor: Colors.transparent,
                  ),
                  placeHolder: 'Add product value',
                  controller: _priceController),
            ),
          ),
          SizedBox(
            height: Dimentions.height15,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      _priceController.text += '1';
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: Dimentions.height30 * 2,
                      width: Dimentions.height30 * 2,
                      child: BigText(
                        text: '1',
                      ),
                      decoration: BoxDecoration(
                          color: AppColors.buttonBackgroundColor,
                          borderRadius:
                              BorderRadius.circular(Dimentions.radius15)),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _priceController.text += '2';
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: Dimentions.height30 * 2,
                      width: Dimentions.height30 * 2,
                      child: BigText(
                        text: '2',
                      ),
                      decoration: BoxDecoration(
                          color: AppColors.buttonBackgroundColor,
                          borderRadius:
                              BorderRadius.circular(Dimentions.radius15)),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _priceController.text += '3';
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: Dimentions.height30 * 2,
                      width: Dimentions.height30 * 2,
                      child: BigText(
                        text: '3',
                      ),
                      decoration: BoxDecoration(
                          color: AppColors.buttonBackgroundColor,
                          borderRadius:
                              BorderRadius.circular(Dimentions.radius15)),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Dimentions.height15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      _priceController.text += '4';
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: Dimentions.height30 * 2,
                      width: Dimentions.height30 * 2,
                      child: BigText(
                        text: '4',
                      ),
                      decoration: BoxDecoration(
                          color: AppColors.buttonBackgroundColor,
                          borderRadius:
                              BorderRadius.circular(Dimentions.radius15)),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _priceController.text += '5';
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: Dimentions.height30 * 2,
                      width: Dimentions.height30 * 2,
                      child: BigText(
                        text: '5',
                      ),
                      decoration: BoxDecoration(
                          color: AppColors.buttonBackgroundColor,
                          borderRadius:
                              BorderRadius.circular(Dimentions.radius15)),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _priceController.text += '6';
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: Dimentions.height30 * 2,
                      width: Dimentions.height30 * 2,
                      child: BigText(
                        text: '6',
                      ),
                      decoration: BoxDecoration(
                          color: AppColors.buttonBackgroundColor,
                          borderRadius:
                              BorderRadius.circular(Dimentions.radius15)),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Dimentions.height15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      _priceController.text += '7';
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: Dimentions.height30 * 2,
                      width: Dimentions.height30 * 2,
                      child: BigText(
                        text: '7',
                      ),
                      decoration: BoxDecoration(
                          color: AppColors.buttonBackgroundColor,
                          borderRadius:
                              BorderRadius.circular(Dimentions.radius15)),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _priceController.text += '8';
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: Dimentions.height30 * 2,
                      width: Dimentions.height30 * 2,
                      child: BigText(
                        text: '8',
                      ),
                      decoration: BoxDecoration(
                          color: AppColors.buttonBackgroundColor,
                          borderRadius:
                              BorderRadius.circular(Dimentions.radius15)),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _priceController.text += '9';
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: Dimentions.height30 * 2,
                      width: Dimentions.height30 * 2,
                      child: BigText(
                        text: '9',
                      ),
                      decoration: BoxDecoration(
                          color: AppColors.buttonBackgroundColor,
                          borderRadius:
                              BorderRadius.circular(Dimentions.radius15)),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Dimentions.height15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      _priceController.text += '.';
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: Dimentions.height30 * 2,
                      width: Dimentions.height30 * 2,
                      child: BigText(
                        text: '.',
                      ),
                      decoration: BoxDecoration(
                          color: AppColors.buttonBackgroundColor,
                          borderRadius:
                              BorderRadius.circular(Dimentions.radius15)),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _priceController.text += '0';
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: Dimentions.height30 * 2,
                      width: Dimentions.height30 * 2,
                      child: BigText(
                        text: '0',
                      ),
                      decoration: BoxDecoration(
                          color: AppColors.buttonBackgroundColor,
                          borderRadius:
                              BorderRadius.circular(Dimentions.radius15)),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _priceController.text = '';
                    },
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(),
                      child: Container(
                        alignment: Alignment.center,
                        height: Dimentions.height30 * 2,
                        width: Dimentions.height30 * 2,
                        child: AppIcon(
                          iconData: Icons.backspace,
                          backgroundColor: Colors.transparent,
                        ),
                        decoration: BoxDecoration(
                            color: AppColors.buttonBackgroundColor,
                            borderRadius:
                                BorderRadius.circular(Dimentions.radius15)),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Dimentions.height10,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
