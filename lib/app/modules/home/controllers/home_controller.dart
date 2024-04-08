import 'package:expense_tracker/app/core/utils/date_conversion.dart';
import 'package:expense_tracker/app/data/local/preferences/local_db_model.dart';
import 'package:expense_tracker/app/modules/home/Models.dart';
import 'package:intl/intl.dart';
import 'package:pinput/pinput.dart';

import '../../../export.dart';

class HomeController extends GetxController {
  final DataBaseManager _LocalStorage = Get.find<DataBaseManager>();
  var currentYear = "${DateTime.now().year}";
  List<ExpensesModel> expenses = [];
  final List<String> items = ["weekly", "monthly"];
  String selectedItem = "weekly";
  var totalExpense = 0;
  var idForWeekAndMonths = false;
  var noData = false;

  @override
  void onInit() async {
    getYearlyExpenses(year: "${DateTime.now().year}");
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
  }

  void onTypeChange(String type) {
    selectedItem = type;
    update();
  }

  afterFilter(value, type) {
    if (type == "Weekly") {
      List<String> dates = SDateUtils.extractTwoDates(value);
      currentYear =
          "${SDateUtils.extractMonthAndDay(dates[0])}~${SDateUtils.extractMonthAndDay(dates[1])}";
      print("dates: $dates");
      getExpensesInRange(start: dates[0], end: dates[1]);
    } else if (type == "Yearly") {
      currentYear = "$value";
      getYearlyExpenses(year: value);
    } else if (type == "Monthly") {
      print("value: $value");
      List<String> monthAndYear = SDateUtils.extractMonthAndYear(value);
      currentYear = "${monthAndYear[0]}-${monthAndYear[1]}";
      getMonthlyExpenses(
          int.parse(monthAndYear[0]), int.parse(monthAndYear[1]));
    } else {
      currentYear = "$value";
      getExpensesByDate(value);
    }
    update();
  }

  Future<void> getExpensesByDate(value) async {
    expenses = [];
    try {
      expenses = await _LocalStorage.getExpensesDataForDate(date: value);
    } catch (e) {
      print("Error fetching monthly expenses: $e");
    }
    getTotalExpense();
    update();
  }

  Future<void> getMonthlyExpenses(int month, int year) async {
    expenses = [];
    try {
      expenses =
          await _LocalStorage.getMonthlyExpensesData(month: month, year: year);
    } catch (e) {
      print("Error fetching monthly expenses: $e");
    }
    getTotalExpense();
    update();
  }

  Future<void> getYearlyExpenses({required year}) async {
    expenses = [];
    try {
      expenses = await _LocalStorage.getYearlyExpensesData(year: year);
    } catch (e) {
      print("Error fetching yearly expenses: $e");
    }
    getTotalExpense();
    update();
  }

  Future<void> getExpensesInRange(
      {required String start, required String end}) async {
    expenses = [];
    print("start: $start");
    try {
      expenses = await _LocalStorage.getExpensesDataInRange(
          startDate: start, endDate: end);
    } catch (e) {
      print("Error fetching expenses data in range: $e");
    }
    getTotalExpense();
    update();
  }

  logOut() async {
    var result = await _LocalStorage.logOut();
    Get.offAndToNamed(AppRoutes.signupRoute);
  }

  getTotalExpense() {
    totalExpense = 0;
    if (expenses.length == 0) {
      noData = true;
    } else {
      noData = false;
    }
    for (ExpensesModel item in expenses) {
      totalExpense = totalExpense + int.parse(item.price ?? "0");
    }
    List<WeekDates> weekDates = getWeekDates(expenses);
    for (ExpensesModel expense in expenses) {
      print("Expense Dates: ${expense.expenseDate}");
    }
    for (WeekDates item in weekDates) {
      print("datad: ${item.startDate}~${item.endDate}");
    }
    update();
  }

  List<WeekDates> getWeekDates(List<ExpensesModel> expenses) {
    List<WeekDates> weeks = [];
    for (ExpensesModel expense in expenses) {
      DateTime expenseDateTime =
          DateFormat("MM-dd-yyyy").parse(expense.expenseDate!);
      DateTime startOfMonth =
          DateTime(expenseDateTime.year, expenseDateTime.month, 1);
      int daysInMonth =
          DateTime(expenseDateTime.year, expenseDateTime.month + 1, 0).day;
      int firstDayOfWeek = 1; // 1 for Monday, 7 for Sunday

      for (int i = 0; i < daysInMonth; i += 7) {
        DateTime startOfWeek = startOfMonth
            .add(Duration(days: i - startOfMonth.weekday + firstDayOfWeek));
        DateTime endOfWeek = startOfWeek.add(Duration(days: 6));

        if (endOfWeek.day > daysInMonth) {
          endOfWeek = DateTime(
              expenseDateTime.year, expenseDateTime.month, daysInMonth);
        }

        if (expenseDateTime.isAfter(startOfWeek.subtract(Duration(days: 1))) &&
            expenseDateTime.isBefore(endOfWeek.add(Duration(days: 1)))) {
          weeks.add(WeekDates(
            startDate: DateFormat('dd-MM-yyyy').format(startOfWeek),
            endDate: DateFormat('dd-MM-yyyy').format(endOfWeek),
          ));
        }
      }
    }
    return weeks;
  }

  // Helper function to group expenses by week
  List<String> groupExpensesByWeek(List<ExpensesModel> expenses) {
    List<String> weeks = [];
    String currentWeek = '';
    for (var expense in expenses) {
      DateTime expenseDateTime =
          DateFormat("MM-dd-yyyy").parse(expense.expenseDate!);
      int weekNumber = getWeekNumber(expenseDateTime);
      if (currentWeek != '$weekNumber-${expenseDateTime.year}') {
        currentWeek = '$weekNumber-${expenseDateTime.year}';
        weeks.add(currentWeek);
      }
    }
    return weeks;
  }

  List<ExpensesModel> getExpensesForWeek(
      List<ExpensesModel> expenses, String week) {
    List<ExpensesModel> filteredExpenses = [];
    String weekNumber = week.split('-')[0];
    String year = week.split('-')[1];
    for (var expense in expenses) {
      DateTime expenseDateTime =
          DateFormat("MM-dd-yyyy").parse(expense.expenseDate!);
      int expenseWeekNumber = getWeekNumber(expenseDateTime);
      int expenseYear = expenseDateTime.year;
      if ('$expenseWeekNumber-$expenseYear' == week) {
        filteredExpenses.add(expense);
      }
    }
    return filteredExpenses;
  }

  // Helper function to get the week number of a given date
  int getWeekNumber(DateTime date) {
    DateTime janFirst = DateTime(date.year, 1, 1);
    int daysOffset = (janFirst.weekday + 6) % 7; // Adjust to Monday based week
    DateTime firstMonday = janFirst.add(Duration(days: daysOffset));
    int weekNumber = ((date.difference(firstMonday).inDays) / 7).ceil();
    return weekNumber;
  }
}
