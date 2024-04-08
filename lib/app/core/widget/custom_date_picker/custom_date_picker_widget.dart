import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:expense_tracker/app/core/utils/date_conversion.dart';
import 'package:expense_tracker/app/core/values/route_arguments.dart';
import 'package:expense_tracker/app/core/widget/custom_date_picker/custom_date_picker_controller.dart';
import 'package:expense_tracker/app/core/widget/dropdown_text_Widget.dart';
import '../../../export.dart';

class CustomDatePicker extends StatelessWidget {
  final controller = Get.put(CustomDatePickerController());
  final themeController = Get.put(ThemeController());
  final void Function(dynamic)? onSuccess;

  CustomDatePicker({Key? key, this.onSuccess}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomDatePickerController>(
        init: CustomDatePickerController(),
        builder: (controller) {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: height_40,
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(),
                      const Spacer(),
                      SizedBox(
                        height: height_28,
                        width: height_100,
                        child: DropDownTextFieldWidget(
                          items: controller.items,
                          selectedValue: controller.selectedItem,
                          onFieldSubmitted: (value) {
                            controller.onTypeChange(value);
                          },
                        ),
                      ).paddingOnly(right: margin_20),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.appColor,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(24),
                          bottomRight: Radius.circular(24))),
                  child: Column(
                    children: [
                      controller.isDaily ? _dayPicker() : SizedBox(),
                      controller.isWeekly ? _rangePicker() : SizedBox(),
                      controller.isYearly ? _yearPicker() : SizedBox(),
                      controller.isMonthly ? _monthPicker() : SizedBox(),
                    ],
                  ),
                )
              ],
            ).paddingSymmetric(horizontal: margin_15),
          );
        });
  }

  _dayPicker() => DatePicker(
        minDate: DateTime(2021, 1, 1),
        maxDate: DateTime.now(),
        enabledCellsTextStyle:
            textStyleBodyMedium().copyWith(color: Colors.black),
        disabledCellsTextStyle:
            textStyleBodyMedium().copyWith(color: Colors.grey),
        daysOfTheWeekTextStyle:
            textStyleBodyMedium().copyWith(color: Colors.black),
        onDateSelected: (value) {
          Get.back(result: {
            argValueOfDatePicker: SDateUtils.formatDate("${value}"),
            argTypeOfDatePicker: strDaily
          });
        },
      );

  _rangePicker() => RangeDatePicker(
        minDate: DateTime(2021, 1, 1),
        maxDate: DateTime.now(),
        onRangeSelected: (value) {
          Get.back(result: {
            argValueOfDatePicker:
                "${SDateUtils.formatDate("${value.start}")} - ${SDateUtils.formatDate("${value.end}")}",
            argTypeOfDatePicker: strWeekly
          });
        },
      );

  _yearPicker() => YearsPicker(
        minDate: DateTime(2021),
        maxDate: DateTime.now(),
        onDateSelected: (value) {
          Get.back(result: {
            argValueOfDatePicker: "${value.year}",
            argTypeOfDatePicker: strYearly
          });
        },
      );

  _monthPicker() => MonthPicker(
        minDate: DateTime(2022),
        maxDate: DateTime.now(),
        onDateSelected: (value) {
          Get.back(result: {
            argValueOfDatePicker: "${value.month}-${value.year}",
            argTypeOfDatePicker: strMonthly
          });
        },
      );
}
