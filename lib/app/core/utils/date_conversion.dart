import 'package:intl/intl.dart';


class SDateUtils {
  static String formatDate(String inputDate) {
    DateTime dateTime = DateTime.parse(inputDate);
    return DateFormat("dd-MM-yyyy").format(dateTime);
  }

  static List<String> extractTwoDates(String dateString) {
    List<String> dateParts = dateString.split(" - ");
    String firstDate = dateParts[0];
    String secondDate = dateParts[1];
    return [firstDate, secondDate];
  }

  static String extractMonthAndDay(String dateString) {
    List<String> dateParts = dateString.split("-");
    String day = dateParts[0];
    String month = dateParts[1];
    return "$day-$month";
  }


  static List<String>  extractMonthAndYear(String date) {
    List<String> dateComponents = date.split("-");
    String month = dateComponents[0];
    String year = dateComponents[1];
    return [month, year];
  }


  static DateTime parseDateString(String dateString) {
    List<String> parts = dateString.split('-');
    int year = int.parse(parts[2]);
    int month = int.parse(parts[1]);
    int day = int.parse(parts[0]);
    return DateTime(year, month, day);
  }

}