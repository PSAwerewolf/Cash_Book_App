import 'package:cash_book_app4/model/expense_category.dart';
import 'package:cash_book_app4/model/sales_model.dart';
import 'package:cash_book_app4/utils/app_icon.dart';
import 'package:cash_book_app4/utils/num_button_widget.dart';
import 'package:cash_book_app4/utils/text_field.dart';
import 'package:cash_book_app4/widgets/big_text.dart';
import 'package:cash_book_app4/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/appcolors.dart';
import '../utils/dimentions.dart';
import '../utils/dropdownmenu_widget.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  TextEditingController _priceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    List<ExpenseCategory> expCatList =
        context.read<SalesModel>().getExpenseCategoryList;
    context.watch<SalesModel>().fetchShopExpenseCategoryCache();
    return Container(
      width: Dimentions.pageView450 * 2,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BigText(text: "Enter Your Expense Here"),
          SizedBox(
            height: Dimentions.height15,
          ),
          DropdownMenuWidget(
            expenseCategory: expCatList,
          ),
          SizedBox(
            height: Dimentions.height15,
          ),
          GestureDetector(
            onTap: () {},
            child: AbsorbPointer(
              child: TextFieldWidget(
                  preIcon: AppIcon(
                    iconData: Icons.price_change_rounded,
                    backgroundColor: Colors.transparent,
                    iconSize: Dimentions.iconSize24,
                  ),
                  placeHolder: 'Add Expense Value',
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
                  NumButtonWidget(
                      backgroundColor: AppColors.buttonBackgroundColor,
                      numValue: '1',
                      priceController: _priceController,
                      child: BigText(text: '1')),
                  NumButtonWidget(
                      backgroundColor: AppColors.buttonBackgroundColor,
                      numValue: '2',
                      priceController: _priceController,
                      child: BigText(text: '2')),
                  NumButtonWidget(
                      backgroundColor: AppColors.buttonBackgroundColor,
                      numValue: '3',
                      priceController: _priceController,
                      child: BigText(text: '3')),
                ],
              ),
              SizedBox(
                height: Dimentions.height15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  NumButtonWidget(
                      backgroundColor: AppColors.buttonBackgroundColor,
                      numValue: '4',
                      priceController: _priceController,
                      child: BigText(text: '4')),
                  NumButtonWidget(
                      backgroundColor: AppColors.buttonBackgroundColor,
                      numValue: '5',
                      priceController: _priceController,
                      child: BigText(text: '5')),
                  NumButtonWidget(
                      backgroundColor: AppColors.buttonBackgroundColor,
                      numValue: '6',
                      priceController: _priceController,
                      child: BigText(text: '6')),
                ],
              ),
              SizedBox(
                height: Dimentions.height15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  NumButtonWidget(
                      backgroundColor: AppColors.buttonBackgroundColor,
                      numValue: '7',
                      priceController: _priceController,
                      child: BigText(text: '7')),
                  NumButtonWidget(
                      backgroundColor: AppColors.buttonBackgroundColor,
                      numValue: '8',
                      priceController: _priceController,
                      child: BigText(text: '8')),
                  NumButtonWidget(
                      backgroundColor: AppColors.buttonBackgroundColor,
                      numValue: '9',
                      priceController: _priceController,
                      child: BigText(text: '9')),
                ],
              ),
              SizedBox(
                height: Dimentions.height15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  NumButtonWidget(
                      backgroundColor: AppColors.buttonBackgroundColor,
                      numValue: '.',
                      priceController: _priceController,
                      child: BigText(text: '.')),
                  NumButtonWidget(
                      backgroundColor: AppColors.buttonBackgroundColor,
                      numValue: '0',
                      priceController: _priceController,
                      child: BigText(text: '0')),
                  NumButtonWidget(
                    backgroundColor: AppColors.paraColor,
                    numValue: '',
                    priceController: _priceController,
                    child: AppIcon(
                      iconData: Icons.backspace,
                      iconColor: Colors.white,
                      backgroundColor: Colors.transparent,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: Dimentions.height10 * 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: Dimentions.height10 * 5,
                    width: Dimentions.width30 * 4,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(Dimentions.radius15)),
                            backgroundColor: Colors.greenAccent,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                              vertical: Dimentions.height10,
                            )),
                        onPressed: () {},
                        child: BigText(
                          text: "Add",
                          color: Colors.white,
                        )),
                  ),
                  SizedBox(
                    height: Dimentions.height10,
                  ),
                  SizedBox(
                    height: Dimentions.height10 * 5,
                    width: Dimentions.width30 * 4,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(Dimentions.radius15)),
                            backgroundColor: Colors.green[700],
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                              vertical: Dimentions.height10,
                            )),
                        onPressed: () {},
                        child: BigText(
                          text: "Print",
                          color: Colors.white,
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: Dimentions.height10,
              ),
              SizedBox(
                height: Dimentions.height10 * 5,
                width: Dimentions.width30 * 3,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(Dimentions.radius15)),
                        backgroundColor: Colors.redAccent,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          vertical: Dimentions.height10,
                        )),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: BigText(
                      text: "X",
                      color: Colors.white,
                    )),
              )
            ],
          ),
        ],
      ),
    );
  }
}
