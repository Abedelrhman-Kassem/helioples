import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';

class HelpCenterWidget extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  const HelpCenterWidget({
    Key? key,
    required this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 65.h,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(241, 241, 241, 1),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 20.h),
          child: Text(
            title,
            style: Styles.styles14w600Black,
          ),
        ),
      ),
    );
  }
}
