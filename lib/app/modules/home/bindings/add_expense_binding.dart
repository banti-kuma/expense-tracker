import '../../../export.dart';

class AddExpenseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddExpenseController>(
          () => AddExpenseController(),
    );
  }
}
