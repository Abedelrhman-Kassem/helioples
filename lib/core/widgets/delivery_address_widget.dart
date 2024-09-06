import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/svg_asset.dart';

Widget deliveryAddressWidget({
  required String title,
  required String addressTitleRadioValue,
  required String location,
  required void Function() onTap,
}) {
  return SizedBox(
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: const Color.fromRGBO(248, 147, 31, .1),
        onTap: onTap,
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              svgIcon(
                path: 'assets/svg_icons/location.svg',
                width: 21.w,
                height: 21.h,
                color: const Color.fromRGBO(71, 71, 71, 1),
              ),
              SizedBox(width: 10.w),
              SizedBox(
                width: 240.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: Styles.styles16w400NormalBlack,
                    ),
                    Text(
                      // i want the width of this text or the parent column become 80% of availbe space or 100% - 20
                      location,
                      style: Styles.styles12w400black,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              )
            ],
          ),
          trailing: AnimatedContainer(
            width: 17.w,
            height: 17.h,
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              shape: BoxShape.circle, // To make it look like a radio button
              border: Border.all(
                color:
                    addressTitleRadioValue.toLowerCase() == title.toLowerCase()
                        ? const Color.fromRGBO(248, 147, 31, 1)
                        : const Color.fromRGBO(150, 150, 150, 1),
                width: 0.88.r,
              ),
            ),
            child: Align(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 6.38.w,
                height: 6.38.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: addressTitleRadioValue.toLowerCase() ==
                          title.toLowerCase()
                      ? const Color.fromRGBO(248, 147, 31, 1)
                      : Colors.transparent,
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
