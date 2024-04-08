import '../../../data/local/preferences/request_models.dart';
import '../../../export.dart';

class SignUpController extends GetxController {
  RxBool viewPassword = true.obs;
  RxBool confirmViewPassword = true.obs;

  final DataBaseManager _LocalStorage = Get.find<DataBaseManager>();


  Rx<Country> selectedCountry =
      Country("United Arab Emirates", "flags/khm.png", "UAE", "+971").obs;

  TextEditingController nameTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController mobileNumberTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController confirmPasswordTextController = TextEditingController();

  FocusNode? nameFocusNode = FocusNode();
  FocusNode? emailFocusNode = FocusNode();
  FocusNode mobileNumberFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }


  SignUp() async {
    if (mobileNumberTextController.text != "" && emailTextController.text != "" && passwordTextController.text != "" && nameTextController.text != "") {
      var data = LocalDBRequestModel.signupRequestModel(email: emailTextController.text, name: nameTextController.text, phoneNumber: mobileNumberTextController.text, password: passwordTextController.text,isVerified: 0);
      try {
        var id = await _LocalStorage.insertData(dataBody: data);
        Get.toNamed(AppRoutes.otpVerificationRoute,arguments: {
          argSignUpUserId: id,
          argContactNumber: "${selectedCountry.value.callingCode ?? ""} ${mobileNumberTextController.text}",
        });
      } catch (e) {
        if (e.toString().contains('Phone number or email already exists in the database')) {
          toast('The provided phone number or email is already in use. Please use a different one.');
        }
      }
    } else {
      toast(strFillAllRequired);
    }
  }



  @override
  void dispose() {
    mobileNumberTextController.dispose();
    passwordTextController.dispose();
    confirmPasswordTextController.dispose();
    super.dispose();
  }
}
