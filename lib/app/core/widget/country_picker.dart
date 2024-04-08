
import '../../export.dart';


class CountryPicker extends StatelessWidget {

  final Country? selectedCountry;
  final bool? showFlag;
  final returnCountry;
  final textColor;
  final bool? isTapEnable;

   CountryPicker({
    Key? key,
    this.selectedCountry,
    this.showFlag = true,
    this.returnCountry,
    this.textColor,
    this.isTapEnable = true,
  }) : super(key: key);

  var themeController=Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
      padding: EdgeInsets.symmetric(vertical: margin_11),
      decoration: BoxDecoration(
        color:themeController.isDarkMode.value==true?Colors.black:Colors.white,
        borderRadius: BorderRadius.circular(radius_10),
        border: Border.all(color: themeController.isDarkMode.value==true?AppColors.appBorderDarkColor:Colors.grey.shade400)
      ),
      child: InkWell(
        onTap: isTapEnable == true
            ? () {
          showCountryPicker();
        }
            : () {},
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextView( text: selectedCountry!.callingCode,
                textStyle: textStyleBodyLarge().copyWith(
                  color: textColor??(themeController.isDarkMode.value==true?Colors.grey:Colors.black),
                    fontWeight: FontWeight.w700, ))
                .paddingOnly(left: margin_8),
            Icon(Icons.arrow_drop_down,color: textColor??(themeController.isDarkMode.value==true?Colors.grey:Colors.black),)


          ],
        ).paddingOnly(left: margin_10, right: margin_6),
      ),
    ));
  }

  void showCountryPicker() async {

    final country = await showCountryPickerSheet(Get.context!,
        cornerRadius: 25,
        focusSearchBox: true,
        cancelWidget: Positioned(
            right: 1.0,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: Obx(()=>InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: TextView(
                    text: 'Cancel',
                    textStyle: textStyleBodyLarge().copyWith(color: themeController.isDarkMode.value==true?Colors.white:Colors.black),
                  ))),
            )));
    if (country != null) {
      // print(country.);
      returnCountry(country);
    }
  }
}
