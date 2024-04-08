import 'package:expense_tracker/app/data/local/preferences/local_db_model.dart';

class WeekDates {
  final String startDate;
  final String endDate;

  WeekDates({required this.startDate, required this.endDate});
}

class WeeksExpensesModel {
  String? expenseDate;
  ExpensesModel? expensesModel;
  WeeksExpensesModel({this.expenseDate, this.expensesModel});
}