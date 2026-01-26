import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';

class SignUpCustomButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onPressed;
  final Color? buttonColor;
  final Color? textColor;

  const SignUpCustomButton({
    super.key,
    required this.buttonText,
    this.onPressed,
    this.buttonColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320.w,
      height: 60.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.r),
        color:
            buttonColor ??
            const Color.fromRGBO(0, 126, 143, 1), // Default button color
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(30.r),
          onTap: onPressed,
          child: Center(
            child: Text(
              buttonText,
              style: Styles.styles17w500MainColor.copyWith(
                color: textColor ?? Colors.white,
              ), // Default text color
            ),
          ),
        ),
      ),
    );
  }
}
