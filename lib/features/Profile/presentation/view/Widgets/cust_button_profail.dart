import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';

class CustButtonProfail extends StatelessWidget {
  final String title;
  final void Function() onPressed;
  const CustButtonProfail(
      {super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75.h,
      margin: EdgeInsets.only(bottom: 17.h),
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22.r),
          ),
        ),
        onPressed: onPressed,
        child: Text(title,
            style: TextStyle(
              color: MyColors.mainColor,
              fontSize: 20.sp,
            )),
      ),
    );
  }
}
