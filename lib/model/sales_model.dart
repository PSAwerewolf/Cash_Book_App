import 'dart:convert';
import 'dart:math';
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
    try {
      // Calculate the total sales amount
      double totalAmount =
          _sales.fold(0, (sum, sale) => sum + sale.totalAmount);

      return totalAmount;
    } catch (e) {
      throw Exception('No cached sales data available');
    }
  }

  double _totalAmount = 0.0;

  double get getTotalAmount => _totalAmount;

  Future<void> getTotalSales() async {
    try {
      _totalAmount = await getTotalSalesAmount();
      notifyListeners();
    } catch (e) {
      notifyListeners();
    }
  }

  Future<void> clearSales() async {
    _sales.clear();
    notifyListeners();
  }

  // Sort Sales Data using the Date

  List<ProductSales> sortSalesData(String? timeFrame) {
    try {
      DateTime now = DateTime.now();
      DateTime startDate;

      switch (timeFrame) {
        case '0':
          startDate = DateTime(now.year, now.month, now.day);
          break;
        case '1':
          startDate = DateTime(now.year, now.month, now.day - 1);
          break;
        case '2':
          startDate = now.subtract(Duration(days: 7));
          break;
        case '3':
          startDate = DateTime(now.year, now.month - 1, 0);
          break;
        case '4':
          startDate = DateTime(now.year - 1, 0, 0);
          break;
        default:
          throw ArgumentError('Invalid time frame: $timeFrame');
      }
      List<ProductSales> filteredData;

      if (timeFrame == '1') {
        filteredData = _sales.where((data) {
          return data.addedDate.isAfter(startDate);
        }).toList();
      } else {
        filteredData = _sales.where((data) {
          return data.addedDate.isAfter(startDate);
        }).toList();
      }

      filteredData
          .sort((a, b) => a.addedDate.compareTo(b.addedDate)); // Sort by date

      return filteredData;
    } catch (e) {
      print('An error occurred: $e');
      return []; // Return an empty list in case of an error
    }
  }

  List<ShopExpense> sortExpenseData(String? timeFrame) {
    try {
      DateTime now = DateTime.now();
      DateTime startDate;

      switch (timeFrame) {
        case '0':
          startDate = DateTime(now.year, now.month, now.day);
          break;
        case '1':
          startDate = DateTime(now.year, now.month, now.day - 1);
          break;
        case '2':
          startDate = now.subtract(Duration(days: 7));
          break;
        case '3':
          startDate = DateTime(now.year, now.month - 1, 0);
          break;
        case '4':
          startDate = DateTime(now.year - 1, 0, 0);
          break;
        default:
          throw ArgumentError('Invalid time frame: $timeFrame');
      }
      List<ShopExpense> filteredData;

      if (timeFrame == '1' || timeFrame == '0') {
        filteredData = _expense.where((data) {
          return data.addedDate == startDate;
        }).toList();
      } else {
        filteredData = _expense.where((data) {
          return data.addedDate.isAfter(startDate);
        }).toList();
      }

      filteredData
          .sort((a, b) => a.addedDate.compareTo(b.addedDate)); // Sort by date

      return filteredData;
    } catch (e) {
      print('An error occurred: $e');
      return []; // Return an empty list in case of an error
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

  Future<double> getTotalExpenseValue() async {
    try {
      // Calculate the total sales amount
      double totalAmount =
          _expense.fold(0, (sum, expense) => sum + expense.totalAmount);

      return totalAmount;
    } catch (e) {
      throw Exception('No cached Expense data available');
    }
  }

  double _totalExpenseAmount = 0.0;

  double get getTotalExpenseAmount => _totalExpenseAmount;

  Future<void> getTotalExpense() async {
    try {
      _totalExpenseAmount = await getTotalExpenseValue();
      notifyListeners();
    } catch (e) {
      notifyListeners();
    }
  }

  Future<void> addNewExpense(String expDesc, double totalAmount,
      DateTime addedDate, int userId) async {
    _newExpense.add(ShopExpense(
        expenseDescription: expDesc,
        totalAmount: totalAmount,
        addedDate: addedDate,
        userId: userId));

    _totalNewExpense += totalAmount;

    notifyListeners();
  }

  List<ShopExpense> _newExpense = [];
  List<ShopExpense> _mainExpense = [];
  double _totalMainExpense = 0.0;
  double _totalNewExpense = 0.0;
  List<ShopExpense> get getNewExpense => _newExpense;
  List<ShopExpense> get getMainExpense => _mainExpense;
  double get getTotalMainExpense => _totalMainExpense;
  double get getTotalNewExpense => _totalNewExpense;

  Future<void> confirmExpense() async {
    for (int i = 0; i < _newExpense.length; i++)
      _mainExpense.add(_newExpense[i]);
    _totalMainExpense += _totalNewExpense;
    for (int i = 0; i < _newExpense.length; i++) _expense.add(_newExpense[i]);
    _newExpense.clear();
    print(_newExpense.length);
    _totalExpenseAmount += _totalMainExpense;
    _totalNewExpense = 0.0;
    notifyListeners();
  }

  Future<void> clearExpenses() async {
    _expense.clear();
    notifyListeners();
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

  Future<void> clearExpenseCategory() async {
    _expenseCategory.clear();
    notifyListeners();
  }

  // Add New Sales
  List<ProductSales> _newSales = [];
  List<ProductSales> _mainSales = [];
  double _totalMainSales = 0.0;
  double _totalNewSales = 0.0;
  List<ProductSales> get getNewSales => _newSales;
  List<ProductSales> get getMainSales => _mainSales;
  double get getTotalMainSales => _totalMainSales;
  double get getTotalNewSales => _totalNewSales;

  Future<void> addNewSales(int id, String productName, double totalAmount,
      DateTime addedDate) async {
    _newSales.add(ProductSales(
        id: id,
        productName: productName,
        totalAmount: totalAmount,
        addedDate: addedDate));

    _totalNewSales += totalAmount;

    notifyListeners();
  }

  Future<void> confirmSales() async {
    for (int i = 0; i < _newSales.length; i++) _mainSales.add(_newSales[i]);
    _totalMainSales += _totalNewSales;

    for (int i = 0; i < _newSales.length; i++) _sales.add(_newSales[i]);
    _newSales.clear();
    _totalAmount += _totalMainSales;
    _totalNewSales = 0.0;
    notifyListeners();
  }

  // Add Expenses

  //remove Product Daily Sales

  Future<void> deleteItem(int index) async {
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

  Future<void> clearSalesCategory() async {
    _items.clear();
    notifyListeners();
  }

  // User and Shop

  int _shopId = 0;
  int _userId = 0;

  int get getShopId => _shopId;
  int get getUserId => _userId;

  Future<void> addUserId(int userId) async {
    _userId = userId;
    notifyListeners();
  }

  Future<void> addShopId(int shopId) async {
    _shopId = shopId;
    notifyListeners();
  }

  Future<void> clearUserData() async {
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

  // BackUp button
  Future<String> backupSalesData(
      String productName, double totalAmount, String addedDate) async {
    // Expected format: 'Y-m-d H:i:s'
    var url = Uri.parse("http://${ip}/CashBookApp/insertDailySalesDB.php");

    final response = await http.post(url, body: {
      'product_name': productName,
      'total_price': totalAmount.toString(),
      'added_date': addedDate,
    });

    if (response.statusCode == 200) {
      var dataReceived = json.decode(response.body);

      if (dataReceived['status'] == 'Success') {
        _mainSales.clear();
        notifyListeners();
        return dataReceived['status'];
      } else {
        throw Exception('Server error: ${dataReceived['message']}');
      }
    } else {
      throw Exception('HTTP error: ${response.statusCode}');
    }
  }

  Future<String> backupExpenseData(
      String expDesc, double totalAmount, String addedDate, int userId) async {
    // Expected format: 'Y-m-d H:i:s'
    var url = Uri.parse("http://${ip}/CashBookApp/insertDailyExpenseDB.php");

    try {
      final response = await http.post(url, body: {
        'expense_desc': expDesc,
        'total_price': totalAmount.toString(),
        'added_date': addedDate,
        'user_id': userId.toString(),
      });

      if (response.statusCode == 200) {
        var dataReceived = json.decode(response.body);

        if (dataReceived['status'] == 'Success') {
          _mainExpense.clear();
          notifyListeners();
          return dataReceived['status'];
        } else {
          throw Exception('Server error: ${dataReceived['message']}');
        }
      } else {
        throw Exception('HTTP error: ${response.statusCode}');
      }
    } catch (error) {
      // Capture the specific error message and rethrow it
      throw Exception('Error in Connection: ${error.toString()}');
    }
  }

  Future<void> clearAll() async {
    _sales.clear();
    _mainSales.clear();
    _expenseCategory.clear();
    _expense.clear();
    _items.clear();
    _totalAmount = 0.0;
    _totalExpenseAmount = 0.0;
    _totalNewExpense = 0.0;
    _totalMainSales = 0.0;
    _totalNewSales = 0.0;
    notifyListeners();
  }

  Future<void> clearSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // This clears all the stored preferences
  }
}
