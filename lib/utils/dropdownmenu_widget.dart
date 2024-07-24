import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DropdownMenuWidget extends StatefulWidget {
  const DropdownMenuWidget({super.key});

  @override
  State<DropdownMenuWidget> createState() => _DropdownMenuWidgetState();
}

class _DropdownMenuWidgetState extends State<DropdownMenuWidget> {
  final List<DropdownMenuEntry<dynamic>> _dropDownItems = [
    DropdownMenuEntry(value: '1', label: 'Today'),
    DropdownMenuEntry(value: '2', label: 'Yesterday'),
    DropdownMenuEntry(value: '3', label: 'Last Week'),
    DropdownMenuEntry(value: '4', label: 'Last Month'),
    DropdownMenuEntry(value: '5', label: 'Last Year'),
  ];

  String? _selectedValue = '1';
  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      dropdownMenuEntries: _dropDownItems,
      enableSearch: false,
      initialSelection: _selectedValue,
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
