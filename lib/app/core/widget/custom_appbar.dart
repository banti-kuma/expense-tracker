import 'package:expense_tracker/app/core/widget/asset_svg_image.dart';

import '../../export.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  var themeController = Get.put(ThemeController());
  final String? appBarTitleText;
  final actionWidget;
  final actions;
  final titleView;
  final bool? isBack;
  final Color? bgColor;
  final Color? backIconColor;
  final bool? isDrawerIcon;
  final bool? isCustom;
  final bool? isAuthentication;
  final Function? onTap;

  CustomAppBar({
    Key? key,
    this.appBarTitleText,
    this.onTap,
    this.actions,
    this.titleView,
    this.actionWidget,
    this.isBack,
    this.isDrawerIcon = false,
    this.isCustom = false,
    this.isAuthentication = false,
    this.backIconColor,
    this.bgColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: height_65,
      leading: (isBack ?? false) ? IconButton(onPressed: (){
        Get.back();
      }, icon: Container(
        height: height_36,
        child: AssetSVGImageWidget(
          iconsBackArrowIcon,
          imageHeight: height_16,
        ).paddingOnly(top: margin_12),
      ),) : null,
      // leading: TextView(text: strApplicationName,),
      centerTitle: false,
      title: appBarTitleText != "" || appBarTitleText != null
          ? TextView(
        text: appBarTitleText ?? "",
        textAlign: TextAlign.center,
        textStyle: textStyleHeadlineMedium().copyWith(
            fontWeight: FontWeight.w500,
            color: AppColors.screenHeadingColor),
      ).paddingOnly(top: margin_10)
          : Container(
        height: 0,
        width: 0,
      ),
      shadowColor: Colors.transparent,
      backgroundColor: AppColors.appColor,
      actions: actionWidget ?? [],
    );
  }


  @override
  Size get preferredSize =>
      Size.fromHeight(isCustom == false ? height_60 : height_80);
}
