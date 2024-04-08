import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class DropDownTextFieldWidget extends StatelessWidget {
  final String? hint;
  final dynamic selectedValue;
  final TextStyle? hintStyle;
  final TextStyle? labelTextStyle;
  final bool? Function(dynamic)? validate;
  final void Function(dynamic)? onFieldSubmitted;
  final List<String> items;
  final EdgeInsets? contentPadding;
  final Color? dropDownColor;
  final bool isShadow;
  final bool dropdownType;

  DropDownTextFieldWidget({
    this.hint,
    this.selectedValue,
    this.hintStyle,
    this.labelTextStyle,
    this.validate,
    this.onFieldSubmitted,
    required this.items,
    this.contentPadding,
    this.dropDownColor,
    this.isShadow = false,
    this.dropdownType = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            );
          }).toList(),
          onChanged: (String? value) {
            if (onFieldSubmitted != null) {
              onFieldSubmitted!(value);
            }
          },
          value: selectedValue ?? '',
          isExpanded: true,
          isDense: false,
          hint: Text(
            hint ?? "",
            style: TextStyle(
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          icon: Icon(
            Icons.arrow_drop_down,
            color: Colors.black,
            size: 20,
          ),
          elevation: 2,
          style: TextStyle(color: Colors.black),
          dropdownColor: dropDownColor ?? Colors.white,
        ),
      ),
    );
  }
}
