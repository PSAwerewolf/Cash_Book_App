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
  final GlobalKey<DropdownMenuWidgetState> dropDownKey =
      GlobalKey<DropdownMenuWidgetState>();

  TextEditingController _priceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    List<ExpenseCategory> expCatList =
        context.read<SalesModel>().getExpenseCategoryList;
    context.read<SalesModel>().fetchShopExpenseCategoryCache();
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
            key: dropDownKey,
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
                      backgroundColor: Colors.white,
                      numValue: '1',
                      priceController: _priceController,
                      child: BigText(text: '1')),
                  NumButtonWidget(
                      numValue: '2',
                      priceController: _priceController,
                      child: BigText(text: '2')),
                  NumButtonWidget(
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
                      numValue: '4',
                      priceController: _priceController,
                      child: BigText(text: '4')),
                  NumButtonWidget(
                      numValue: '5',
                      priceController: _priceController,
                      child: BigText(text: '5')),
                  NumButtonWidget(
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
                      numValue: '7',
                      priceController: _priceController,
                      child: BigText(text: '7')),
                  NumButtonWidget(
                      numValue: '8',
                      priceController: _priceController,
                      child: BigText(text: '8')),
                  NumButtonWidget(
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
                      numValue: '.',
                      priceController: _priceController,
                      child: BigText(text: '.')),
                  NumButtonWidget(
                      numValue: '0',
                      priceController: _priceController,
                      child: BigText(text: '0')),
                  NumButtonWidget(
                    numValue: '',
                    priceController: _priceController,
                    child: AppIcon(
                      iconData: Icons.backspace,
                      iconColor: Colors.red,
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
                    width: Dimentions.width30 * 6,
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
                        onPressed: () {
                          context.read<SalesModel>().addNewExpense(
                              dropDownKey.currentState!
                                  .getSelectedValueExpenseDesc() as String,
                              double.parse(_priceController.text),
                              DateTime.now(),
                              1);

                          setState(() {
                            _priceController.text = '0';
                          });
                        },
                        child: BigText(
                          text: "Submit",
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
