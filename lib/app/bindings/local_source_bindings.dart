import 'package:expense_tracker/app/data/local/preferences/database_manager.dart';

import '../export.dart';

class LocalSourceBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DataBaseManager>(
      () => DataBaseManager(),
      fenix: true,
    );
  }
}
