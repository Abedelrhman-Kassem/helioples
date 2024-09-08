import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/return_arrow.dart';

class FaqsScreen extends StatelessWidget {
  const FaqsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
         padding: EdgeInsetsDirectional.only(
            start: 16.w, end: 16.w, top: 60.h, bottom: 10.h),
        child: Column(
          children: [
            Row(
              children: [
                returnArrow(context: context, onTap: (){
                  Navigator.of(context).pop();
                }),
                SizedBox(
                  width: 125.w,
                ),
                Text(
                  "FAQS",
                  style: Styles.styles16w400Black,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
