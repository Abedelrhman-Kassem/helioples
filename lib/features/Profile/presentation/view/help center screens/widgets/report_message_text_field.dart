import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/generated/locale_keys.g.dart';

class ReportMessageTextField extends StatelessWidget {
  final TextEditingController controller;

  const ReportMessageTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Text(
            LocaleKeys.report_screen_your_message.tr(),
            style: Styles.styles14w400NormalBlack,
          ),
        ),
        SizedBox(height: 10.h),
        TextField(
          minLines: 6,
          maxLines: 9,
          controller: controller,
          decoration: InputDecoration(
            hintText: LocaleKeys.report_screen_enter_your_message_in_details
                .tr(),
            hintStyle: Styles.styles17w500NormalBlack.copyWith(
              color: const Color.fromRGBO(50, 50, 50, 1),
            ),
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
          ),
        ),
      ],
    );
  }
}
