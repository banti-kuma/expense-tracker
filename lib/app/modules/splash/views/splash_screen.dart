
import '../../../export.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      init: SplashController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.appColor,
            body: SizedBox(width: Get.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AssetImageWidget(
                    iconsSplashIcon,
                      imageHeight: height_200,
                    ).paddingOnly(bottom: margin_10).animate().slideY(delay: Duration(milliseconds: 100)),

                  TextView(
                      text: strSplashTitle,
                    textStyle: textStyleDisplayLarge().copyWith(
                      fontSize: font_35
                    ),
                  ),
                  TextView(
                      text: strSplashDescription,
                    textStyle: textStyleBodyMedium().copyWith(
                      fontSize: font_12,
                      color: AppColors.appGreenColor
                    ),
                  ).paddingOnly(top: margin_10)
                ],
              ),
            ),


        );
      }
    );
  }
}
