import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';

class OrderStatusWidget extends StatelessWidget {
  final String iconPath; 
  final String title; 
  final String date; 
  final bool isDone; 

  const OrderStatusWidget({
    super.key,
    required this.iconPath,
    required this.title,
    required this.date,
    this.isDone = false, 
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          isDone ? "assets/svg_icons/completed_order_icon.svg" : "assets/svg_icons/not_completed_order_icon.svg",
          width: 32.w,
          height: 32.h,
        ),
        SizedBox(
          width: 20.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Styles.styles14w500interBlack36,
            ),
            SizedBox(
              height: 8.h,
            ),
            Text(
              date,
              style: Styles.styles12w400intergrey121,
            ),
          ],
        ),
        const Spacer(),

          SvgPicture.asset(
            iconPath,
            width: 32.w,
            height: 32.h,
          ),
      ],
    );
  }
}
