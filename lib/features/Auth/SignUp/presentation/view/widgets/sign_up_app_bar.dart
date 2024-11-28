import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';

class SignUpAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isEn;
  final Function(bool) onLanguageChange;

  const SignUpAppBar({
    super.key,
    required this.title,
    required this.isEn,
    required this.onLanguageChange,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back, size: 33.sp),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          SizedBox(width: 10.w),
          Text(
            title,
            style: Styles.styles17w400interFamily,
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              onLanguageChange(false);
              // context.read<LocaleCubit>().changeLanguage('ar');
            },
            child: Container(
              width: 70.w,
              height: 35.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.r),
                color:
                    isEn ? Colors.white : const Color.fromRGBO(0, 126, 143, 1),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Center(
                child: Text(
                  "عربي",
                  style: isEn
                      ? Styles.styles11w600Black
                      : Styles.styles11w600White,
                ),
              ),
            ),
          ),
          SizedBox(width: 5.w),
          GestureDetector(
            onTap: () {
              onLanguageChange(true);
              // context.read<LocaleCubit>().changeLanguage('en');
            },
            child: Container(
              width: 70.w,
              height: 35.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.r),
                color:
                    isEn ? const Color.fromRGBO(0, 126, 143, 1) : Colors.white,
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Center(
                child: Text(
                  "En",
                  style: isEn
                      ? Styles.styles11w600White
                      : Styles.styles11w600Black,
                ),
              ),
            ),
          ),
        ],
      ),
      toolbarHeight: 30.h,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(30.h);
}
