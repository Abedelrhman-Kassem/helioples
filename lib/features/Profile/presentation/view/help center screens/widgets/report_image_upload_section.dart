import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/generated/locale_keys.g.dart';

class ReportImageUploadSection extends StatelessWidget {
  final File? selectedImage;
  final VoidCallback onTap;

  const ReportImageUploadSection({
    super.key,
    required this.selectedImage,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60.h,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(246, 246, 246, 1),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Row(
            children: [
              if (selectedImage != null) ...[
                Image.file(
                  selectedImage!,
                  width: 40.w,
                  height: 40.h,
                  fit: BoxFit.cover,
                ),
                SizedBox(width: 10.w),
              ],
              const Spacer(),
              Text(
                LocaleKeys.report_screen_upload.tr(),
                style: Styles.styles13w400interFamily.copyWith(
                  fontWeight: FontWeight.w500,
                  color: MyColors.mainColor,
                  fontSize: 15.sp,
                ),
              ),
              SizedBox(width: 8.w),
              Image.asset("assets/Icons_logos/gallery-export.png"),
            ],
          ),
        ),
      ),
    );
  }
}
