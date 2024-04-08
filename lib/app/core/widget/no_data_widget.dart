import 'package:expense_tracker/app/core/widget/asset_svg_image.dart';

import '../../export.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: height_100,
          child: AssetImageWidget(
            iconsSplashIcon
          ),
        ).paddingOnly(bottom: margin_16),
        TextView(
          textAlign: TextAlign.center,
          text: "No expenses were found.",
          textStyle: textStyleBodyMedium().copyWith(
            fontSize: font_20,
            fontWeight: FontWeight.w600,
            color: Colors.black
          ),
        ),
      ],
    );
  }
}

