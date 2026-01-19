import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/features/Profile/presentation/view/Widgets/dotted_line.dart';
import 'package:negmt_heliopolis/features/Profile/presentation/view/Widgets/invoice_item.dart';
import 'package:negmt_heliopolis/features/Profile/presentation/view/Widgets/order_states.dart';
import 'package:negmt_heliopolis/generated/locale_keys.g.dart';
import 'package:skeletonizer/skeletonizer.dart';

Widget loadingOrderDetails() {
  return Skeletonizer(
    enabled: true,
    child: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 30.h),
          Container(
            width: 380.w,
            height: 280.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.r),
              border: Border.all(color: const Color.fromRGBO(227, 227, 227, 1)),
            ),
            child: Padding(
              padding: const EdgeInsetsDirectional.only(
                top: 16,
                start: 16,
                end: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "#123456789",
                    style: Styles.styles16w500Black36.copyWith(fontSize: 18.sp),
                  ),
                  SizedBox(height: 16.h),
                  OrderStatusWidget(
                    iconPath: "assets/svg_icons/order_confirmation_icon.svg",
                    title: LocaleKeys.order_details_screen_order_confirmed.tr(),
                    date: "10 Dec 2023, 04:25 PM",
                  ),
                  SizedBox(height: 20.h),
                  OrderStatusWidget(
                    iconPath: "assets/svg_icons/order_shipped_icon.svg",
                    title: LocaleKeys.order_details_screen_order_prepared.tr(),
                    date: "11 Dec 2023, 05:00 AM",
                    isDone: false,
                  ),
                  SizedBox(height: 20.h),
                  OrderStatusWidget(
                    iconPath: "assets/svg_icons/order_dliverd_icon.svg",
                    title: LocaleKeys.order_details_screen_picked_up.tr(),
                    date: "Expected 11 Dec 2023, 06:50 AM ",
                    isDone: false,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 25.h),
          Container(
            width: 380.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.r),
              border: Border.all(color: const Color.fromRGBO(227, 227, 227, 1)),
            ),
            child: Padding(
              padding: const EdgeInsetsDirectional.only(
                top: 16,
                start: 16,
                end: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.order_details_screen_order_details.tr(),
                    style: Styles.styles16w500Black36.copyWith(fontSize: 18.sp),
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsetsDirectional.only(
                          start: 0,
                          bottom: 12,
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 50.w,
                              height: 50.h,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Text("3X", style: Styles.styles14w500interFamily),
                            SizedBox(width: 6.w),
                            Text(
                              "Water Bottle",
                              style: Styles.styles14w500interBlack36.copyWith(
                                fontSize: 15.sp,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 25.h),
          Container(
            width: 380.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.r),
              border: Border.all(color: const Color.fromRGBO(227, 227, 227, 1)),
            ),
            child: Padding(
              padding: const EdgeInsetsDirectional.only(
                top: 16,
                start: 16,
                end: 16,
                bottom: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.order_details_screen_order_invoice.tr(),
                    style: Styles.styles16w500Black36.copyWith(fontSize: 18.sp),
                  ),
                  SizedBox(height: 12.h),
                  InvoiceItem(
                    title: LocaleKeys.order_details_screen_sub_total.tr(),
                    value: "\$12.00",
                  ),
                  SizedBox(height: 8.h),
                  InvoiceItem(
                    title: LocaleKeys.order_details_screen_vat.tr(),
                    value: "\$12.00",
                  ),
                  SizedBox(height: 8.h),
                  InvoiceItem(
                    title: LocaleKeys.order_details_screen_delivery_fees.tr(),
                    value: "\$12.00",
                  ),
                  SizedBox(height: 8.h),
                  InvoiceItem(
                    title: LocaleKeys.order_details_screen_promocode_discount
                        .tr(),
                    value: "\$12.00",
                  ),
                  SizedBox(height: 8.h),
                  InvoiceItem(
                    title: LocaleKeys.order_details_screen_wallet.tr(),
                    value: "\$12.00",
                  ),
                  SizedBox(height: 8.h),
                  const DottedLine(
                    color: Color.fromRGBO(0, 0, 0, 0.7),
                    dotWidth: 11.0,
                    spacing: 8.0,
                    height: 0.5,
                  ),
                  SizedBox(height: 8.h),
                  InvoiceItem(
                    title: LocaleKeys.order_details_screen_total.tr(),
                    value: "\$12.00",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
