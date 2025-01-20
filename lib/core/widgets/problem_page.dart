import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view/widgets/sign_up_custom_button.dart';

class InfoMessageWidget extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final String buttonText;
  final VoidCallback onPressed;

  const InfoMessageWidget({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 60.h,
        ),
        Center(
          child: Image.asset(
            imagePath,
          ),
        ),
        SizedBox(
          height: 30.h,
        ),
        Text(
          title,
          style: Styles.styles24w400Black.copyWith(fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 10.h,
        ),
        Text(
          description,
          textAlign: TextAlign.center,
          style: Styles.styles17w400interFamily,
        ),
        SizedBox(
          height: 40.h,
        ),
        SignUpCustomButton(buttonText: buttonText, onPressed: onPressed),
      ],
    );
  }
}
