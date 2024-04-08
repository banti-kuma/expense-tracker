import '../../../export.dart';

class LoginScreen extends StatelessWidget {
  final controller = Get.put(LoginController());
  final themeController = Get.put(ThemeController());
  final GlobalKey<FormState> loginFormGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegionWidget(statusBarColor: Colors.white,statusBarBrightness: Brightness.dark,
      child: GetBuilder<LoginController>(
          init: LoginController(),
          builder: (controller) {
            return Scaffold(
                resizeToAvoidBottomInset: false,
                body: SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: height_40,
                      ),
                      _loginText(),
                      _form(),
                      _loginButton(),
                      Spacer(),
                      _signup()
                    ],
                  ).paddingSymmetric(horizontal: margin_20),
                ));
          }),
    );
  }

  _loginText() =>  Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextView(
            text:   strLogin,
          textStyle: textStyleHeadlineLarge().copyWith(
                  fontSize: font_22,
                  color: themeController.isDarkMode.value == true
                      ? Colors.white
                      : Colors.black,
                  fontWeight: FontWeight.w700),
            ).paddingOnly(bottom: margin_8),
            Text(
             strLoginContent,
              style: textStyleBodyLarge().copyWith(color: Colors.grey.shade600),
              textAlign: TextAlign.center,
            )
          ],
        ).paddingOnly(top: margin_30),
      );

  _form() => Form(
        key: loginFormGlobalKey,
        child:  Column(
            children: [
              _emailTextField(),
              _passwordTextField(),
            ],
          ).paddingOnly(top: margin_20, bottom: margin_30),
      );

  _emailTextField() => TextFieldWidget(
        hint:strEnterEmail,
        textController: controller.emailTextController,
        focusNode: controller.emailFocusNode,
        inputType: TextInputType.emailAddress,

        validate: (value) => EmailValidator.validateEmail(value),
        inputAction: TextInputAction.next,
      ).paddingSymmetric(
        vertical: margin_15,
      );

  _passwordTextField() => TextFieldWidget(
        hint: strEnterPassword,
        textController: controller.passwordTextController,
        focusNode: controller.passwordFocusNode,
        inputType: TextInputType.visiblePassword,
        obscureText: controller.viewPassword.value,
        validate: (value) => PasswordFormValidator.validatePassword(value),
        suffixIcon: GetInkWell(
          onTap: () {
            controller.viewPassword.value = !controller.viewPassword.value;
            controller.update();
          }
              ,
          child: Icon(controller.viewPassword.value?Icons.visibility:Icons.visibility_off,color: AppColors.appGreenColor,).paddingSymmetric(vertical: margin_15, horizontal: margin_10),
        ),
        inputAction: TextInputAction.next,
      );


  Widget _loginButton() => MaterialButtonWidget(buttonBgColor: AppColors.appGreenColor,
        onPressed: () {
          controller.signIn();
        },
        buttonText: strLogin,
      );

  Widget _signup() => Text.rich(
        TextSpan(
            text: strDntHaveAcount,
            style: textStyleTitleSmall().copyWith(
              color: themeController.isDarkMode.value == true
                  ? Colors.white
                  : AppColors.greyColor,
            ),
            children: [
              const TextSpan(text: ' '),
              TextSpan(
                  text: strSignUp,
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => Get.toNamed(AppRoutes.signupRoute),
                  style: textStyleTitleSmall().copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      decoration: TextDecoration.underline)),
            ]),
      ).paddingOnly(bottom: margin_16);
}
