import '../../../export.dart';

class AuthenticationScreenHeading extends StatelessWidget {
  var themeController=Get.put(ThemeController());
  final String title;
  final textStyle;

  AuthenticationScreenHeading({
    Key? key,
    required this.title,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Align(
            alignment: Alignment.centerLeft,
            child: TextView(text: title,
                maxLines: 2,
                textAlign: TextAlign.start,
                textStyle: textStyle ?? textStyleDisplayLarge().copyWith(
                  fontSize: font_22,
                    color: themeController.isDarkMode.value==true?Colors.white:Colors.black,
                    fontWeight: FontWeight.w700)))
        .paddingOnly(top: margin_15, bottom: margin_10));
  }
}
