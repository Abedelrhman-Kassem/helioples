import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';

class NameTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final bool isEnabled;

  const NameTextField({
    super.key,
    required this.labelText,
    required this.controller,
    required this.isEnabled,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: Text(
            labelText,
            style: Styles.styles14w400NormalBlack,
          ),
        ),
        SizedBox(height: 8.h),
        TextField(
          controller: controller,
          enabled: isEnabled,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color.fromRGBO(246, 246, 246, 1),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.r),
              borderSide: const BorderSide(
                color: Color.fromRGBO(210, 210, 210, 1),
                width: 1.5,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.r),
              borderSide: const BorderSide(
                color: Color.fromRGBO(210, 210, 210, 1),
                width: 1.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.r),
              borderSide: const BorderSide(
                color: Color.fromRGBO(210, 210, 210, 1),
                width: 1.5,
              ),
            ),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          ),
          style: Styles.styles17w500NormalBlack,
        ),
      ],
    );
  }
}
