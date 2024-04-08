import '../../../export.dart';

class CongratulationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CongratulationController>(
          () => CongratulationController(),
    );
  }
}