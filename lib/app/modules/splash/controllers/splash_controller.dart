import 'package:expense_tracker/app/data/local/preferences/local_db_model.dart';

import '../../../export.dart';

class SplashController extends GetxController {
  var timer;
  RxString currentLogo = iconsSplashIcon.obs;

  final DataBaseManager _LocalStorage = Get.find<DataBaseManager>();

  @override
  void onInit() {
    _navigateToNextScreen();
    // _LocalStorage.deleteDatabaseIfExists();
    // localDbData();
    // addColumn();
    // localDbData();
    super.onInit();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  Future<void> localDbData() async {
    List<ExpensesModel> data =
        await _LocalStorage.getMonthlyExpensesData(month: 3, year: 2024);
    for (ExpensesModel item in data) {
      print("date: ${item.expenseDate}");
    }
  }

  //*===================================================================== Check App validity ==========================================================*
  void _navigateToNextScreen() =>
      timer = Timer(const Duration(seconds: 3, milliseconds: 500), () async {
        var authUser = await _LocalStorage.getAuthUserData();
        if (authUser.length > 0) {
          Get.offAndToNamed(AppRoutes.homeRoute);
        } else {
          Get.offAllNamed(AppRoutes.signupRoute);
        }
      });
}
