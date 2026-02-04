import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/helper.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/return_arrow.dart';
import 'package:negmt_heliopolis/features/Profile/data/repo/order%20history%20repo/order_history_repo_imp.dart';
import 'package:negmt_heliopolis/features/Profile/presentation/view/Widgets/dotted_line.dart';
import 'package:negmt_heliopolis/features/Profile/presentation/view/Widgets/invoice_item.dart';
import 'package:negmt_heliopolis/features/Profile/presentation/view/Widgets/loading_order_details.dart';
import 'package:negmt_heliopolis/features/Profile/presentation/view/Widgets/order_states.dart';
import 'package:negmt_heliopolis/features/Profile/presentation/view_model/history%20cubit/history_cubit.dart';
import 'package:negmt_heliopolis/features/Profile/presentation/view_model/history%20cubit/history_states.dart';
import 'package:negmt_heliopolis/generated/locale_keys.g.dart';

class OrderDetailsScreen extends StatelessWidget {
  final String id;
  const OrderDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) =>
            OrderDetailsCubit(OrderHistoryRepoImp(api: Get.find()))
              ..getOrderDetails(id),
        child: Padding(
          padding: EdgeInsetsDirectional.only(
            start: 16.w,
            end: 16.w,
            top: 60.h,
            bottom: 20.h,
          ),
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
                    style: Styles.styles16w400grey.copyWith(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: BlocBuilder<OrderDetailsCubit, OrderDetailsState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      orElse: () => Center(
                        child: Text(
                          LocaleKeys.order_details_screen_something_went_wrong
                              .tr(),
                        ),
                      ),
                      failure: (msg) => Center(
                        child: Text(
                          "${LocaleKeys.order_details_screen_something_went_wrong.tr()} $msg",
                        ),
                      ),
                      loading: () => loadingOrderDetails(),
                      success: (orderDetails) {
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(height: 30.h),
                              Container(
                                width: 380.w,
                                height: 280.h,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15.r),
                                  border: Border.all(
                                    color: const Color.fromRGBO(
                                      227,
                                      227,
                                      227,
                                      1,
                                    ),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                    top: 16,
                                    start: 16,
                                    end: 16,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        orderDetails.data!.orderNumber
                                            .toString(),
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
                                        title: LocaleKeys
                                            .order_details_screen_picked_up
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
                                    color: const Color.fromRGBO(
                                      227,
                                      227,
                                      227,
                                      1,
                                    ),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                    top: 16,
                                    start: 16,
                                    end: 16,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        LocaleKeys
                                            .order_details_screen_order_details
                                            .tr(),
                                        style: Styles.styles16w500Black36
                                            .copyWith(fontSize: 18.sp),
                                      ),
                                      ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount:
                                            orderDetails.data!.items.length,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                context,
                                                productScreen,
                                                arguments: {
                                                  'productId': orderDetails
                                                      .data!
                                                      .items[index]
                                                      .productId,
                                                  'isFromNoti': true,
                                                },
                                              );
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsetsDirectional.only(
                                                    start: 0,
                                                    bottom: 12,
                                                  ),
                                              child: Row(
                                                children: [
                                                  Helper.loadNetworkImage(
                                                    url:
                                                        orderDetails
                                                            .data!
                                                            .items[index]
                                                            .thumbnailImage ??
                                                        "",

                                                    assetsErrorPath:
                                                        'assets/test_images/water-bottle.png',
                                                    fit: BoxFit.contain,
                                                    width: 50.w,
                                                    imageHeight: 50.h,
                                                  ),
                                                  SizedBox(width: 12.w),
                                                  Text(
                                                    "${orderDetails.data!.items[index].number}X",
                                                    style: Styles
                                                        .styles14w500interFamily,
                                                  ),
                                                  SizedBox(width: 6.w),
                                                  Text(
                                                    "${orderDetails.data!.items[index].product}",
                                                    style: Styles
                                                        .styles14w500interBlack36
                                                        .copyWith(
                                                          fontSize: 15.sp,
                                                        ),
                                                  ),
                                                ],
                                              ),
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
                                    color: const Color.fromRGBO(
                                      227,
                                      227,
                                      227,
                                      1,
                                    ),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                    top: 16,
                                    start: 16,
                                    end: 16,
                                    bottom: 10,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        LocaleKeys
                                            .order_details_screen_order_invoice
                                            .tr(),
                                        style: Styles.styles16w500Black36
                                            .copyWith(fontSize: 18.sp),
                                      ),
                                      SizedBox(height: 12.h),
                                      InvoiceItem(
                                        title: LocaleKeys
                                            .order_details_screen_sub_total
                                            .tr(),
                                        value: "",
                                        trailing: RichText(
                                          text: Helper.priceSpan(
                                            orderDetails.data!.subTotal!,
                                            Styles.styles16w500Black36,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 8.h),
                                      InvoiceItem(
                                        title: LocaleKeys
                                            .order_details_screen_vat
                                            .tr(),
                                        value: "",
                                        trailing: RichText(
                                          text: Helper.priceSpan(
                                            orderDetails.data!.vat!,
                                            Styles.styles16w500Black36,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 8.h),
                                      InvoiceItem(
                                        title: LocaleKeys
                                            .order_details_screen_delivery_fees
                                            .tr(),
                                        value: "",
                                        trailing: RichText(
                                          text: Helper.priceSpan(
                                            orderDetails.data!.deliveryFees!,
                                            Styles.styles16w500Black36,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 8.h),
                                      InvoiceItem(
                                        title: LocaleKeys
                                            .order_details_screen_promocode_discount
                                            .tr(),
                                        value: "",
                                        trailing: RichText(
                                          text: Helper.priceSpan(
                                            orderDetails
                                                .data!
                                                .promoCodeDiscount!,
                                            Styles.styles16w500Black36,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 8.h),
                                      InvoiceItem(
                                        title: LocaleKeys
                                            .order_details_screen_wallet
                                            .tr(),
                                        value: "",
                                        trailing: RichText(
                                          text: Helper.priceSpan(
                                            0,
                                            Styles.styles16w500Black36,
                                          ),
                                        ),
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
                                        title: LocaleKeys
                                            .order_details_screen_total
                                            .tr(),
                                        value: "",
                                        trailing: RichText(
                                          text: Helper.priceSpan(
                                            orderDetails.data!.total!,
                                            Styles.styles17w700interFamily,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
