import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/features/Profile/presentation/view/Widgets/dotted_line.dart';
import 'package:negmt_heliopolis/features/Profile/presentation/view/Widgets/invoice_item.dart';
import 'package:negmt_heliopolis/features/Profile/presentation/view/Widgets/order_states.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsDirectional.only(
            start: 16.w,
            end: 16.w,
            top: 60.h,
            bottom: 20.h
          ),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                  SizedBox(width: 100.w),
                  Text(
                    "Order Details",
                    style:
                        Styles.styles16w400grey.copyWith(color: Colors.black),
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              Container(
                width: 380.w,
                height: 280.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.r),
                  border:
                      Border.all(color: const Color.fromRGBO(227, 227, 227, 1)),
                ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(
                      top: 16, start: 16, end: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Order #LDR0215AA1",
                        style: Styles.styles16w500Black36
                            .copyWith(fontSize: 18.sp),
                      ),
                      SizedBox(height: 16.h),
                      const OrderStatusWidget(
                        iconPath:
                            "assets/svg_icons/order_confirmation_icon.svg",
                        title: "Order Confirmed",
                        date: "10 Dec 2023, 04:25 PM",
                        isDone: true,
                      ),
                      SizedBox(height: 20.h),
                      const OrderStatusWidget(
                        iconPath: "assets/svg_icons/order_shipped_icon.svg",
                        title: "Order Prepared",
                        date: "11 Dec 2023, 05:00 AM",
                        isDone: false,
                      ),
                      SizedBox(height: 20.h),
                      const OrderStatusWidget(
                        iconPath: "assets/svg_icons/order_dliverd_icon.svg",
                        title: "Picked Up",
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
                  border:
                      Border.all(color: const Color.fromRGBO(227, 227, 227, 1)),
                ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(
                      top: 16, start: 16, end: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Order Details",
                        style: Styles.styles16w500Black36
                            .copyWith(fontSize: 18.sp),
                      ),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 2,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsetsDirectional.only(
                                start: 0, bottom: 12),
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/Icons_logos/Butter Croissant.png",
                                  width: 30.w,
                                  height: 32.h,
                                ),
                                SizedBox(width: 12.w),
                                Text(
                                  "3 X",
                                  style: Styles.styles14w500interFamily,
                                ),
                                SizedBox(
                                  width: 6.w,
                                ),
                                Text(
                                  "Butter Croissant",
                                  style: Styles.styles14w500interBlack36
                                      .copyWith(fontSize: 15.sp),
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
                  border:
                      Border.all(color: const Color.fromRGBO(227, 227, 227, 1)),
                ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(
                      top: 16, start: 16, end: 16 , bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Order Invoice ",
                        style: Styles.styles16w500Black36
                            .copyWith(fontSize: 18.sp),
                      ),
                      SizedBox(height: 12.h),
                      const InvoiceItem(
                        title: "Sub Total",
                        value: "\$25.50",
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      const InvoiceItem(
                        title: "Vat",
                        value: "\$24.00",
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      const InvoiceItem(
                        title: "Delivery Fees",
                        value: "\$6.00",
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      const InvoiceItem(
                        title: "Promocode Discount",
                        value: "\$12.00",
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      const InvoiceItem(
                        title: "Wallet",
                        value: "\$12.00",
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      const DottedLine(color: const  Color.fromRGBO(0, 0, 0, 0.7), dotWidth: 11.0, spacing: 8.0 ,height: 0.5,),
                       SizedBox(
                        height: 8.h,
                       ),
                      const InvoiceItem(
                        title: "Total",
                        value: "\$79.50",
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
