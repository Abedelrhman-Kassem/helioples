import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
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
        ? SvgPicture.asset(
            activeSvgPath,
            colorFilter: const ColorFilter.mode(
              Colors.white,
              BlendMode.srcIn,
            ),
            width: 24.w,
            height: 24.h,
          )
        : SvgPicture.asset(
            outlinedSvgPath,
            colorFilter: ColorFilter.mode(
              MyColors.mainColor,
              BlendMode.srcIn,
            ),
            width: 24.w,
            height: 24.h,
          ),
  );
}
