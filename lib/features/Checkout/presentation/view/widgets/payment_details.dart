import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view_model/create_order_cubit/create_order_cubit.dart';

Widget paymentDetails() {
  return BlocConsumer<CreateOrderCubit, CreateOrderState>(
    listener: (context, state) {
      if (state is CheckPromoCodeSuccess) {
        print(state.promoCodeModel.promoCode!.name);
      }
    },
    builder: (context, state) {
      return Container(
        padding: EdgeInsets.all(20.r),
        margin: EdgeInsets.only(top: 10.h),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Sub Total (4 Items)',
                  style: Styles.styles14w400Black,
                ),
                Text(
                  '300.00 EGP',
                  style: Styles.styles15w600NormalBlack,
                ),
              ],
            ),
            SizedBox(height: 15.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Promocode Discount',
                  style: Styles.styles14w400Black,
                ),
                Text(
                  '120.00 EGP',
                  style: Styles.styles15w600NormalBlack,
                ),
              ],
            ),
            SizedBox(height: 15.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Delivery fees',
                  style: Styles.styles14w400Black,
                ),
                Text(
                  '120 EGP',
                  style: Styles.styles15w600NormalBlack,
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
