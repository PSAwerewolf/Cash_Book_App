import 'package:cash_book_app4/model/product_sales.dart';
import 'package:cash_book_app4/model/sales_model.dart';
import 'package:cash_book_app4/utils/appcolors.dart';
import 'package:cash_book_app4/utils/custom_snackbar.dart';
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

class SalesListGrid extends StatefulWidget {
  const SalesListGrid({
    super.key,
  });

  @override
  State<SalesListGrid> createState() => _SalesListGridState();
}

class _SalesListGridState extends State<SalesListGrid> {
  late List<ProductSales> _sales = [];
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
    _salesDataSource = SalesDataSource(_sales, context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productDailySales = context.watch<SalesModel>().getNewSales;
    double totalAmount = context.watch<SalesModel>().getTotalNewSales;
    _sales = productDailySales;
    _salesDataSource = SalesDataSource(_sales, context);
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
                          text: "Time",
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
                    allowSorting: false,
                    label: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: BigText(
                          text: "Amount",
                          size: 12,
                        ),
                      ),
                    )),
                GridColumn(
                    columnName: 'delete',
                    allowFiltering: false,
                    label: Container(
                        padding: EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: Text('Delete'))),
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
                    text: "Rs. ${totalAmount.toStringAsFixed(2)}",
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                    child: AppIcon(
                      iconData: Icons.feed,
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
                    child: AppIcon(
                        iconData: Icons.dataset,
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
  BuildContext? context;
  List<ProductSales> sales;

  SalesDataSource(this.sales, this.context) {
    dataGridRows = sales
        .map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
              DataGridCell<String>(
                  columnName: "added_date",
                  value:
                      '${dataGridRow.addedDate.hour.toString()} . ${dataGridRow.addedDate.minute.toString()}'),
              DataGridCell<String>(
                  columnName: "product_name", value: dataGridRow.productName),
              DataGridCell<double>(
                  columnName: "total_amount", value: dataGridRow.totalAmount),
              DataGridCell<Widget>(columnName: "delete", value: null),
            ]))
        .toList();
  }

  late List<DataGridRow> dataGridRows = [];
  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(cells: [
      Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(8.0),
        child: Text(row.getCells()[0].value.toString()),
      ),
      Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(8.0),
        child: Text(row.getCells()[1].value.toString()),
      ),
      Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(8.0),
        child: Text(row.getCells()[2].value.toString()),
      ),
      Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(8.0),
        child: IconButton(
          icon: AppIcon(
            iconData: Icons.delete,
            iconColor: Colors.red,
            backgroundColor: Colors.transparent,
          ),
          onPressed: () {
            // Handle the delete action

            int index = dataGridRows.indexOf(row);

            Provider.of<SalesModel>(context!, listen: false).deleteItem(index);
          },
        ),
      ),
    ]);
  }
}
