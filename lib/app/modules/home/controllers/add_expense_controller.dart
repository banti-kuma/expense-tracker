import 'package:expense_tracker/app/core/utils/date_conversion.dart';
import 'package:expense_tracker/app/data/local/preferences/local_db_model.dart';
import 'package:expense_tracker/app/data/local/preferences/request_models.dart';
import '../../../export.dart';

class AddExpenseController extends GetxController {
  final DataBaseManager _localStorage = Get.find<DataBaseManager>();
  var currentYear = DateTime.now().year;
  var currentDate = DateTime.now();
  var selectedDate = DateTime.now();
  final List<String> items = [
    "Shopping",
    "Food & Drink",
    "Traveling",
    "Housing",
    "Entertainment",
    "Education",
    "HealthCare"
  ];
  String selectedItem = "Shopping";
  ExpensesModel expensesModel = ExpensesModel();
  var isForUpdate = false;

  TextEditingController priceTextController = TextEditingController();
  TextEditingController notesTextController = TextEditingController();

  FocusNode? priceFocusNode = FocusNode();
  FocusNode notesFocusNode = FocusNode();

  @override
  void onInit() {
    getArguments();
    super.onInit();
  }

  getArguments() {
    if (Get.arguments != null) {
      isForUpdate = Get.arguments[argForEdit];
      expensesModel = Get.arguments[argExpense];
      notesTextController.text = expensesModel.notes ?? "";
      priceTextController.text = expensesModel.price ?? "0";
      selectedItem = expensesModel.category ?? "";
      selectedDate = SDateUtils.parseDateString(expensesModel.expenseDate ?? "");
      update();
    }
  }

  void onTypeChange(String type) {
    selectedItem = type;
    update();
  }

  Future<void> updateExpenses() async {
    var icon = getIconForCategory(selectedItem);
    List<AuthUserModel> authUser = await _localStorage.getAuthUserData();
    if (priceTextController.text.isNotEmpty &&
        notesTextController.text.isNotEmpty) {
      var data = LocalDBRequestModel.expenseRequestModel(
        notes: notesTextController.text,
        expenseDate: SDateUtils.formatDate("${selectedDate}"),
        category: "$selectedItem",
        price: priceTextController.text,
        icon: icon,
        id: authUser[0].authenticatedUserID
      );
      try {
        await _localStorage.updateExpenseData(
          id: expensesModel.expenseId ?? -1,
          dataBody: data,
        );
        Get.back(result: true);
      } catch (e) {
        showErrorToast(e.toString());
      }
    } else {
      showErrorToast(strFillAllRequired);
    }
  }

  Future<void> addExpense() async {
    var icon = getIconForCategory(selectedItem);
    List<AuthUserModel> authUser = await _localStorage.getAuthUserData();
    if (priceTextController.text.isNotEmpty &&
        notesTextController.text.isNotEmpty) {
      var data = LocalDBRequestModel.expenseRequestModel(
        notes: notesTextController.text,
        expenseDate: SDateUtils.formatDate("${selectedDate}"),
        category: "$selectedItem",
        price: priceTextController.text,
        icon: icon,
        id: authUser[0].authenticatedUserID
      );
      try {
        await _localStorage.insertExpenseData(dataBody: data);
        Get.back(result: true);
      } catch (e) {
        showErrorToast(e.toString());
      }
    } else {
      showErrorToast(strFillAllRequired);
    }
  }

  Future<void> deleteExpenses() async {
    try {
      await _localStorage.deleteExpense(pId: expensesModel.expenseId ?? -1);
      Get.back(result: true);
    } catch (e) {
      showErrorToast(e.toString());
    }
  }

  String getIconForCategory(String category) {
    switch (category) {
      case "Shopping":
        return iconsShopping;
      case "Food & Drink":
        return iconsFoodAndDrinks;
      case "Traveling":
        return iconsTraveling;
      case "Housing":
        return iconsHouse;
      case "Entertainment":
        return iconsEntertainment;
      case "Education":
        return iconsEducation;
      default:
        return iconsHealthcare;
    }
  }

  void showErrorToast(String message) {
    toast(message);
  }
}
