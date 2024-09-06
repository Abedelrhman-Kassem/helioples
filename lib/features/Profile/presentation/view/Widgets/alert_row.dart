import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';

class AlertRow extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  const AlertRow({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          imagePath,
          height: 100.h,
          width: 100.w,
        ),
        SizedBox(width: 16.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Styles.styles16w500Black36.copyWith(fontSize: 18.sp),
            ),
            SizedBox(
              width: 240.w,
              child: Text(
                description,
                style: Styles.styles12w400intergrey121,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
