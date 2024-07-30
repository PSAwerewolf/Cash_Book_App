import 'dart:convert';
import 'package:cash_book_app4/model/product_items.dart';
import 'package:cash_book_app4/model/product_sales.dart';
import 'package:cash_book_app4/model/shop_expense.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SalesModel extends ChangeNotifier {
  var ip = '192.168.8.153';

  //Sales List
  List<ProductSales> _sales = [];

  List<ProductSales> get salesList => _sales;

  /*Future<void> fetchProductSales() async {
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
  }*/

  Future<void> fetchProductSales() async {
    var url = Uri.parse("http://${ip}/CashBookApp/getAllSales.php");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // Parse the response body
        final List<dynamic> responseData = json.decode(response.body);

        //print("Fetching data from Database");

        // Map the response data to ProductSales objects
        _sales = responseData
            .map((productData) => ProductSales(
                id: int.parse(productData['id']),
                productName: productData['product_name'],
                totalAmount: double.parse(productData['total_price']),
                addedDate: DateTime.parse(productData['added_date'])))
            .toList();

        // Cache the data
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('cachedSales', response.body);

        notifyListeners();
      } else {
        throw Exception('Failed to load product Sales from API');
      }
    } catch (error) {
      //print("Fetching data from Cache");

      // Try to get data from cache
      final prefs = await SharedPreferences.getInstance();
      final cachedData = prefs.getString('cachedSales');

      if (cachedData != null) {
        final List<dynamic> responseData = json.decode(cachedData);

        // Map the cached data to ProductSales objects
        _sales = responseData
            .map((productData) => ProductSales(
                id: int.parse(productData['id']),
                productName: productData['product_name'],
                totalAmount: double.parse(productData['total_price']),
                addedDate: DateTime.parse(productData['added_date'])))
            .toList();

        notifyListeners();
      } else {
        throw Exception(
            'Failed to load product Sales and no cached data available');
      }
    }
  }

  Future<double> getTotalSalesAmount() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString('cachedSales');

    if (cachedData != null) {
      final List<dynamic> responseData = json.decode(cachedData);

      // Parse the data into ProductSales objects
      final List<ProductSales> sales = responseData
          .map((productData) => ProductSales(
              id: int.parse(productData['id']),
              productName: productData['product_name'],
              totalAmount: double.parse(productData['total_price']),
              addedDate: DateTime.parse(productData['added_date'])))
          .toList();

      // Calculate the total sales amount
      double totalAmount = sales.fold(0, (sum, sale) => sum + sale.totalAmount);

      return totalAmount;
    } else {
      throw Exception('No cached sales data available');
    }
  }

  late double _totalAmount;

  double get getTotalAmount => _totalAmount;

  void getTotal() async {
    try {
      double totalAmount = await getTotalSalesAmount();
      _totalAmount = totalAmount;
      notifyListeners();
    } catch (e) {
      notifyListeners();
    }
  }

  //Expense List

  List<ShopExpense> _expense = [];

  List<ShopExpense> get expenseList => _expense;

  /*Future<void> fetchShopExpense() async {
    var url = Uri.parse("http://${ip}/CashBookApp/getAllExpenses.php");
    final response = await http.get(url);
    //print(response.statusCode);
    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      _expense = responseData
          .map((productData) => ShopExpense(
              expenseDescription: productData['expense_desc'],
              totalAmount: double.parse(productData['total_amount']),
              addedDate: DateTime.parse(productData['added_date']),
              userId: int.parse(productData['user_id']),
              shopId: int.parse(productData['shop_id'])))
          .toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load Shop Expenses');
    }
  }*/
  Future<void> fetchShopExpense() async {
    var url = Uri.parse("http://${ip}/CashBookApp/getAllExpenses.php");

    try {
      final response = await http.get(url);
      //print("Fetching Data from Database");
      if (response.statusCode == 200) {
        // Parse and map the response data
        final List<dynamic> responseData = json.decode(response.body);
        _expense = responseData
            .map((expenseData) => ShopExpense(
                expenseDescription: expenseData['expense_desc'],
                totalAmount: double.parse(expenseData['total_amount']),
                addedDate: DateTime.parse(expenseData['added_date']),
                userId: int.parse(expenseData['user_id']),
                shopId: int.parse(expenseData['shop_id'])))
            .toList();

        // Cache the data
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('cachedExpenses', json.encode(responseData));

        notifyListeners();
      } else {
        // Handle non-200 status codes, if necessary
        throw Exception('Failed to load Shop Expenses');
      }
    } catch (error) {
      // Error handling and loading from cache

      //print("Fetching Data from cache");
      final prefs = await SharedPreferences.getInstance();
      final cachedData = prefs.getString('cachedExpenses');

      if (cachedData != null) {
        final List<dynamic> responseData = json.decode(cachedData);
        _expense = responseData
            .map((expenseData) => ShopExpense(
                expenseDescription: expenseData['expense_desc'],
                totalAmount: double.parse(expenseData['total_amount']),
                addedDate: DateTime.parse(expenseData['added_date']),
                userId: int.parse(expenseData['user_id']),
                shopId: int.parse(expenseData['shop_id'])))
            .toList();
        notifyListeners();
      } else {
        throw Exception(
            'Failed to load Shop Expenses and no cached data available');
      }
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
  /*Future<void> fetchProductItems() async {
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
  }*/

  Future<void> fetchProductItems() async {
    var url = Uri.parse("http://${ip}/CashBookApp/getAllItems.php");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        //print("Fetching data from Database");

        // Map the response data to ProductItems objects
        _items = responseData
            .map((productData) => ProductItems(
                id: int.parse(productData['id']),
                productName: productData['product_name'],
                unitPrice: double.parse(productData['unit_price'])))
            .toList();

        // Cache the data
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('cachedProductItems', json.encode(responseData));

        notifyListeners();
      } else {
        throw Exception('Failed to load product items from API');
      }
    } catch (error) {
      //print("Fetching data from Cache");

      // Try to get data from cache
      final prefs = await SharedPreferences.getInstance();
      final cachedData = prefs.getString('cachedProductItems');
      if (cachedData != null) {
        final List<dynamic> responseData = json.decode(cachedData);

        // Map the cached data to ProductItems objects
        _items = responseData
            .map((productData) => ProductItems(
                id: int.parse(productData['id']),
                productName: productData['product_name'],
                unitPrice: double.parse(productData['unit_price'])))
            .toList();

        notifyListeners();
      } else {
        throw Exception(
            'Failed to load product items and no cached data available');
      }
    }
  }

  // User and Shop

  int _shopId = 0;
  int _userId = 0;

  int get getShopId => _shopId;
  int get getUserId => _userId;

  void addUserId(int userId) {
    _userId = userId;
    notifyListeners();
  }

  void addShopId(int shopId) {
    _shopId = shopId;
    notifyListeners();
  }

  void clearUserData() {
    _shopId = 0;
    _userId = 0;
    notifyListeners();
  }
}
