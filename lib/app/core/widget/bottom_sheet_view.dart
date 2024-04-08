import '../../export.dart';
import '../values/app_values.dart';

class BottomSheetWidget extends StatelessWidget {
  final Color? bottomSheetColor;
  final Widget? widget;
  final bool? isScrollDivider;

  BottomSheetWidget({this.bottomSheetColor, this.widget, this.isScrollDivider});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: bottomSheetColor ?? Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(radius_20),
                topLeft: Radius.circular(radius_20))),
        child: Column(
          children: [
            isScrollDivider == true ? _divider() : Container(),
            widget ?? Container()
          ],
        ));
  }

  _divider() {
    return Container(
      height: height_5,
      width: width_40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius_5),
        color: Colors.grey.withOpacity(0.5),
      ),
    );
  }
}
