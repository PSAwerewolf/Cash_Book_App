class ShopExpense {
  String expenseDescription;
  double totalAmount;
  DateTime addedDate;
  int userId;
  int shopId;

  ShopExpense(
      {required this.expenseDescription,
      required this.totalAmount,
      required this.addedDate,
      required this.userId,
      required this.shopId});
}
