import 'package:expense_tracker/app/data/local/preferences/local_db_model.dart';
import 'package:expense_tracker/app/data/local/preferences/request_models.dart';

import '../../../export.dart';

class LoginController extends GetxController {
  RxBool viewPassword = true.obs;
  RxBool isRemembered = false.obs;

  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  final DataBaseManager _LocalStorage = Get.find<DataBaseManager>();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    //TODO Remove this while making build
    emailTextController.text = 'Test5@gmail.com';
    passwordTextController.text = 'Test@123';
    super.onReady();
  }

  @override
  void dispose() {
    emailTextController.dispose();
    passwordTextController.dispose();
    super.dispose();

  }


  signIn() async {
    if (emailTextController.text != "" && passwordTextController.text != "") {
      var data = LocalDBRequestModel.signInRequestModel(
        email: emailTextController.text,
        password: passwordTextController.text,
      );
      try {
        UserModel? userModel = await _LocalStorage.signIn(dataBody: data);
        saveAuthenticatedUserData(userId: int.parse("${userModel?.id ?? "0"}"));
      } catch (e) {
        if (e.toString().contains('Phone number or email already exists in the database')) {
          toast('The provided email is already in use. Please use a different one.');
        }
      }
    } else {
      toast('Please enter both email and password.');
    }
  }

  saveAuthenticatedUserData({required int userId}) async {
    var data = LocalDBRequestModel.AuthUserRequestModel(authenticatedUserID: userId);
    try {
      var id = await _LocalStorage.insertAuthData(dataBody: data);
      Get.offAndToNamed(AppRoutes.homeRoute);
    } catch (e) {
      toast("$e");
    }
  }

}
