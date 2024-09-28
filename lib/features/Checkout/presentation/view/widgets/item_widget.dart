import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/helper.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';

Widget itemWidget() {
  return Row(
    children: [
      Text(
        'x2',
        style: Styles.styles12w300NormalBlack,
      ),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 10.w),
        width: 70.w,
        height: 70.h,
        child: Helper.loadNetworkImage(
          assetsErrorPath: 'assets/test_images/mango-category.png',
          fit: BoxFit.contain,
        ),
      ),
      SizedBox(
        width: 170.w,
        child: Text(
          'Butter Croissant',
          style: Styles.styles14w400Black.copyWith(
            color: const Color.fromRGBO(50, 50, 50, 1),
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      const Spacer(),
      Text(
        '120.00',
        style: Styles.styles21w400NormalBlack,
      ),
    ],
  );
}
