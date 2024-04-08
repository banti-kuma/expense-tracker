

import '../../export.dart';

var themeController=Get.put(ThemeController());


customButton({buttonText, onTap}) {
  return Obx(() => Container(
      padding: EdgeInsets.only(top: margin_15, left: margin_20, right: margin_20,bottom: margin_20),
      decoration: BoxDecoration(color: themeController.isDarkMode.value==true?Colors.black:Colors.white, boxShadow: [
        BoxShadow(
            color: themeController.isDarkMode.value==true?Colors.transparent:Colors.grey.shade300, offset: Offset(0, -2), blurRadius: 2.0)
      ]),
      child: MaterialButtonWidget(
        onPressed: onTap ?? () {},
        textColor: Colors.white,
        buttonText: buttonText ?? '',buttonBgColor: AppColors.appGreenColor,
      )));
}

lightTheme({color}){
  if(Platform.isAndroid){
    SystemChrome.setSystemUIOverlayStyle(   SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: color?? Colors.white,
        systemNavigationBarContrastEnforced: true,
        systemNavigationBarDividerColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));
  }

}

Widget emptySizeBox()=>SizedBox(width: margin_0,height: margin_0,);
