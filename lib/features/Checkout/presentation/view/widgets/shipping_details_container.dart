import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/features/Checkout/data/model/order_details_model.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/widgets/shipping_details_item.dart';

Widget shippingDetailsContainer(OrderDetailsModel order) {
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
          isLoading: order.order!.clientOrderState! == 'Pending',
          isSuccess: order.order!.clientOrderState! == 'OnWay' ||
              order.order!.clientOrderState! == 'Shipped',
          date: '10 Dec 04:25 PM, ',
        ),
        SizedBox(height: 20.h),
        shippingDetailsItem(
          text: 'Arrived To Drop Location',
          iconPath: 'assets/svg_icons/truck-tick.svg',
          isLoading: order.order!.clientOrderState! == 'OnWay',
          isSuccess: order.order!.clientOrderState! == 'Shipped',
          date: '10 Dec 04:25 PM, ',
        ),
        SizedBox(height: 20.h),
        shippingDetailsItem(
          text: 'Delivered',
          iconPath: 'assets/svg_icons/box-tick.svg',
          isLoading: false,
          isSuccess: order.order!.clientOrderState! == 'Shipped',
          date: '10 Dec 04:25 PM, ',
        ),
      ],
    ),
  );
}
