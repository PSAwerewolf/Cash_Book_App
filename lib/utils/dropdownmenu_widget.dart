import 'dart:ffi';

import 'package:cash_book_app4/model/product_items.dart';
import 'package:cash_book_app4/utils/app_icon.dart';
import 'package:cash_book_app4/utils/dimentions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DropdownMenuWidget extends StatefulWidget {
  List<ProductItems>? itemList = [];
  bool? searchOption;
  DropdownMenuWidget({super.key, this.itemList, this.searchOption});

  @override
  State<DropdownMenuWidget> createState() => DropdownMenuWidgetState();
}

class DropdownMenuWidgetState extends State<DropdownMenuWidget> {
  late List<DropdownMenuEntry<dynamic>> _dropDownItems = [];

  @override
  void initState() {
    _initializeItemList();
    getSelectedValue();
    super.initState();
  }

  double? getSelectedValue() {
    var index = widget.itemList
        ?.indexWhere((entry) => entry.id == int.parse(_selectedValue!));
    return _selectedValue == '0' ? 00.00 : widget.itemList?[index!].unitPrice;
  }

  List<DropdownMenuEntry<dynamic>> defaultList = [
    DropdownMenuEntry(value: '0', label: 'Today'),
    DropdownMenuEntry(value: '1', label: 'Yesterday'),
    DropdownMenuEntry(value: '2', label: 'Last Week'),
    DropdownMenuEntry(value: '3', label: 'Last Month'),
    DropdownMenuEntry(value: '4', label: 'Last Year'),
  ];

  void _initializeItemList() {
    _dropDownItems = widget.itemList == null
        ? _dropDownItems = defaultList
        : [
            DropdownMenuEntry(value: '0', label: 'Sales'),
            for (var item in widget.itemList!)
              DropdownMenuEntry(
                  value: '${item.id}', label: '${item.productName}'),
          ];
  }

  String? _selectedValue = '0';
  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      dropdownMenuEntries: _dropDownItems,
      enableSearch: widget.searchOption == null ? false : true,
      menuHeight: Dimentions.pageView220,
      initialSelection: _selectedValue,
      width: Dimentions.width30 * 8,
      requestFocusOnTap: false,
      selectedTrailingIcon: AppIcon(
        iconData: Icons.done,
        backgroundColor: Colors.transparent,
      ),
      onSelected: (value) {
        if (value != null) {
          setState(() {
            _selectedValue = value;
          });
        }
      },
    );
  }
}
