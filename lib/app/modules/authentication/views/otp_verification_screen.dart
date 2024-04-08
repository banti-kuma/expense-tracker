
import 'package:pinput/pinput.dart';

import '../../../export.dart';

class OtpVerificationScreen extends StatelessWidget {
  final controller = Get.put(OtpVerificationController());
  final themeController = Get.put(ThemeController());
  final GlobalKey<FormState> otpVerifyFormGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OtpVerificationController>(
        init: OtpVerificationController(),
        builder: (context) {
          return AnnotatedRegionWidget(statusBarColor: Colors.white,statusBarBrightness: Brightness.dark,
            child: Scaffold(
                body:Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextView(
                        text: strVerifyMail,
                        textStyle: textStyleHeadlineLarge().copyWith(
                          color: themeController.isDarkMode.value==true?Colors.white:Colors.black,
                            fontSize: font_22, fontWeight: FontWeight.w700),
                      ).paddingOnly(bottom: margin_8, top: margin_50),
                      _descriptionTxt(),
                      _otpTextFields(),
                      _resend(),
                    ],
                  ),
                  _verifyButton(),
                ],
              ).paddingSymmetric(horizontal: margin_20),
            ),
          );
        });
  }

  _descriptionTxt() {
    return Text.rich(
      TextSpan(
          text:
              "Enter the 4 code we’ve sent to ",
          style: textStyleBodyLarge().copyWith(color: Colors.grey.shade700),
          children: [
            TextSpan(
                text: controller.contactNumber,
                recognizer: TapGestureRecognizer()
                  ..onTap = () => Get.back(),
                style: textStyleTitleSmall().copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: font_14,
                    color: Colors.black)),
          ]),
    );
  }

  _otpTextFields() => Form(
        key: otpVerifyFormGlobalKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Pinput(
          errorBuilder:(String? errorText, String pin){
            return Row(
              children: [
                Text(errorText.toString(),
                  textAlign: TextAlign.start,
                  style: textStyleBodyMedium()
                    .copyWith(color: Colors.red,
                    fontWeight: FontWeight.w600,
                    fontSize: font_11),),
                Expanded(child: Container())
              ],
            ).paddingOnly(top: margin_10);
          } ,
          controller: controller.otpTextController,
          focusNode: controller.otpFocusNode,
          length: 4,
          cursor: Padding(
            padding: EdgeInsets.symmetric(vertical: margin_15),
            child: VerticalDivider(
              color: AppColors.appColor,
              thickness: margin_1point2,
            ),
          ),
          pinContentAlignment: Alignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          listenForMultipleSmsOnAndroid: true,
          keyboardType: TextInputType.number,
          inputFormatters: [ FilteringTextInputFormatter.allow(RegExp("[0-9]")),],
          defaultPinTheme: PinTheme(
            width: height_50,
            height: height_52,
            textStyle: textStyleBodyLarge().copyWith(color: themeController.isDarkMode.value==true?Colors.white:Colors.black),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius_12),
              border: Border.all(color:themeController.isDarkMode.value==true?AppColors.appBorderDarkColor: Colors.grey, width: width_1),
              color: themeController.isDarkMode.value==true?Colors.black:Colors.white,
            ),
          ),
          showCursor: true,
          isCursorAnimationEnabled: true,
          disabledPinTheme: PinTheme(
            width: height_50,
            height: height_52,
            textStyle: textStyleBodyLarge().copyWith(color: themeController.isDarkMode.value==true?Colors.white:Colors.black),
            decoration: BoxDecoration(
              color:themeController.isDarkMode.value==true?Colors.black:Colors.white,
            ),
          ),
          focusedPinTheme: PinTheme(
            width: height_50,
            height: height_52,
            textStyle: textStyleBodyLarge().copyWith(color: themeController.isDarkMode.value==true?Colors.white:Colors.black),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius_12),
                border: Border.all(color:themeController.isDarkMode.value==true?AppColors.appBorderDarkColor: Colors.grey, width: width_1)),
          ),

          errorTextStyle: textStyleBodyMedium()
              .copyWith(color: Colors.red,
              fontWeight: FontWeight.w600,
              fontSize: font_11),
          pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
        ).paddingOnly(bottom: margin_20, top: margin_20),
      );

  Widget _verifyButton() => MaterialButtonWidget(
        onPressed: () {
          controller.otpVerification();
          // Get.offAllNamed(AppRoutes.mainScreenRoute, arguments: {fromSignUp: true});
        },
    textColor: Colors.white,
        buttonText: strContinue,buttonBgColor: AppColors.appDarkColor,
      ).marginOnly(bottom: margin_20);

  _timerText() => Text.rich(
        TextSpan(
            text: strResendCodeIn,
            style: textStyleBodyLarge().copyWith(color: themeController.isDarkMode.value==true?Colors.white:Colors.grey.shade700),
            children: [
              TextSpan(
                  text: controller.secondsStr,
                  // recognizer: TapGestureRecognizer()
                  //   ..onTap = () => Get.offAllNamed(AppRoutes.loginRoute),
                  style: textStyleTitleSmall().copyWith(
                    fontWeight: FontWeight.w600,
                    color: themeController.isDarkMode.value==true?Colors.grey:Colors.black,
                    fontSize: font_12,
                  )),
            ]),
      );

  Widget _resend() => Align(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            controller.start == 0
                ? GetInkWell(
                    onTap: () {
                      controller.start = 30;
                      controller.secondsStr = '00:30';
                      controller.startTimer();
                      controller.update();
                    },
                    child: TextView( text: strResendCode,
                        textStyle: textStyleBodyLarge().copyWith(
                            fontSize: font_13,
                            color: themeController.isDarkMode.value==true?Colors.white:Colors.black,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline)),
                  )
                : SizedBox(),
            controller.start == 0 ? SizedBox() : _timerText(),
          ],
        ).paddingOnly(top: margin_5),
      );
}
