import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/notifiers/db_change_notifier.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/features/Checkout/data/model/create_order_model.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view_model/create_order_cubit/create_order_cubit.dart';
import 'package:negmt_heliopolis/generated/locale_keys.g.dart';

class PaymentDetails extends StatefulWidget {
  final CreateOrderModel createOrderModel;
  const PaymentDetails({
    super.key,
    required this.createOrderModel,
  });

  @override
  State<PaymentDetails> createState() => _PaymentDetailsState();
}

class _PaymentDetailsState extends State<PaymentDetails> {
  late DbChangeNotifierModel dbChangeNotifier;

  late CreateOrderCubit createOrderCubit;
  late double promoCodeValue;
  late bool isPercentage;

  @override
  void initState() {
    dbChangeNotifier = DbChangeNotifier().dbData;

    createOrderCubit = BlocProvider.of<CreateOrderCubit>(context);

    if (dbChangeNotifier.count == 0) {
      dbChangeNotifier = createOrderCubit.getDBChangeNotifierModel(context);
    }

    promoCodeValue = 0;

    isPercentage = false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateOrderCubit, CreateOrderState>(
      listener: (context, state) {
        if (state is CheckPromoCodeLoading || state is CheckPromoCodeFailed) {
          promoCodeValue = 0;
        }

        if (state is CheckPromoCodeSuccess) {
          promoCodeValue = state.promoCodeModel.promoCode!.amount!;
          isPercentage = state.promoCodeModel.promoCode!.isPercentage!;

          if (isPercentage) {
            promoCodeValue = createOrderCubit.calcPromoCode(
              dbChangeNotifier.totalPrice,
              promoCodeValue,
            );
          }

          widget.createOrderModel.promoCode =
              state.promoCodeModel.promoCode!.code!;
        }
      },
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.all(20.r),
          margin: EdgeInsets.only(top: 10.h),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${LocaleKeys.order_summary_screen_sub_total.tr()} (${dbChangeNotifier.count} ${LocaleKeys.order_summary_screen_items.tr()})',
                    style: Styles.styles14w400Black,
                  ),
                  Text(
                    '${dbChangeNotifier.totalPrice} ${LocaleKeys.cart_screen_cart_item_egp.tr()}',
                    style: Styles.styles15w600NormalBlack,
                  ),
                ],
              ),
              SizedBox(height: 15.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    LocaleKeys.order_summary_screen_discount.tr(),
                    style: Styles.styles14w400Black,
                  ),
                  Text(
                    '${dbChangeNotifier.totalDiscount} ${LocaleKeys.cart_screen_cart_item_egp.tr()}',
                    style: Styles.styles15w600NormalBlack,
                  ),
                ],
              ),
              SizedBox(height: 15.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    LocaleKeys.order_summary_screen_promocode_discount.tr(),
                    style: Styles.styles14w400Black,
                  ),
                  Text(
                    '$promoCodeValue ${LocaleKeys.cart_screen_cart_item_egp.tr()}',
                    style: Styles.styles15w600NormalBlack,
                  ),
                ],
              ),
              if (widget.createOrderModel.deliverMethod != 'OnBranch') ...[
                SizedBox(height: 15.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      LocaleKeys.order_summary_screen_delivery_fees.tr(),
                      style: Styles.styles14w400Black,
                    ),
                    Text(
                      '120 ${LocaleKeys.cart_screen_cart_item_egp.tr()}',
                      style: Styles.styles15w600NormalBlack,
                    ),
                  ],
                ),
              ]
            ],
          ),
        );
      },
    );
  }
}

// Widget paymentDetails() {
//   return BlocConsumer<CreateOrderCubit, CreateOrderState>(
//     listener: (context, state) {
//       if (state is CheckPromoCodeSuccess) {
//         print(state.promoCodeModel.promoCode!.name);
//       }
//     },
//     builder: (context, state) {
//       CreateOrderCubit createOrderCubit =
//           BlocProvider.of<CreateOrderCubit>(context);

//       if (state is SuccessPaymentDetails) {
//         return Container(
//           padding: EdgeInsets.all(20.r),
//           margin: EdgeInsets.only(top: 10.h),
//           decoration: BoxDecoration(
//             color: Colors.white.withOpacity(0.9),
//             borderRadius: BorderRadius.circular(15.r),
//           ),
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Sub Total (${state.data.count} Items)',
//                     style: Styles.styles14w400Black,
//                   ),
//                   Text(
//                     '${state.data.totalPrice} EGP',
//                     style: Styles.styles15w600NormalBlack,
//                   ),
//                 ],
//               ),
//               SizedBox(height: 15.h),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Discount',
//                     style: Styles.styles14w400Black,
//                   ),
//                   Text(
//                     '${state.data.totalDiscount} EGP',
//                     style: Styles.styles15w600NormalBlack,
//                   ),
//                 ],
//               ),
//               SizedBox(height: 15.h),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Promocode Discount',
//                     style: Styles.styles14w400Black,
//                   ),
//                   Text(
//                     '120.00 EGP',
//                     style: Styles.styles15w600NormalBlack,
//                   ),
//                 ],
//               ),
//               SizedBox(height: 15.h),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Delivery fees',
//                     style: Styles.styles14w400Black,
//                   ),
//                   Text(
//                     '120 EGP',
//                     style: Styles.styles15w600NormalBlack,
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         );
//       } else {
//         return const SizedBox();
//       }
//     },
//   );
// }
