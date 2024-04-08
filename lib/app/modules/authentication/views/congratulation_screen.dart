import '../../../export.dart';

class CongratulationScreen extends StatelessWidget {
  final controller = Get.put(CongratulationController());
  final themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<CongratulationController>(
            init: CongratulationController(),
            builder: (context) {
              return Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AssetImageWidget(
                    iconsSplashIcon,
                    imageHeight: height_80,
                  ).paddingOnly(bottom: margin_20),
                  Text(
                    'Congratulations!',
                    style: textStyleHeadlineLarge().copyWith(
                        fontSize: font_22,
                        color: themeController.isDarkMode.value==true?Colors.white:Colors.black,
                        fontWeight: FontWeight.w700),
                  ).paddingOnly(bottom: margin_8),
                  Text(
                    "Thank you for registering your company with us for the expense tracker app",
                    style: textStyleBodyLarge().copyWith(
                        color: Colors.grey.shade600,
                        fontSize: font_14,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                ],
              )
                  .paddingSymmetric(horizontal: margin_25)
                  .paddingOnly(bottom: margin_30));
            }),
      ),
    );
  }

}
