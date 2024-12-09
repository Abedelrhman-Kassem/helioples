import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/notifiers/db_change_notifier.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/features/Checkout/data/model/create_order_model.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view_model/create_order_cubit/create_order_cubit.dart';

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
  late final DbChangeNotifier dbChangeNotifier;

  late CreateOrderCubit createOrderCubit;
  late double promoCodeValue;
  late bool isPercentage;

  @override
  void initState() {
    dbChangeNotifier = DbChangeNotifier();

    createOrderCubit = BlocProvider.of<CreateOrderCubit>(context);

    promoCodeValue = 0;
    isPercentage = false;

    super.initState();
  }

  void refreshState() {
    if (mounted) {
      setState(() {});
    }
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
              dbChangeNotifier.dbData.totalPrice,
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
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Sub Total (${dbChangeNotifier.dbData.count} Items)',
                    style: Styles.styles14w400Black,
                  ),
                  Text(
                    '${dbChangeNotifier.dbData.totalPrice} EGP',
                    style: Styles.styles15w600NormalBlack,
                  ),
                ],
              ),
              SizedBox(height: 15.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Discount',
                    style: Styles.styles14w400Black,
                  ),
                  Text(
                    '${dbChangeNotifier.dbData.totalDiscount} EGP',
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
                    '$promoCodeValue EGP',
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
                      'Delivery fees',
                      style: Styles.styles14w400Black,
                    ),
                    Text(
                      '120 EGP',
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
