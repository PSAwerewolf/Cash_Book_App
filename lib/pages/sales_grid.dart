import 'package:cash_book_app4/widgets/big_text.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../utils/dimentions.dart';

class SalesGrid extends StatefulWidget {
  const SalesGrid({super.key});

  @override
  State<SalesGrid> createState() => _SalesGridState();
}

class _SalesGridState extends State<SalesGrid> {
  late List<Sales> _sales = [];
  late SalesDataSource _salesDataSource;

  @override
  void initState() {
    _sales = getSalesData();
    _salesDataSource = SalesDataSource(_sales);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SfDataGrid(
          allowFiltering: true,
          allowSorting: true,
          isScrollbarAlwaysShown: true,
          shrinkWrapRows: true,
          columnWidthMode: ColumnWidthMode.lastColumnFill,
          source: _salesDataSource,
          columns: [
            GridColumn(
                columnName: "id",
                label: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: BigText(
                      text: "Time",
                      size: 12,
                    ),
                  ),
                )),
            GridColumn(
                columnName: "category",
                label: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: BigText(
                      text: "Category",
                      size: 12,
                    ),
                  ),
                )),
            GridColumn(
                columnName: "amount",
                label: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: BigText(
                      text: "Amount",
                      size: 12,
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  List<Sales> getSalesData() {
    return [
      Sales(id: 1, category: "Water", amount: 200.00),
      Sales(id: 2, category: "Grocery", amount: 200.00),
      Sales(id: 3, category: "Sales", amount: 200.00),
      Sales(id: 4, category: "Vegetable", amount: 200.00),
      Sales(id: 5, category: "Drinks", amount: 200.00),
      Sales(id: 6, category: "Stationary", amount: 200.00),
      Sales(id: 4, category: "Vegetable", amount: 200.00),
      Sales(id: 5, category: "Drinks", amount: 200.00),
      Sales(id: 6, category: "Stationary", amount: 200.00),
      Sales(id: 4, category: "Vegetable", amount: 200.00),
      Sales(id: 5, category: "Drinks", amount: 200.00),
      Sales(id: 6, category: "Stationary", amount: 200.00),
      Sales(id: 4, category: "Vegetable", amount: 200.00),
      Sales(id: 5, category: "Drinks", amount: 200.00),
      Sales(id: 6, category: "Stationary", amount: 200.00),
    ];
  }
}

class SalesDataSource extends DataGridSource {
  SalesDataSource(List<Sales> sales) {
    dataGridRows = sales
        .map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
              DataGridCell<int>(columnName: "id", value: dataGridRow.id),
              DataGridCell<String>(
                  columnName: "category", value: dataGridRow.category),
              DataGridCell<double>(
                  columnName: "amount", value: dataGridRow.amount),
            ]))
        .toList();
  }

  late List<DataGridRow> dataGridRows = [];
  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
        padding: EdgeInsets.only(left: Dimentions.height20),
        alignment: Alignment.centerLeft,
        child: Text(dataGridCell.value.toString()),
      );
    }).toList());
  }
}

class Sales {
  final int id;
  final String category;
  final double amount;

  Sales({required this.id, required this.category, required this.amount});
}
