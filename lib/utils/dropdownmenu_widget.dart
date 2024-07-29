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
  late List<DropdownMenuEntry<dynamic>> _dropDownItems = widget.itemList == null
      ? defaultList
      : [
          DropdownMenuEntry(value: '1', label: 'Sales'),
          for (var item in widget.itemList!)
            DropdownMenuEntry(
                value: item.id.toString(), label: item.productName)
        ];

  @override
  void initState() {
    super.initState();
  }

  double? getSelectedValue() {
    print(widget.itemList?[int.parse(_selectedValue!)].productName);
    print(widget.itemList?[int.parse(_selectedValue!)].id);
    return widget.itemList?[int.parse(_selectedValue!)].unitPrice;
  }

  List<DropdownMenuEntry<dynamic>> defaultList = [
    DropdownMenuEntry(value: '1', label: 'Today'),
    DropdownMenuEntry(value: '2', label: 'Yesterday'),
    DropdownMenuEntry(value: '3', label: 'Last Week'),
    DropdownMenuEntry(value: '4', label: 'Last Month'),
    DropdownMenuEntry(value: '5', label: 'Last Year'),
  ];

  /*void _initializeItemList() {
    int i = 0;
    _dropDownItems = widget.itemList == null
        ? _dropDownItems = defaultList
        : [
            for (var item in widget.itemList!)
              DropdownMenuEntry(
                  value: '${i + 1}', label: '${item.productName}'),
          ];
  }*/

  String? _selectedValue = '1';
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
