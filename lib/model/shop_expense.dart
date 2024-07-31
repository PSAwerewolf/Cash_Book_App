class ShopExpense {
  String expenseDescription;
  double totalAmount;
  DateTime addedDate;
  int userId;

  ShopExpense(
      {required this.expenseDescription,
      required this.totalAmount,
      required this.addedDate,
      required this.userId});
}
