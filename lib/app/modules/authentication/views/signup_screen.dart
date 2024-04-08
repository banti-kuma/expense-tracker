import '../../../export.dart';

class SignUpScreen extends StatelessWidget {
  final controller = Get.put(SignUpController());
  final themeController = Get.put(ThemeController());
  final GlobalKey<FormState> signUpFormGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegionWidget(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.dark,
      child: GetBuilder<SignUpController>(
          init: SignUpController(),
          builder: (context) {
            return Scaffold(
                body: SingleChildScrollView(
                    child: SizedBox(
                        height: Get.height * .91,
                        width: Get.width,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  _signinText(),
                                  _form(),
                                  _signupButton(),
                                  // TextButton(onPressed: controller.onTabFunction(), child: Text("sdfsf",style: TextStyle(color: Colors.black),))
                                ],
                              ).paddingSymmetric(horizontal: margin_20),
                              _signIn()
                            ]))));
          }),
    );
  }

  _signinText() => Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              strSignup,
              style: textStyleHeadlineLarge().copyWith(
                  fontSize: font_22,
                  color: themeController.isDarkMode == true
                      ? Colors.white
                      : Colors.black,
                  fontWeight: FontWeight.w700),
            ).paddingOnly(bottom: margin_8),
            Text(
              strSignupContent,
              style: textStyleBodyLarge().copyWith(color: Colors.grey.shade600),
              textAlign: TextAlign.start,
            )
          ],
        ).paddingOnly(top: margin_60),
      );

  _form() => Form(
        // autovalidateMode: AutovalidateMode.ons,
        key: signUpFormGlobalKey,
        child: Column(
          children: [
            _nameTextField(),
            _emailTextField(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _countryPickerIcon(),
                _mobileNumberTextField(),
              ],
            ),
            _passwordTextField(),
          ],
        ).paddingOnly(top: margin_20, bottom: margin_10),
      );

  _nameTextField() => TextFieldWidget(
        hint: strEnterName,
        textController: controller.nameTextController,
        focusNode: controller.nameFocusNode,
        inputType: TextInputType.text,
        // formatter: [
        //   FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
        // ],
        inputAction: TextInputAction.next,
        validate: (value) =>
            FieldChecker.fieldChecker(value: value, message: strName),
      ).paddingOnly(bottom: margin_15);

  _emailTextField() => TextFieldWidget(
        hint: strEnterEmail,
        textController: controller.emailTextController,
        focusNode: controller.emailFocusNode,
        inputType: TextInputType.emailAddress,
        inputAction: TextInputAction.next,
        validate: (value) => EmailValidator.validateEmail(value),
      ).paddingOnly(bottom: margin_15);

  Widget _mobileNumberTextField() => Expanded(
        child: TextFieldWidget(
          hint: strEnterPhoneNumber,
          textController: controller.mobileNumberTextController,
          focusNode: controller.mobileNumberFocusNode,
          formatter: [
            FilteringTextInputFormatter.allow(RegExp('[0-9]')),
          ],
          validate: (data) => PhoneNumberValidate.validateMobile(data),
          inputType: TextInputType.phone,
          maxLength: 15,
          inputAction: TextInputAction.next,
        ).paddingOnly(bottom: margin_15),
      );

  Widget _countryPickerIcon() {
    return CountryPicker(
      showFlag: false,
      selectedCountry: controller.selectedCountry,
      returnCountry: (country) {
        controller.selectedCountry = country;
        controller.update();
      },
    ).paddingOnly(right: margin_10);
  }

  _passwordTextField() => TextFieldWidget(
        hint: strEnterPassword,
        textController: controller.passwordTextController,
        focusNode: controller.passwordFocusNode,
        inputType: TextInputType.visiblePassword,
        obscureText: controller.viewPassword.value,
        formatter: [
          FilteringTextInputFormatter.deny(RegExp(r'\s')),
        ],
        validate: (value) => PasswordFormValidator.validatePassword(value),
        onFieldSubmitted: (v) {
          FocusScope.of(Get.overlayContext!)
              .requestFocus(controller.confirmPasswordFocusNode);
        },
        suffixIcon: GetInkWell(
          onTap: () {
            controller.viewPassword.value = !controller.viewPassword.value;
            controller.update();
          },
          child: Icon(
            controller.viewPassword.value
                ? Icons.visibility
                : Icons.visibility_off,
            color: AppColors.appGreenColor,
          ).paddingSymmetric(vertical: margin_15, horizontal: margin_10),
        ),
        inputAction: TextInputAction.done,
      ).paddingOnly(bottom: margin_15);

  Widget _signupButton() => MaterialButtonWidget(
        buttonBgColor: AppColors.appGreenColor,
        onPressed: () {
          // print("object");
          controller.SignUp();
        },
        buttonText: strSignUp,
    buttonTextStyle: textStyleBodyMedium().copyWith(
      color: Colors.white,
      fontWeight: FontWeight.w600,
      fontSize: 14
    ),
      );

  Widget _signIn() => Text.rich(
        TextSpan(
            text: strAlreadyAccount,
            style: textStyleTitleSmall().copyWith(
              color: themeController.isDarkMode.value == true
                  ? Colors.white
                  : AppColors.greyColor,
            ),
            children: [
              TextSpan(
                  text: strLogin,
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => Get.offAllNamed(AppRoutes.loginRoute),
                  style: textStyleTitleSmall().copyWith(
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                      color: Colors.black)),
            ]),
      ).paddingOnly(bottom: margin_12);
}
