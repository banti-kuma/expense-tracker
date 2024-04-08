import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:expense_tracker/app/core/utils/date_conversion.dart';
import 'package:expense_tracker/app/core/widget/asset_svg_image.dart';
import 'package:expense_tracker/app/core/widget/dropdown_text_Widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../export.dart';

class AddExpenseScreen extends StatelessWidget {
  final controller = Get.put(AddExpenseController());
  final themeController = Get.put(ThemeController());

  AddExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddExpenseController>(
      init: AddExpenseController(),
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppBar(
            appBarTitleText: strNewExpenses,
            isBack: true,
            actionWidget: controller.isForUpdate ? [IconButton(onPressed: (){
              controller.deleteExpenses();
            }, icon: SizedBox(
              height: height_20,
                width: height_20,
                child: Icon(Icons.delete))).paddingAll(margin_8).paddingOnly(top: margin_8)] : null,
          ),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFieldWidget(
                        hint: "0",
                        inputType: TextInputType.number,
                        hintStyle: textStyleBodyMedium()
                            .copyWith(fontSize: font_20, color: Colors.grey),
                        textStyle:
                            textStyleBodyMedium().copyWith(fontSize: font_20),
                        textController: controller.priceTextController,
                        prefixIcon: SizedBox(
                          height: height_10,
                          width: height_10,
                          child: AssetSVGImageWidget(
                            iconsDollar,
                          ),
                        ).paddingAll(margin_8),
                      ).paddingAll(margin_20),
                      Container(
                        height: height_20,
                        child: Row(
                          children: [
                            AssetSVGImageWidget(iconsCategory)
                                .paddingAll(margin_2),
                            TextView(
                                text: strCategory,
                                textStyle: textStyleBodyMedium().copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: font_14))
                          ],
                        ).paddingSymmetric(horizontal: margin_10),
                      ),
                      DropDownTextFieldWidget(
                        items: controller.items,
                        selectedValue: controller.selectedItem,
                        onFieldSubmitted: (value) {
                          controller.selectedItem = value;
                          controller.update();
                        },
                      ).paddingAll(margin_20),
                      Container(
                        height: height_20,
                        child: Row(
                          children: [
                            SizedBox(
                                width: height_20,
                                child: AssetSVGImageWidget(iconsCalendar)
                                    .paddingAll(margin_2)),
                            TextView(
                                text: strDate,
                                textStyle: textStyleBodyMedium().copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: font_14))
                          ],
                        ).paddingSymmetric(horizontal: margin_24),
                      ),
                      InkWell(
                        onTap: () async {
                          final date = await showDatePickerDialog(
                            context: context,
                            initialDate: DateTime(
                                controller.currentDate.year,
                                controller.currentDate.month,
                                controller.currentDate.day),
                            minDate: DateTime(2023, 12, 31),
                            maxDate: DateTime(
                                controller.currentDate.year,
                                controller.currentDate.month,
                                controller.currentDate.day + 1),
                            currentDate: DateTime(
                                controller.currentDate.year,
                                controller.currentDate.month,
                                controller.currentDate.day),
                            selectedDate: DateTime(
                                controller.currentDate.year,
                                controller.currentDate.month,
                                controller.currentDate.day),
                            currentDateDecoration: const BoxDecoration(),
                            currentDateTextStyle: const TextStyle(),
                            daysOfTheWeekTextStyle: const TextStyle(),
                            disabledCellsTextStyle: textStyleBodyMedium()
                                .copyWith(color: Colors.grey),
                            enabledCellsDecoration: const BoxDecoration(),
                            enabledCellsTextStyle: textStyleBodyMedium()
                                .copyWith(color: Colors.black),
                            initialPickerType: PickerType.days,
                            selectedCellDecoration: const BoxDecoration(),
                            selectedCellTextStyle: const TextStyle(),
                            leadingDateTextStyle: const TextStyle(),
                            slidersColor: Colors.lightBlue,
                            highlightColor: Colors.redAccent,
                            slidersSize: 20,
                            splashColor: Colors.lightBlueAccent,
                            splashRadius: 40,
                            centerLeadingDate: true,
                          );
                          controller.selectedDate = date!;
                          print(SDateUtils.formatDate("${controller.selectedDate}"));
                          controller.update();
                        },
                                
                        child: Container(
                          height: height_55,
                          width: Get.width,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(radius_8)),
                            border: Border.all(
                              color: AppColors.toastGrayColor,
                              width: width_1,
                            ),
                          ),
                          child: TextView(
                            text: SDateUtils.formatDate("${controller.selectedDate}"),
                            textStyle:
                                textStyleBodyMedium().copyWith(fontSize: font_20),
                          ).paddingOnly(left: margin_14, top: margin_14),
                        ).paddingAll(margin_20),
                      ),
                      Container(
                        height: height_20,
                        child: Row(
                          children: [
                            SizedBox(
                                width: height_20,
                                child: AssetSVGImageWidget(iconsNotes)
                                    .paddingAll(margin_2)),
                            TextView(
                                text: strNotes,
                                textStyle: textStyleBodyMedium().copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: font_14))
                          ],
                        ).paddingSymmetric(horizontal: margin_24),
                      ),
                      TextFieldWidget(
                        hint: "Buy a t-shirt",
                        minLine: 3,
                        maxLines: 3,
                        hintStyle: textStyleBodyMedium()
                            .copyWith(fontSize: font_20, color: Colors.grey),
                        textStyle:
                            textStyleBodyMedium().copyWith(fontSize: font_20),
                        textController: controller.notesTextController,
                      ).paddingAll(margin_20),
                    ],
                  ),
                ),
              ),
              Container(
                height: height_75,
                width: Get.width,
                child: MaterialButtonWidget(
                  buttonBgColor: AppColors.appColor,
                  buttonText: controller.isForUpdate ? "Update" : "Save",
                  buttonTextStyle: textStyleBodyMedium()
                      .copyWith(color: Colors.grey, fontSize: font_16),
                  onPressed: () {
                    controller.isForUpdate ? controller.updateExpenses() : controller.addExpense();
                  },
                ).paddingAll(margin_20),
              ),
            ],
          ),
        );
      },
    );
  }
}
