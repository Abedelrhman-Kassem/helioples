import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/radio_animated_widget.dart';
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
                      location,
                      style: Styles.styles12w400black,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              )
            ],
          ),
          trailing: radioAnimatedWidget(
            addressTitleRadioValue.toLowerCase() == title.toLowerCase(),
          ),
        ),
      ),
    ),
  );
}
