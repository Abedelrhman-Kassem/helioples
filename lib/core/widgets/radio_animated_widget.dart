import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget radioAnimatedWidget(bool active) {
  return AnimatedContainer(
    width: 17.w,
    height: 17.h,
    duration: const Duration(milliseconds: 300),
    decoration: BoxDecoration(
      shape: BoxShape.circle, // To make it look like a radio button
      border: Border.all(
        color: active
            ? const Color.fromRGBO(248, 147, 31, 1)
            : const Color.fromRGBO(150, 150, 150, 1),
        width: 0.88.r,
      ),
    ),
    child: Align(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 6.38.w,
        height: 6.38.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: active
              ? const Color.fromRGBO(248, 147, 31, 1)
              : Colors.transparent,
        ),
      ),
    ),
  );
}
