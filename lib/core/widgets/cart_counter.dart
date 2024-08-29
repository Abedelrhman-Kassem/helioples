import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/svg_asset.dart';

Widget cartCounter({required BuildContext context, int counter = 3}) {
  return IconButton(
    onPressed: () {
      Navigator.pushNamed(context, cartScreen);
    },
    icon: Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: SizedBox(
        width: 40.w,
        height: 50.h,
        child: Stack(
          children: [
            Positioned(
              top: 10.h,
              child: GestureDetector(
                onTap: () {},
                child: svgIcon(
                  path: 'assets/svg_icons/favorite-Cart.svg',
                  width: 35.w,
                  height: 35.h,
                  color: const Color.fromRGBO(41, 45, 50, 1),
                ),
              ),
            ),
            Positioned(
              right: 5.w,
              top: 5.h,
              child: Container(
                height: 20.h,
                width: 20.w,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromRGBO(228, 144, 42, 1),
                ),
                child: Center(
                  child: Text(
                    "$counter",
                    style: Styles.styles11w600White.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
