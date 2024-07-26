import 'package:cash_book_app4/widgets/big_text.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_datagrid_export/export.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' hide Column, Row, Border;
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'dart:io';

// Local import
import '../utils/app_icon.dart';
import 'helper/save_file_mobile.dart'
    if (dart.library.html) 'helper/save_file_web.dart' as helper;

import '../utils/dimentions.dart';

class SalesGrid extends StatefulWidget {
  const SalesGrid({super.key});

  @override
  State<SalesGrid> createState() => _SalesGridState();
}

class _SalesGridState extends State<SalesGrid> {
  late List<Sales> _sales = [];
  late SalesDataSource _salesDataSource;

  final GlobalKey<SfDataGridState> _key = GlobalKey<SfDataGridState>();
  Future<void> _exportDataGridToExcel() async {
    String fileName = 'DataGrid.xlsx';
    final SfDataGridState? dataGridState = _key.currentState;

    if (dataGridState != null) {
      final Workbook workbook = dataGridState.exportToExcelWorkbook();

      final List<int> bytes = workbook.saveAsStream();
      workbook.dispose();

      await helper.saveAndLaunchFile(bytes, fileName);
    } else {
      print('DataGridState is null');
    }
  }

  Future<void> _exportDataGridToPdf() async {
    String fileName = 'DataGrid.pdf';
    final SfDataGridState? dataGridState = _key.currentState;

    if (dataGridState != null) {
      final PdfDocument document =
          dataGridState.exportToPdfDocument(fitAllColumnsInOnePage: true);

      final List<int> bytes = document.saveSync();
      await helper.saveAndLaunchFile(bytes, fileName);
      document.dispose();
    } else {
      print('DataGridState is null');
    }
  }

  @override
  void initState() {
    _sales = getSalesData();
    _salesDataSource = SalesDataSource(_sales);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: Dimentions.pageView450,
            child: SfDataGrid(
              key: _key,
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
          SizedBox(
            height: Dimentions.height10,
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: Dimentions.height15, horizontal: Dimentions.height10),
            width: double.infinity,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  BigText(
                    text: "Total Amount : ",
                  ),
                  BigText(
                    text: "Rs. 150000.00",
                  ),
                ]),
            decoration: BoxDecoration(
                //color: Colors.blue,
                borderRadius: BorderRadius.circular(Dimentions.radius15),
                border: Border.all(color: Colors.grey, width: 2.0)),
          ),
          SizedBox(
            height: Dimentions.height10,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: Dimentions.width20 * 5,
                  height: Dimentions.height10 * 5,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[100],
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(Dimentions.radius15))),
                    onPressed: _exportDataGridToPdf,
                    child: AppIcon(
                      iconData: Icons.adobe,
                      backgroundColor: Colors.transparent,
                      iconColor: Colors.red,
                      iconSize: Dimentions.iconSize16 * 2,
                    ),
                  ),
                ),
                SizedBox(
                  width: Dimentions.width10,
                ),
                SizedBox(
                  width: Dimentions.width20 * 5,
                  height: Dimentions.height10 * 5,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[100],
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(Dimentions.radius15))),
                    onPressed: _exportDataGridToExcel,
                    child: AppIcon(
                        iconData: Icons.currency_exchange,
                        backgroundColor: Colors.transparent,
                        iconColor: Colors.green,
                        iconSize: Dimentions.iconSize16 * 2),
                  ),
                ),
              ],
            ),
          )
        ],
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
