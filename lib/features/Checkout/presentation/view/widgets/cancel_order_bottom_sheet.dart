import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/helper.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/button_widget.dart';
import 'package:negmt_heliopolis/core/widgets/custom_snack_bar.dart';
import 'package:negmt_heliopolis/core/widgets/radio_animated_widget.dart';
import 'package:negmt_heliopolis/features/Checkout/data/model/order_details_model.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view_model/create_order_cubit/create_order_cubit.dart';
import 'package:negmt_heliopolis/generated/locale_keys.g.dart';

Widget cancelOrderBottomSheet(BuildContext context, OrderDetailsModel order) {
  return Wrap(
    children: [
      Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.r)),
        child: Column(
          children: [
            Text(
              LocaleKeys.cancel_order_bottom_sheet_order_cancellation.tr(),
              style: Styles.styles20w600Black,
            ),
            SizedBox(height: 10.h),
            Text(
              LocaleKeys.cancel_order_bottom_sheet_cancel_order_confirmation
                  .tr(),
              style: Styles.styles17w400interFamily,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 25.h),
            Row(
              children: [
                Expanded(
                  child: buttonWidget(
                    color: MyColors.mainColor,
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    borderRadius: 53.r,
                    child: Text(
                      LocaleKeys.cancel_order_bottom_sheet_cancel_order.tr(),
                      style: Styles.styles17w600White,
                    ),
                    onTap: () async {
                      return showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return ReasonBottomSheet(order: order);
                        },
                      );
                    },
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: buttonWidget(
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    borderRadius: 53.r,
                    border: Border.all(color: MyColors.mainColor, width: 1.5.r),
                    child: Text(
                      LocaleKeys.cancel_order_bottom_sheet_dont_cancel.tr(),
                      style: Styles.styles17w600White.copyWith(
                        color: MyColors.mainColor,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

// ignore: must_be_immutable
class ReasonBottomSheet extends StatefulWidget {
  final OrderDetailsModel order;
  const ReasonBottomSheet({super.key, required this.order});

  @override
  State<ReasonBottomSheet> createState() => _ReasonBottomSheetState();
}

class _ReasonBottomSheetState extends State<ReasonBottomSheet> {
  List<String>? reasonsList;

  late String radioValue;

  @override
  void initState() {
    reasonsList = [
      LocaleKeys.cancel_order_bottom_sheet_reason_just_changed.tr(),
      LocaleKeys.cancel_order_bottom_sheet_reason_placed_by_mistake.tr(),
      LocaleKeys.cancel_order_bottom_sheet_reason_modify_products.tr(),
      LocaleKeys.cancel_order_bottom_sheet_reason_change_address.tr(),
      LocaleKeys.cancel_order_bottom_sheet_reason_change_payment.tr(),
      LocaleKeys.cancel_order_bottom_sheet_reason_other.tr(),
    ];

    radioValue = reasonsList![0];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateOrderCubit(),
      child: BlocConsumer<CreateOrderCubit, CreateOrderState>(
        listener: (context, state) {
          if (state is CancelOrderFailed) {
            CustomSnackBar.show(
              context: context,
              duration: const Duration(seconds: 10),
              text: state.error,
              isGreen: false,
            );
          }

          if (state is CancelOrderSuccess) {
            // showCustomGetSnack(
            //   isGreen: true,
            //   text: state.cancelOrderModel.msg!,
            // );
            if (widget.order.data!.deliverMethod == 'Delivery') {
              Navigator.pushNamed(context, reOrderScreen);
            } else {
              Navigator.pushNamed(context, pickupReorderScreen);
            }
          }
        },
        builder: (context, state) {
          return Wrap(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Column(
                  children: [
                    Text(
                      LocaleKeys.cancel_order_bottom_sheet_help_us_reason.tr(),
                      style: Styles.styles16w600NormalBlack.copyWith(
                        color: const Color.fromRGBO(41, 41, 41, 1),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Column(
                      children: List.generate(reasonsList!.length, (index) {
                        return reasonItem(
                          radioValue: radioValue,
                          itemText: reasonsList![index],
                          onTap: () {
                            setState(() {
                              radioValue = reasonsList![index];
                            });
                          },
                        );
                      }),
                    ),
                    state is CancelOrderLoading
                        ? Container(
                            height: 60.h,
                            width: double.infinity,
                            margin: EdgeInsets.only(top: 20.h),
                            decoration: BoxDecoration(
                              color: MyColors.mainColor,
                              borderRadius: BorderRadius.circular(37.r),
                            ),
                            child: Center(
                              child: Helper.loadingWidget(color: Colors.white),
                            ),
                          )
                        : buttonWidget(
                            color: MyColors.mainColor,
                            padding: EdgeInsets.symmetric(vertical: 20.h),
                            margin: EdgeInsets.only(top: 20.h),
                            borderRadius: 37.r,
                            child: Text(
                              LocaleKeys.cancel_order_bottom_sheet_submit.tr(),
                              style: Styles.styles17w500NormalWhite,
                            ),
                            onTap: () {
                              BlocProvider.of<CreateOrderCubit>(
                                context,
                              ).cancelOrder(radioValue, widget.order.data!.id!);
                            },
                          ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

Widget reasonItem({
  required String radioValue,
  required String itemText,
  required void Function() onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        children: [
          radioAnimatedWidget(radioValue == itemText),
          SizedBox(width: 5.w),
          Text(itemText, style: Styles.styles16w400Black41),
        ],
      ),
    ),
  );
}
