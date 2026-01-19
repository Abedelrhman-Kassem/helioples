import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/return_arrow.dart';
import 'package:negmt_heliopolis/generated/locale_keys.g.dart';

class ReportAppBar extends StatelessWidget {
  const ReportAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        returnArrow(
          context: context,
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        SizedBox(width: 90.w),
        Text(
          LocaleKeys.report_screen_report_an_issue.tr(),
          style: Styles.styles16w400Black,
        ),
      ],
    );
  }
}
