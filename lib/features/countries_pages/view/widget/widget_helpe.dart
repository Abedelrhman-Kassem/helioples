import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/return_arrow.dart';
import 'package:negmt_heliopolis/core/widgets/svg_asset.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view/widgets/sign_up_custom_button.dart';

class WidgetHelpe extends StatelessWidget {
  final String title;
  final String svgpath;
  final String titlebody;
  final String subtitlebody;
  final String buttontext;
  final bool showBackArrow;

  final void Function() onPressed;

  const WidgetHelpe({
    super.key,
    required this.title,
    required this.svgpath,
    required this.titlebody,
    required this.subtitlebody,
    required this.buttontext,
    required this.onPressed,
    this.showBackArrow = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 45.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (showBackArrow)
                  returnArrow(
                      context: context,
                      onTap: () {
                        Navigator.of(context).pop();
                      }),
                if (showBackArrow)
                  SizedBox(
                    width: 100.w,
                  ),
                Text(title)
              ],
            ),
            SizedBox(height: 100.h),
            Center(
              child: svgIcon(path: svgpath, width: 251.7.w, height: 254.89.h),
            ),
            SizedBox(height: 30.h),
            Text(
              titlebody,
              style: Styles.styles24w400Black
                  .copyWith(fontWeight: FontWeight.w800),
            ),
            Text(
              subtitlebody,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40.h),
            SignUpCustomButton(
              buttonText: buttontext,
              onPressed: onPressed,
            ),
          ],
        ),
      ),
    );
  }
}
