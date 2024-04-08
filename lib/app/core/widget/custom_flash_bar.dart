
import '../../export.dart';

toast(content, {seconds}) {
  Get.closeAllSnackbars();
  return Get.snackbar("Expense Tracker", content,
      colorText: Colors.black,
      duration: Duration(seconds: 2),
      snackPosition: SnackPosition.TOP,
      snackStyle: SnackStyle.FLOATING,
      padding: EdgeInsets.symmetric(horizontal: margin_20, vertical: margin_15),
      margin: EdgeInsets.symmetric(horizontal: margin_15, vertical: margin_15),
      barBlur: 20.0,
      backgroundColor: AppColors.toastGrayColor);
}
