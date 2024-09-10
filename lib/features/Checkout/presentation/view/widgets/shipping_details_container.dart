import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/widgets/shipping_details_item.dart';

Widget shippingDetailsContainer() {
  return Container(
    padding: EdgeInsets.all(20.r),
    margin: EdgeInsets.symmetric(vertical: 20.h),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.9),
      borderRadius: BorderRadius.circular(15.r),
    ),
    child: Column(
      children: [
        shippingDetailsItem(
          text: 'Preparing',
          iconPath: 'assets/svg_icons/box.svg',
          isLoading: true,
        ),
        SizedBox(height: 20.h),
        shippingDetailsItem(
          text: 'Arrived To Drop Location',
          iconPath: 'assets/svg_icons/truck-tick.svg',
          isLoading: false,
        ),
        SizedBox(height: 20.h),
        shippingDetailsItem(
          text: 'Delivered',
          iconPath: 'assets/svg_icons/box-tick.svg',
          isLoading: false,
        ),
      ],
    ),
  );
}
