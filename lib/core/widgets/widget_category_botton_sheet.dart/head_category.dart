import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/svg_asset.dart';

class HeadCategory extends StatelessWidget {
  const HeadCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Categories',
          style: Styles.styles15w700NormalBlack,
        ),
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: svgIcon(
            path: 'assets/svg_icons/x-close.svg',
            width: 20.w,
            height: 20.h,
            color: Colors.black.withValues(alpha: 0.5),
          ),
        ),
      ],
    );
  }
}
