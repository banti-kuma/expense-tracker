import 'package:expense_tracker/app/core/utils/date_conversion.dart';
import 'package:expense_tracker/app/core/widget/asset_svg_image.dart';
import 'package:expense_tracker/app/core/widget/no_data_widget.dart';
import 'package:expense_tracker/app/data/local/preferences/local_db_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

import '../../../export.dart';

class HomeScreen extends StatelessWidget {
  final controller = Get.put(HomeController());
  final themeController = Get.put(ThemeController());

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          return Scaffold(
            appBar: CustomAppBar(
              isBack: false,
              appBarTitleText: strApplicationName,
              actionWidget: [
                InkWell(
                  onTap: () async {
                    var result = await Get.dialog(CustomDatePicker());
                    print("result: $result");
                    if (result != null) {
                      controller.afterFilter(result[argValueOfDatePicker] ?? "",
                          result[argTypeOfDatePicker] ?? "");
                    }
                  },
                  child: TextView(
                    text: "< ${controller.currentYear} >",
                    textStyle: textStyleBodyMedium().copyWith(
                        color: Colors.black,
                        fontSize: font_16,
                        fontWeight: FontWeight.w600),
                  ),
                ).paddingOnly(top: margin_13, right: margin_4),
                IconButton(
                  onPressed: () {
                    Get.dialog(LogOutDialogWidget(
                        title: strLogout,
                        description: strLogoutDes,
                      onYesPressed: (){
                          controller.logOut();
                      },
                    ));
                  },
                  icon: SizedBox(
                    height: height_16,
                    width: height_16,
                    child: AssetSVGImageWidget(iconsLogout),
                  ),
                ).paddingOnly(top: margin_13)
              ],
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: const Color.fromRGBO(82, 170, 94, 1.0),
              tooltip: 'Add Or Update Expenses',
              onPressed: () async {
                var result = await Get.toNamed(AppRoutes.AddExpenseRoute);
                if (result ?? false) {
                  controller.getYearlyExpenses(year: "${DateTime.now().year}");
                  controller.update();
                }
              },
              child: const Icon(Icons.add, color: Colors.white, size: 32),
            ).paddingOnly(bottom: margin_10, right: margin_10),
            body: Container(
              height: Get.height,
              width: Get.width,
              color: AppColors.appColor,
              child: Column(
                children: [
                  Center(
                    child: TextView(
                      text: strTotalExpenses,
                      textStyle: textStyleBodyMedium().copyWith(
                          fontWeight: FontWeight.w600, fontSize: font_16),
                    ),
                  ).paddingOnly(top: margin_24),
                  Center(
                    child: Container(
                      width: width_200,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          border: Border.all(color: Colors.grey)),
                      child: TextView(
                        textAlign: TextAlign.center,
                        text: "\$${controller.totalExpense}",
                        textStyle: textStyleBodyMedium().copyWith(
                            color: Colors.redAccent,
                            fontSize: font_16,
                            fontWeight: FontWeight.w600),
                      ).paddingSymmetric(vertical: margin_16),
                    ),
                  ).paddingOnly(top: margin_12),
                  Container(
                    height: height_28,
                    width: Get.width,
                    color: AppColors.toastGrayColor,
                    child: Row(
                      children: [
                        TextView(
                          text: strExpenses,
                          textStyle: textStyleBodyMedium().copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: font_12,
                          ),
                        ).paddingOnly(left: margin_12),
                        Spacer(),
                        // SizedBox(
                        //   height: height_20,
                        //   width: height_80,
                        //   child: DropDownTextFieldWidget(
                        //     items: controller.items,
                        //     selectedValue: controller.selectedItem,
                        //     onFieldSubmitted: (value) {
                        //       controller.onTypeChange(value);
                        //     },
                        //   ),
                        // ).paddingOnly(right: margin_20)
                      ],
                    ),
                  ).paddingOnly(top: margin_20, bottom: margin_20),
                  controller.noData ? Center(child: NoDataWidget()).paddingOnly(top: margin_80): Expanded(child: _grouplist(controller.expenses))
                ],
              ),
            ),
          );
        });
  }

  Widget _grouplist(List<ExpensesModel> expenses) {
    expenses.sort((a, b) => a.expenseDate!.compareTo(b.expenseDate!));

    return GroupedListView<ExpensesModel, String>(
      elements: expenses,
      groupBy: (ExpensesModel element) {
        DateTime date = SDateUtils.parseDateString(element.expenseDate ?? "")!;
        return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
      },
      groupComparator: (group1, group2) {
        // Compare groups (months) to sort them
        return group1.compareTo(group2);
      },
      groupSeparatorBuilder: (String groupByValue) => Container(
        height: height_25,
        width: Get.width,
        color: AppColors.toastGrayColor,
        child: TextView(
          textAlign: TextAlign.left,
          text: "${SDateUtils.formatDate(groupByValue)}",
          textStyle: textStyleBodyMedium()
              .copyWith(fontSize: font_14, fontWeight: FontWeight.w600),
        ).paddingOnly(top: margin_4, left: margin_8),
      ),
      itemBuilder: (context, ExpensesModel element) => InkWell(
        onTap: () {
          Get.toNamed(AppRoutes.AddExpenseRoute,
              arguments: {argExpense: element, argForEdit: true});
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height_35,
              width: height_35,
              child: AssetSVGImageWidget(
                element.icon ?? "",
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextView(
                  text: element.category ?? "",
                  textStyle: textStyleBodyMedium()
                      .copyWith(fontWeight: FontWeight.w600, fontSize: font_14),
                ),
                TextView(
                  text: element.notes ?? "",
                  textStyle: textStyleBodyMedium().copyWith(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                      fontSize: font_12),
                )
              ],
            ).paddingOnly(top: margin_4, left: margin_8),
            Spacer(),
            Expanded(
                child: TextView(
              textAlign: TextAlign.right,
              text: "\$${element.price ?? ""}",
              textStyle: textStyleBodyMedium()
                  .copyWith(fontSize: font_14, color: Colors.redAccent),
            ).paddingOnly(top: margin_4, right: margin_8))
          ],
        ).paddingSymmetric(vertical: margin_4, horizontal: margin_10),
      ),
      useStickyGroupSeparators: false,
      floatingHeader: false,
      order: GroupedListOrder.ASC,
    );
  }

}
