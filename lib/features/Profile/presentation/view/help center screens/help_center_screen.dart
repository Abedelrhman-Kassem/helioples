import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/return_arrow.dart';
import 'package:negmt_heliopolis/features/Profile/presentation/view/Widgets/help_center_widget.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

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
                  width: 100.w,
                ),
                Text(
                  "Help Center",
                  style: Styles.styles16w400Black,
                )
              ],
            ),
            SizedBox(
              height: 25.h,
            ),
            HelpCenterWidget(
              title: "Report An Issue",
              onTap: () {
                Navigator.of(context).pushNamed(reportScreen);
              },
            ),
            SizedBox(
              height: 15.h,
            ),
            HelpCenterWidget(
              title: "FAQS",
              onTap: () {
                Navigator.of(context).pushNamed(faqsScreen);
              },
            ),
            SizedBox(
              height: 15.h,
            ),
            HelpCenterWidget(
              title: "Call Us",
              onTap: () {},
            )
          ],
        ),
      ),
    );
  }
}
