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
import '../pages/Report/expense_report.dart';
import '../utils/app_icon.dart';
import '../pages/helper/save_file_mobile.dart'
    if (dart.library.html) 'helper/save_file_web.dart' as helper;

import '../utils/appcolors.dart';
import '../utils/custom_snackbar.dart';
import '../utils/dimentions.dart';
import '../utils/dropdownmenu_widget.dart';

class ExpenseReportGrid extends StatefulWidget {
  String? selectedValue;

  ExpenseReportGrid({super.key, this.selectedValue = '-1'});

  @override
  State<ExpenseReportGrid> createState() => _ExpenseReportGridState();
}

class _ExpenseReportGridState extends State<ExpenseReportGrid> {
  late List<ShopExpense> _sales = [];
  late SalesDataSource _salesDataSource;

  final GlobalKey<SfDataGridState> _key = GlobalKey<SfDataGridState>();

  Future<void> _exportDataGridToExcel() async {
    String fileName = 'DataGridExpense.xlsx';
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
    String fileName = 'DataGridExpense.pdf';
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
    context.watch<SalesModel>().getTotalExpense();
    double totalExpense = context.watch<SalesModel>().getTotalExpenseAmount;
    if (widget.selectedValue != null) {
      _sales = context.read<SalesModel>().sortExpenseData(widget.selectedValue);
    } else {
      _sales = context.watch<SalesModel>().expenseList;
    }

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
                      padding: EdgeInsets.all(Dimentions.width10),
                      child: Container(
                        child: BigText(
                          text: "Date",
                          size: 12,
                        ),
                      ),
                    )),
                GridColumn(
                    columnName: "Expense_desc",
                    label: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: BigText(
                          text: "Expense Name",
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
                    text: "Total Amount :",
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
                  height: Dimentions.height10 * 5,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(Dimentions.radius15))),
                    onPressed: () {
                      if (_sales.isEmpty) {
                        CustomSnackbar(
                          message: 'List is Empty',
                          backgroundColor: Colors.white,
                          textStyle: TextStyle(
                              color: AppColors.mainColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                          duration: Duration(seconds: 1),
                        ).show(context);
                      } else {
                        Provider.of<SalesModel>(context, listen: false)
                            .confirmSales();
                        try {
                          _exportDataGridToPdf();
                        } catch (e) {
                          CustomSnackbar(message: "${e.toString()}")
                              .show(context);
                        }
                      }
                    },
                    child: Image.asset("assets/images/pdf.jpg"),
                  ),
                ),
                SizedBox(
                  width: Dimentions.width10,
                ),
                SizedBox(
                  height: Dimentions.height10 * 5,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(Dimentions.radius15))),
                    onPressed: () {
                      if (_sales.isEmpty) {
                        CustomSnackbar(
                          message: 'List is Empty',
                          backgroundColor: Colors.white,
                          textStyle: TextStyle(
                              color: AppColors.mainColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                          duration: Duration(seconds: 1),
                        ).show(context);
                      } else {
                        Provider.of<SalesModel>(context, listen: false)
                            .confirmSales();
                        try {
                          _exportDataGridToExcel();
                        } catch (e) {
                          CustomSnackbar(message: "${e.toString()}")
                              .show(context);
                        }
                      }
                    },
                    child: Image.asset("assets/images/excel.jpg"),
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
