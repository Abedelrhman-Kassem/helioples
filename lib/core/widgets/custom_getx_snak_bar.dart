import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:negmt_heliopolis/core/widgets/svg_asset.dart';

void showCustomGetSnack({
  required bool isGreen,
  required String text,
  Duration duration = const Duration(seconds: 5),
}) {
  Get.rawSnackbar(
    titleText: const SizedBox.shrink(),
    backgroundColor: Colors.transparent,
    snackStyle: SnackStyle.FLOATING,
    snackPosition: SnackPosition.BOTTOM,
    maxWidth: Get.width * 0.95,
    margin: EdgeInsets.only(left: 12.w, right: 12.w, bottom: 18.h),
    padding: EdgeInsets.zero,
    borderRadius: 0,
    duration: duration,
    messageText: Container(
      decoration: BoxDecoration(
        color: isGreen
            ? const Color.fromRGBO(213, 255, 236, 1)
            : const Color.fromRGBO(255, 207, 222, 1),
        borderRadius: BorderRadius.circular(60.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      child: Row(
        children: [
          Container(
            width: 36.w,
            height: 36.w,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Center(
              child: svgIcon(
                path: isGreen
                    ? "assets/svg_icons/tick-circle.svg"
                    : "assets/svg_icons/close-circle.svg",
                width: 24.w,
                height: 24.h,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: isGreen
                    ? const Color.fromRGBO(59, 183, 126, 1)
                    : const Color.fromRGBO(247, 75, 129, 1),
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Get.back(),
            child: const Icon(Icons.close, size: 18, color: Colors.black26),
          ),
        ],
      ),
    ),
  );
}
