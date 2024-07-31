import 'package:cash_book_app4/model/product_sales.dart';
import 'package:cash_book_app4/model/sales_model.dart';
import 'package:cash_book_app4/model/shop_expense.dart';
import 'package:cash_book_app4/widgets/big_text.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_datagrid_export/export.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' hide Column, Row, Border;
import 'package:provider/provider.dart';

// Local import
import '../utils/app_icon.dart';
import '../pages/helper/save_file_mobile.dart'
    if (dart.library.html) 'helper/save_file_web.dart' as helper;

import '../utils/dimentions.dart';

class ExpenseListGrid extends StatefulWidget {
  const ExpenseListGrid({super.key});

  @override
  State<ExpenseListGrid> createState() => _ExpenseListGridState();
}

class _ExpenseListGridState extends State<ExpenseListGrid> {
  late List<ShopExpense> _sales = [];
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
    _salesDataSource = SalesDataSource(_sales);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.read<SalesModel>().fetchShopExpenseCache();
    final shopExpenseList = context.watch<SalesModel>().expenseList;
    context.watch<SalesModel>().getTotalExpense();
    double totalExpense = context.read<SalesModel>().getExpenseTotalAmount;
    _sales = shopExpenseList;
    _salesDataSource = SalesDataSource(_sales);
    return Container(
      child: Column(
        children: [
          Container(
            height: Dimentions.pageView450,
            child: SfDataGrid(
              key: _key,
              allowFiltering: true,
              allowSorting: false,
              isScrollbarAlwaysShown: true,
              shrinkWrapRows: true,
              columnWidthMode: ColumnWidthMode.fill,
              source: _salesDataSource,
              shrinkWrapColumns: false,
              columns: [
                GridColumn(
                    columnName: "added_date",
                    label: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: BigText(
                          text: "Date",
                          size: 12,
                        ),
                      ),
                    )),
                GridColumn(
                    columnName: "product_name",
                    label: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: BigText(
                          text: "Product Name",
                          size: 12,
                        ),
                      ),
                    )),
                GridColumn(
                    columnName: "total_amount",
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
                    text: "Rs. ${totalExpense.toStringAsFixed(2)}",
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
}

class SalesDataSource extends DataGridSource {
  SalesDataSource(List<ShopExpense> sales) {
    dataGridRows = sales
        .map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
              DataGridCell<String>(
                  columnName: "added_date",
                  value:
                      '${dataGridRow.addedDate.day.toString()} - ${dataGridRow.addedDate.month.toString()} - ${dataGridRow.addedDate.year.toString()}'),
              DataGridCell<String>(
                  columnName: "Expense_desc",
                  value: dataGridRow.expenseDescription),
              DataGridCell<double>(
                  columnName: "total_amount", value: dataGridRow.totalAmount),
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
