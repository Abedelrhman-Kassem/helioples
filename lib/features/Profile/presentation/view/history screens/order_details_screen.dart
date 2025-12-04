import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_service.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/return_arrow.dart';
import 'package:negmt_heliopolis/features/Profile/data/model/order.dart';
import 'package:negmt_heliopolis/features/Profile/data/model/order_details.dart';
import 'package:negmt_heliopolis/features/Profile/data/repo/order%20history%20repo/order_history_repo_imp.dart';
import 'package:negmt_heliopolis/features/Profile/presentation/view/Widgets/dotted_line.dart';
import 'package:negmt_heliopolis/features/Profile/presentation/view/Widgets/invoice_item.dart';
import 'package:negmt_heliopolis/features/Profile/presentation/view/Widgets/order_states.dart';
import 'package:negmt_heliopolis/features/Profile/presentation/view_model/history%20cubit/history_cubit.dart';
import 'package:negmt_heliopolis/features/Profile/presentation/view_model/history%20cubit/history_states.dart';
import 'package:negmt_heliopolis/generated/locale_keys.g.dart';

class OrderDetailsScreen extends StatelessWidget {
  final Order order;
  const OrderDetailsScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) =>
            OrderDetailsCubit(OrderHistoryRepoImp(api: ApiService()))
              ..getOrderDetails(order.id!),
        child: BlocBuilder<OrderDetailsCubit, FetchOrderState>(
          builder: (context, state) {
            if (state is FetchOrderFailure) {
              return Center(
                  child: Text(
                      "${LocaleKeys.order_details_screen_something_went_wrong.tr()} ${state.msg}"));
            } else if (state is FetchOrderLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is FetchOrderSuccess) {
              OrderDetails orderDetails = state.orderDetails;
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsetsDirectional.only(
                      start: 16.w, end: 16.w, top: 60.h, bottom: 20.h),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          returnArrow(
                            context: context,
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          SizedBox(width: 100.w),
                          Text(
                            LocaleKeys.order_details_screen_order_details.tr(),
                            style: Styles.styles16w400grey
                                .copyWith(color: Colors.black),
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
                          border: Border.all(
                              color: const Color.fromRGBO(227, 227, 227, 1)),
                        ),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(
                              top: 16, start: 16, end: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                order.id.toString(),
                                style: Styles.styles16w500Black36
                                    .copyWith(fontSize: 18.sp),
                              ),
                              SizedBox(height: 16.h),
                              OrderStatusWidget(
                                iconPath:
                                    "assets/svg_icons/order_confirmation_icon.svg",
                                title: LocaleKeys
                                    .order_details_screen_order_confirmed
                                    .tr(),
                                date: "10 Dec 2023, 04:25 PM",
                                isDone: true,
                              ),
                              SizedBox(height: 20.h),
                              OrderStatusWidget(
                                iconPath:
                                    "assets/svg_icons/order_shipped_icon.svg",
                                title: LocaleKeys
                                    .order_details_screen_order_prepared
                                    .tr(),
                                date: "11 Dec 2023, 05:00 AM",
                                isDone: false,
                              ),
                              SizedBox(height: 20.h),
                              OrderStatusWidget(
                                iconPath:
                                    "assets/svg_icons/order_dliverd_icon.svg",
                                title: LocaleKeys.order_details_screen_picked_up
                                    .tr(),
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
                          border: Border.all(
                              color: const Color.fromRGBO(227, 227, 227, 1)),
                        ),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(
                              top: 16, start: 16, end: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                LocaleKeys.order_details_screen_order_details
                                    .tr(),
                                style: Styles.styles16w500Black36
                                    .copyWith(fontSize: 18.sp),
                              ),
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: orderDetails.items!.length,
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
                                          "${orderDetails.items![index].number}X",
                                          style: Styles.styles14w500interFamily,
                                        ),
                                        SizedBox(width: 6.w),
                                        Text(
                                          "${orderDetails.items![index].product!.name}",
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
                          border: Border.all(
                              color: const Color.fromRGBO(227, 227, 227, 1)),
                        ),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(
                              top: 16, start: 16, end: 16, bottom: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                LocaleKeys.order_details_screen_order_invoice
                                    .tr(),
                                style: Styles.styles16w500Black36
                                    .copyWith(fontSize: 18.sp),
                              ),
                              SizedBox(height: 12.h),
                              InvoiceItem(
                                title: LocaleKeys.order_details_screen_sub_total
                                    .tr(),
                                value: "\$${order.subTotal}",
                              ),
                              SizedBox(height: 8.h),
                              InvoiceItem(
                                title: LocaleKeys.order_details_screen_vat.tr(),
                                value: "\$${order.vat}",
                              ),
                              SizedBox(height: 8.h),
                              InvoiceItem(
                                title: LocaleKeys
                                    .order_details_screen_delivery_fees
                                    .tr(),
                                value: "\$${order.deliveryFees}",
                              ),
                              SizedBox(height: 8.h),
                              InvoiceItem(
                                title: LocaleKeys
                                    .order_details_screen_promocode_discount
                                    .tr(),
                                value: "\$${order.promoCodeDiscount}",
                              ),
                              SizedBox(height: 8.h),
                              InvoiceItem(
                                title:
                                    LocaleKeys.order_details_screen_wallet.tr(),
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
                                title:
                                    LocaleKeys.order_details_screen_total.tr(),
                                value: "\$${orderDetails.total}",
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
            return const SizedBox(); // Default empty widget
          },
        ),
      ),
    );
  }
}
