import 'dart:convert';
import 'package:cash_book_app4/model/expense_category.dart';
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

  List<ProductSales> get getSalesList => _sales;

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
        //throw Exception('Failed to load product Sales from API');
      }
    } catch (error) {
      throw Exception('Failed to load product Sales and no API data available');
    }
  }

  Future<void> fetchProductSalesCache() async {
    try {
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
        throw Exception('Failed to load product Sales from Cache');
      }
    } catch (error) {
      throw Exception(
          'Failed to load product Sales and no cached data available');
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

  double _totalAmount = 0.0;

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
                ))
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
      throw Exception('Failed to load Shop Expenses and no API data available');
    }
  }

  Future<void> fetchShopExpenseCache() async {
    try {
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
                ))
            .toList();
        notifyListeners();
      } else {
        // Handle non-200 status codes, if necessary
        throw Exception('Failed to load Shop Expenses');
      }
    } catch (error) {
      throw Exception(
          'Failed to load Shop Expenses and no cached data available');
    }
  }

  Future<double> getTotalExpenseAmount() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString('cachedExpenses');

    if (cachedData != null) {
      final List<dynamic> responseData = json.decode(cachedData);

      // Parse the data into ProductSales objects
      final List<ShopExpense> expense = responseData
          .map((expenseData) => ShopExpense(
              expenseDescription: expenseData['expense_desc'],
              totalAmount: double.parse(expenseData['total_amount']),
              addedDate: DateTime.parse(expenseData['added_date']),
              userId: int.parse(expenseData['user_id'])))
          .toList();

      // Calculate the total sales amount
      double totalAmount =
          expense.fold(0, (sum, sale) => sum + sale.totalAmount);

      return totalAmount;
    } else {
      throw Exception('No cached sales data available');
    }
  }

  double _totalExpenseAmount = 0.0;

  double get getExpenseTotalAmount => _totalExpenseAmount;

  void getTotalExpense() async {
    try {
      double totalAmount = await getTotalExpenseAmount();
      _totalExpenseAmount = totalAmount;
      notifyListeners();
    } catch (e) {
      notifyListeners();
    }
  }

  //Expense Category
  List<ExpenseCategory> _expenseCategory = [];

  List<ExpenseCategory> get getExpenseCategoryList => _expenseCategory;

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
  Future<void> fetchShopExpenseCategory() async {
    var url = Uri.parse("http://${ip}/CashBookApp/getAllExpenseCategory.php");

    try {
      final response = await http.get(url);
      //print("Fetching Data from Database");
      if (response.statusCode == 200) {
        // Parse and map the response data
        final List<dynamic> responseData = json.decode(response.body);
        _expenseCategory = responseData
            .map((expenseData) => ExpenseCategory(
                id: int.parse(expenseData['id']),
                expenseCategory: expenseData['expense_desc']))
            .toList();

        // Cache the data
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('cachedExpensesCategory', json.encode(responseData));

        notifyListeners();
      } else {
        // Handle non-200 status codes, if necessary
        throw Exception(
            'Failed to load Shop Expenses Category : ${response.statusCode}');
      }
    } catch (error) {
      throw Exception(
          'Failed to load Shop Expenses Category and no API data available : ${error.toString()}');
    }
  }

  Future<void> fetchShopExpenseCategoryCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cachedData = prefs.getString('cachedExpensesCategory');

      if (cachedData != null) {
        final List<dynamic> responseData = json.decode(cachedData);
        _expenseCategory = responseData
            .map((expenseData) => ExpenseCategory(
                id: int.parse(expenseData['id']),
                expenseCategory: expenseData['expense_desc']))
            .toList();
        notifyListeners();
      } else {
        // Handle non-200 status codes, if necessary
        throw Exception('Failed to load Shop Expenses Category');
      }
    } catch (error) {
      throw Exception(
          'Failed to load Shop Expenses Category and no cached data available : ${error.toString()}');
    }
  }

  // Add New Sales
  List<ProductSales> _newSales = [];
  List<ProductSales> _mainSales = [];
  double _totalMainSales = 0.0;
  List<ProductSales> get getNewSales => _newSales;
  List<ProductSales> get getMainSales => _mainSales;
  double get getTotalMainSales => _totalMainSales;

  void addNewSales(
      int id, String productName, double totalAmount, DateTime addedDate) {
    _newSales.add(ProductSales(
        id: id,
        productName: productName,
        totalAmount: totalAmount,
        addedDate: addedDate));
    _totalMainSales += totalAmount;

    notifyListeners();
  }

  void clearTotalMainSales() {
    _totalMainSales = 0.0;
    notifyListeners();
  }

  void confirmSales() {
    for (int i = 0; i < _newSales.length; i++) _mainSales.add(_newSales[i]);

    _newSales.clear();
    notifyListeners();
  }

  // Add Expenses

  //remove Product Daily Sales

  void deleteItem(int index) {
    _newSales.length == 1
        ? _totalMainSales = 0.0
        : _totalMainSales -= _newSales[index].totalAmount;
    _newSales.removeAt(index);

    notifyListeners();
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
        throw Exception(
            'Failed to load product items from API ${response.statusCode}');
      }
    } catch (error) {
      throw Exception(
          'Failed to load product items and no API data available ${error.toString()}');
    }
  }

  Future<void> fetchProductItemsCache() async {
    try {
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
        throw Exception('Failed to load product items from Cache ');
      }
    } catch (error) {
      throw Exception(
          'Failed to load product items and no cached data available ${error.toString()}');
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

  // Add Expense Category

  Future<String> addExpenseCategory(String expenseDesc) async {
    var url = Uri.parse("http://${ip}/CashBookApp/insertExpenseCategory.php");

    try {
      final response = await http.post(url, body: {
        'expense_desc': expenseDesc,
      });

      if (response.statusCode == 200) {
        var dataReceived = json.decode(response.body);

        if (dataReceived == 'Success') {
          return "Success";
        } else {
          throw Exception('Server error: ${dataReceived}');
        }
      } else {
        throw Exception('HTTP error: ${response.statusCode}');
      }
    } catch (error) {
      // Capture the specific error message and rethrow it
      throw Exception('Error in Connection: ${error.toString()}');
    }
  }

  // Add Sales Category

  Future<String> addOrUpdateProductItem(
      String productName, String unitPrice) async {
    var url = Uri.parse("http://${ip}/CashBookApp/insertSalesCategory.php");

    try {
      final response = await http.post(url, body: {
        'product_name': productName,
        'unit_price': unitPrice,
      });

      if (response.statusCode == 200) {
        var dataReceived = json.decode(response.body);

        if (dataReceived == 'Product price updated successfully' ||
            dataReceived == 'Product added successfully') {
          return dataReceived;
        } else {
          throw Exception('Server error: ${dataReceived}');
        }
      } else {
        throw Exception('HTTP error: ${response.statusCode}');
      }
    } catch (error) {
      // Capture the specific error message and rethrow it
      throw Exception('Error in Connection: ${error.toString()}');
    }
  }
}
