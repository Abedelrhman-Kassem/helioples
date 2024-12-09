import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/widgets/svg_asset.dart';

class CustomSnackBar {
  static void show({
    required BuildContext context,
    required Duration duration,
    required String text,
    required bool isGreen,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: duration,
        behavior: SnackBarBehavior.floating,
        backgroundColor: isGreen
            ? const Color.fromRGBO(213, 255, 236, 1)
            : const Color.fromRGBO(255, 207, 222, 1), // Alternate color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60),
        ),
        content: Row(
          children: [
            // Image.asset(
            //   isGreen
            //       ? "assets/svg_icons/tick-circle.svg"
            //       : "assets/svg_icons/close-circle.svg",
            //   height: 24,
            //   width: 24,
            // ),
            svgIcon(
              path: isGreen
                  ? "assets/svg_icons/tick-circle.svg"
                  : "assets/svg_icons/close-circle.svg",
              width: 24.w,
              height: 24.h,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  color: isGreen
                      ? const Color.fromRGBO(59, 183, 126, 1)
                      : const Color.fromRGBO(247, 75, 129, 1), // Text color
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
