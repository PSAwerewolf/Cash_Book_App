import 'package:cash_book_app4/utils/app_icon.dart';
import 'package:cash_book_app4/utils/num_button_widget.dart';
import 'package:cash_book_app4/utils/text_field.dart';
import 'package:cash_book_app4/widgets/big_text.dart';
import 'package:cash_book_app4/widgets/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/sales_model.dart';
import '../utils/appcolors.dart';
import '../utils/dimentions.dart';
import '../utils/dropdownmenu_widget.dart';

class AddSales extends StatefulWidget {
  const AddSales({super.key});

  @override
  State<AddSales> createState() => _AddSalesState();
}

class _AddSalesState extends State<AddSales> {
  final GlobalKey<DropdownMenuWidgetState> dropDownKey =
      GlobalKey<DropdownMenuWidgetState>();
  TextEditingController _priceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    context.read<SalesModel>().fetchProductItemsCache();
    var itemList = context.watch<SalesModel>().getProductItems;
    return SingleChildScrollView(
      child: Container(
        width: Dimentions.pageView450 * 2,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BigText(text: "Enter Your Sales Here"),
            SizedBox(
              height: Dimentions.height15,
            ),
            DropdownMenuWidget(
              key: dropDownKey,
              itemList: itemList,
            ),
            SizedBox(
              height: Dimentions.height15,
            ),
            BigText(
                text:
                    "Default Price : \$ ${dropDownKey.currentState?.getSelectedValue() == 0 ? 00.00 : dropDownKey.currentState?.getSelectedValue()}"),
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
                                  borderRadius: BorderRadius.circular(
                                      Dimentions.radius15)),
                              backgroundColor: Colors.greenAccent,
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(
                                vertical: Dimentions.height10,
                              )),
                          onPressed: () {
                            context.read<SalesModel>().addNewSales(
                                dropDownKey.currentState!.getSelectedValueId()
                                    as int,
                                dropDownKey.currentState!
                                    .getSelectedValueProdName() as String,
                                double.parse(_priceController.text),
                                DateTime.now());

                            setState(() {
                              _priceController.text = '0';
                            });
                          },
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
                                  borderRadius: BorderRadius.circular(
                                      Dimentions.radius15)),
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
      ),
    );
  }
}
