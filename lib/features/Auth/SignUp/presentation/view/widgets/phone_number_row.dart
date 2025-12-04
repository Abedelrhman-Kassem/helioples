import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/utils.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/features/Auth/Login/presentation/view/widgets/egypt_code_widget.dart';

class PhoneNumberRow extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final EdgeInsets? padding;

  const PhoneNumberRow({
    super.key,
    required this.controller,
    this.labelText = "Phone Number",
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 15.h),
        Padding(
          padding: padding ?? EdgeInsets.only(left: 10.w),
          child: Text(
            labelText,
            style: Styles.styles14w400NormalBlack,
          ),
        ),
        SizedBox(height: 10.h),
        Row(
          children: [
            const EgyptionCodeWidget(),
            SizedBox(width: 10.w),
            Expanded(
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  if (!GetUtils.isPhoneNumber(value)) {
                    return 'Must be an 11-digit number';
                  }
                  return null;
                },
                controller: controller,
                enabled: true,
                keyboardType: TextInputType.number,
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
            ),
          ],
        ),
      ],
    );
  }
}
