import '../../../data/local/preferences/request_models.dart';
import '../../../export.dart';

class OtpVerificationController extends GetxController {
  TextEditingController otpTextController = TextEditingController();
  FocusNode otpFocusNode = FocusNode();

  final DataBaseManager _LocalStorage = Get.find<DataBaseManager>();

  Timer? timer;
  var start = 30;
  var secondsStr = '00:30';
  String contactNumber = "";
  int? userId;

  @override
  void onInit() {
    getArguments();
    startTimer();
    update();
    super.onInit();
  }

  getArguments() {
    if (Get.arguments != null) {
      userId = Get.arguments[argSignUpUserId];
      contactNumber = Get.arguments[argContactNumber];
      update();
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  void startTimer() {
    timer = new Timer.periodic(
      Duration(seconds: 1),
      (Timer timer) {
        if (start == 0) {
          timer.cancel();
        } else {
          start--;
          secondsStr = '00:' + (start).toString().padLeft(2, '0');
        }
        update();
      },
    );
  }

  otpVerification() async {
    var otp = int.parse(otpTextController.text.trim());
    if (otp == 1234) {
      var verifyResult = await _LocalStorage.updateIsVerified(userId ?? 0);
      print("verifyResult: ${verifyResult}");
      if (verifyResult == 1) {
        saveAuthenticatedUserData();
      }
    } else {
      toast("Invalid OTP");
    }
  }

  saveAuthenticatedUserData() async {
    var data = LocalDBRequestModel.AuthUserRequestModel(authenticatedUserID: userId);
    try {
      var id = await _LocalStorage.insertAuthData(dataBody: data);
      Get.offAndToNamed(AppRoutes.congratulationRoute);
    } catch (e) {
      toast("$e");
    }
  }



  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }
}
