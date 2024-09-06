import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/widgets/svg_asset.dart';
import 'package:negmt_heliopolis/features/Home_layout/presentation/view_model/cubit/home_layout_cubit.dart';

GButton gButtonItem({
  required BuildContext context,
  required String activeSvgPath,
  required String outlinedSvgPath,
  required String text,
  required int index,
}) {
  return GButton(
    icon: Icons.access_alarm_rounded,
    iconColor: Colors.transparent,
    iconActiveColor: Colors.transparent,
    text: text,
    leading: BlocProvider.of<HomeLayoutCubit>(context).selectedIndex == index
        ? svgIcon(
            path: activeSvgPath,
            width: 24.w,
            height: 24.h,
            color: Colors.white,
          )
        : svgIcon(
            path: outlinedSvgPath,
            width: 24.w,
            height: 24.h,
            color: MyColors.mainColor,
          ),
  );
}
