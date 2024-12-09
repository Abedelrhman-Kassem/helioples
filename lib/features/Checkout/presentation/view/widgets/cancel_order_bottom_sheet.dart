import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/button_widget.dart';
import 'package:negmt_heliopolis/core/widgets/custom_snack_bar.dart';
import 'package:negmt_heliopolis/core/widgets/radio_animated_widget.dart';
import 'package:negmt_heliopolis/features/Checkout/data/model/order_details_model.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view_model/create_order_cubit/create_order_cubit.dart';

Widget cancelOrderBottomSheet(BuildContext context, OrderDetailsModel order) {
  return Wrap(
    children: [
      Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: Column(
          children: [
            Text(
              'Order Cancellation',
              style: Styles.styles20w600Black,
            ),
            SizedBox(height: 10.h),
            Text(
              'Are you sure you want to cancel this order?',
              style: Styles.styles17w400interFamily,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 25.h),
            Row(
              children: [
                Expanded(
                  child: buttonWidget(
                    color: MyColors.mainColor,
                    padding: EdgeInsets.symmetric(
                      vertical: 20.h,
                    ),
                    borderRadius: 53.r,
                    child: Text(
                      'Cancel Order',
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
                    padding: EdgeInsets.symmetric(
                      vertical: 20.h,
                    ),
                    borderRadius: 53.r,
                    border: Border.all(
                      color: MyColors.mainColor,
                      width: 1.5.r,
                    ),
                    child: Text(
                      "Don't Cancel",
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

class ReasonBottomSheet extends StatefulWidget {
  final OrderDetailsModel order;
  const ReasonBottomSheet({
    super.key,
    required this.order,
  });

  @override
  State<ReasonBottomSheet> createState() => _ReasonBottomSheetState();
}

class _ReasonBottomSheetState extends State<ReasonBottomSheet> {
  List<String>? reasonsList;

  late String radioValue;

  @override
  void initState() {
    reasonsList = [
      'Just changed my mind.',
      'I placed the order by mistake',
      'I need to modify orders products',
      'I need to change delivery address',
      'I need to change payment method',
      'Other',
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
            if (widget.order.order!.deliverMethod == 'Delivery') {
              Navigator.pushNamed(
                context,
                reOrderScreen,
              );
            } else {
              Navigator.pushNamed(
                context,
                reOrderScreen,
              );
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
                      'Help Us understanding the reason beyond cancellation',
                      style: Styles.styles16w600NormalBlack.copyWith(
                        color: const Color.fromRGBO(41, 41, 41, 1),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Column(
                      children: List.generate(
                        reasonsList!.length,
                        (index) {
                          return reasonItem(
                            radioValue: radioValue,
                            itemText: reasonsList![index],
                            onTap: () {
                              setState(() {
                                radioValue = reasonsList![index];
                              });
                            },
                          );
                        },
                      ),
                    ),
                    buttonWidget(
                      color: MyColors.mainColor,
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      margin: EdgeInsets.only(top: 20.h),
                      borderRadius: 37.r,
                      child: Text(
                        'Submit',
                        style: Styles.styles17w500NormalWhite,
                      ),
                      onTap: () {
                        BlocProvider.of<CreateOrderCubit>(context)
                            .cancelOrder(radioValue, widget.order.order!.id!);
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
          Text(
            itemText,
            style: Styles.styles16w400Black41,
          ),
        ],
      ),
    ),
  );
}
