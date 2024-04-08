import '../../../export.dart';

enum DateSelectionType { weekly, yearly, monthly, daily }

class CustomDatePickerController extends GetxController {
  final List<String> items = ["weekly", "yearly", "monthly", "daily"];

  String selectedItem = "yearly";
  var currentYear = DateTime.now().year;

  bool isWeekly = false;
  bool isMonthly = false;
  bool isYearly = true;
  bool isDaily = false;

  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void onTypeChange(String type) {
    isWeekly = false;
    isMonthly = false;
    isYearly = false;
    isDaily = false;
    switch (type) {
      case "weekly":
        isWeekly = true;
        break;
      case "yearly":
        isYearly = true;
        break;
      case "monthly":
        isMonthly = true;
        break;
      case "daily":
        isDaily = true;
        break;
    }
    selectedItem = type;
    print(isWeekly);
    update();
  }


}
