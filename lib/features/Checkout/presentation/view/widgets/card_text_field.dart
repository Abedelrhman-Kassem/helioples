import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';

Widget cardTextField({
  required TextEditingController controller,
  required String text,
  TextInputType? type,
  ValueChanged<String>? onChanged,
  ValueChanged<String>? onSubmit,
  int? maxLength,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        text,
        style: Styles.styles14w400NormalBlack,
      ),
      SizedBox(height: 10.h),
      TextFormField(
        controller: controller,
        keyboardType: type,
        maxLength: maxLength,
        buildCounter: (
          context, {
          required currentLength,
          required isFocused,
          required maxLength,
        }) {
          return null;
        },
        cursorColor: MyColors.mainColor,
        style: Styles.styles17w500NormalBlack.copyWith(
          color: const Color.fromRGBO(50, 50, 50, 1),
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
          filled: true,
          fillColor: const Color.fromRGBO(246, 246, 246, 1),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: const Color.fromRGBO(210, 210, 210, 1),
              width: 1.5.r,
            ),
            borderRadius: BorderRadius.circular(50.r),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: MyColors.mainColor,
              width: 1.5.r,
            ),
            borderRadius: BorderRadius.circular(50.r),
          ),
        ),
        onChanged: onChanged,
        onFieldSubmitted: onSubmit,
      ),
    ],
  );
}
