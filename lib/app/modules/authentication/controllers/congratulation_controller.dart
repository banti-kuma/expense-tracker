import '../../../export.dart';

class CongratulationController extends GetxController {
  Timer? timer;



  @override
  void onInit() {
    _navigateToNextScreen();
    super.onInit();
  }

  void _navigateToNextScreen() =>
      timer = Timer(const Duration(seconds: 5, milliseconds: 500), () async {
        Get.offAndToNamed(AppRoutes.homeRoute);
      });

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
