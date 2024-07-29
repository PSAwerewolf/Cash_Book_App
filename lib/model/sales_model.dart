import 'dart:convert';

import 'package:cash_book_app4/model/product_items.dart';
import 'package:cash_book_app4/model/product_sales.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class SalesModel extends ChangeNotifier {
  var ip = '192.168.8.153';
  List<ProductSales> _sales = [];

  List<ProductSales> get salesList => _sales;

  Future<void> fetchProductSales() async {
    var url = Uri.parse("http://${ip}/CashBookApp/getAllSales.php");
    final response = await http.get(url);
    //print(response.statusCode);
    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      _sales = responseData
          .map((productData) => ProductSales(
              id: int.parse(productData['id']),
              productName: productData['product_name'],
              totalAmount: double.parse(productData['total_price']),
              addedDate: DateTime.parse(productData['added_date'])))
          .toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load product Sales');
    }
  }

  // Add New Sales
  List<ProductSales> _newSales = [];
  List<ProductSales> get getNewSales => _newSales;
  void addNewSales(
      int id, String productName, double totalAmount, DateTime, addedDate) {
    /*CartModel? cartItem = _cart.firstWhereOrNull((item) {
      bool isSameFood = item.products == product;

      return isSameFood;
    });*/

    _newSales.add(ProductSales(
        id: id,
        productName: productName,
        totalAmount: totalAmount,
        addedDate: addedDate));

    notifyListeners();
  }

  void addMainSales(List<ProductSales> newList) {
    for (int i = 0; i < _newSales.length; i++) {
      _sales.add(_newSales[i]);
    }
  }

  //Product Category List

  List<ProductItems> _items = [];
  List<ProductItems> get getProductItems => _items;
  Future<void> fetchProductItems() async {
    var url = Uri.parse("http://${ip}/CashBookApp/getAllItems.php");
    final response = await http.get(url);
    //print(response.statusCode);
    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      _items = responseData
          .map((productData) => (ProductItems(
                id: int.parse(productData['id']),
                productName: productData['product_name'],
                unitPrice: double.parse(productData['unit_price']),
              )))
          .toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load product Items');
    }
  }
}
