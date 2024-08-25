import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';

class NumberTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final VoidCallback onNext;

  const NumberTextField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [
        LengthLimitingTextInputFormatter(1),
        FilteringTextInputFormatter.digitsOnly,
      ],
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
        contentPadding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
      ),
      style: Styles.styles17w500NormalBlack,
      focusNode: focusNode,
      textAlign: TextAlign.center, // Center the text
      onChanged: (value) {
        if (value.length == 1) {
          onNext();
        }
      },
    );
  }
}
