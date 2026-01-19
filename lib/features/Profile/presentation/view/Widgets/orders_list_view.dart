import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/constants/svg_path.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/features/Profile/data/model/order_history.dart';
import 'package:negmt_heliopolis/features/Profile/presentation/view/Widgets/get_formatted_date.dart';
import 'package:negmt_heliopolis/features/Profile/presentation/view/Widgets/history_shimmer_loading.dart';
import 'package:negmt_heliopolis/generated/locale_keys.g.dart';
import 'package:skeletonizer/skeletonizer.dart';

class OrdersListView extends StatelessWidget {
  final ScrollController scrollController;
  final List<ItemHistory> orderHistoryList;
  final bool isFetching;

  const OrdersListView({
    super.key,
    required this.scrollController,
    required this.orderHistoryList,
    required this.isFetching,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      itemCount: orderHistoryList.length + 1,
      itemBuilder: (context, index) {
        if (index == orderHistoryList.length) {
          return isFetching
              ? Skeletonizer(
                  enabled: true,
                  child: Skeletonizer(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return const HistoryItemShimmer();
                      },
                    ),
                  ),
                )
              : const SizedBox.shrink();
        }

        var orderHistory = orderHistoryList[index];

        bool showHeader = false;
        if (index == 0) {
          showHeader = true;
        } else {
          var prevOrder = orderHistoryList[index - 1];
          if (prevOrder.createdAt != null && orderHistory.createdAt != null) {
            if (prevOrder.createdAt!.day != orderHistory.createdAt!.day ||
                prevOrder.createdAt!.month != orderHistory.createdAt!.month ||
                prevOrder.createdAt!.year != orderHistory.createdAt!.year) {
              showHeader = true;
            }
          } else if (prevOrder.createdAt != orderHistory.createdAt) {
            showHeader = true;
          }
        }

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 8.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (showHeader)
                Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: Text(
                    getFormattedDate(orderHistory.createdAt),
                    style: Styles.styles17w700interFamily.copyWith(
                      fontWeight: FontWeight.bold,
                      color: const Color.fromRGBO(80, 80, 80, 1),
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              SizedBox(height: 8.h),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.h),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          orderDetailsScreen,
                          arguments: {'id': orderHistory.id},
                        );
                      },
                      child: Container(
                        width: 400.w,
                        height: 140.h,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(227, 227, 227, 1),
                          borderRadius: BorderRadius.circular(30.r),
                          border: Border.all(
                            color: const Color.fromRGBO(243, 243, 243, 1),
                          ),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 15.w,
                                vertical: 15.h,
                              ),
                              child: orderHistory.deliverMethod == "Delivery"
                                  ? SvgPicture.asset(
                                      SvgPath.delivery,
                                      width: 60.w,
                                      height: 60.h,
                                    )
                                  : SvgPicture.asset(
                                      SvgPath.pickup,
                                      width: 60.w,
                                      height: 60.h,
                                    ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 20.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Row(
                                      spacing: 25.w,
                                      children: [
                                        SizedBox(
                                          width: 120.w,
                                          child: Text.rich(
                                            TextSpan(
                                              text:
                                                  "${orderHistory.itemsCount} ",
                                              style: Styles
                                                  .styles13w300interFamily
                                                  .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                              children: [
                                                TextSpan(
                                                  text: LocaleKeys
                                                      .comleted_order_screen_completed_order_screen_items
                                                      .tr(),
                                                  style: Styles
                                                      .styles13w300interFamily
                                                      .copyWith(
                                                        color:
                                                            const Color.fromRGBO(
                                                              80,
                                                              80,
                                                              80,
                                                              1,
                                                            ),
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "${orderHistory.total!.toStringAsFixed(2)} ${LocaleKeys.comleted_order_screen_completed_order_screen_egp.tr()}",
                                          style: Styles.styles17w700interFamily,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        "assets/svg_icons/location_history.svg",
                                      ),
                                      SizedBox(width: 6.w),
                                      Text(
                                        orderHistory.address!,
                                        style: Styles.styles12w400interFamily
                                            .copyWith(
                                              color: const Color.fromRGBO(
                                                80,
                                                80,
                                                80,
                                                1,
                                              ),
                                            ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8.h),
                                  Row(
                                    children: [
                                      // Image.asset(
                                      //   "assets/Icons_logos/logos_visa.png",
                                      // ),
                                      SizedBox(width: 6.w),
                                      Text(
                                        orderHistory.paymentMethod!,
                                        style: Styles.styles11w700interFamily
                                            .copyWith(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13.sp,
                                            ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
