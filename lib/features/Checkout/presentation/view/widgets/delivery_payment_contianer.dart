import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:negmt_heliopolis/generated/locale_keys.g.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/radio_item.dart';
import 'package:negmt_heliopolis/features/Checkout/data/model/create_order_model.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/widgets/cards_container.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view_model/create_order_cubit/create_order_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeliveryPaymentContianer extends StatefulWidget {
  final CreateOrderModel createOrderModel;
  const DeliveryPaymentContianer({super.key, required this.createOrderModel});

  @override
  State<DeliveryPaymentContianer> createState() =>
      _DeliveryPaymentContianerState();
}

class _DeliveryPaymentContianerState extends State<DeliveryPaymentContianer> {
  OrderPaymentMethod radioValue = OrderPaymentMethod.cashOnDelivery;

  @override
  Widget build(BuildContext context) {
    widget.createOrderModel.paymentMethod = radioValue;

    return Container(
      padding: EdgeInsets.all(20.r),
      margin: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.checkout_delivery_screen_payment.tr(),
            style: Styles.styles17w700Black,
          ),
          SizedBox(height: 20.h),
          radioItem(
            title: LocaleKeys.checkout_delivery_screen_cash_on_delivery.tr(),
            iconPath: 'cash-on-delivery',
            index: 'cashOnDelivery',
            radioValue: radioValue.toApiString(),
            onTap: () {
              setState(() {
                radioValue = OrderPaymentMethod.cashOnDelivery;
              });
            },
          ),
          radioItem(
            title: LocaleKeys.checkout_delivery_screen_card_on_delivery.tr(),
            iconPath: 'card-on-delivery',
            index: 'cardOnDelivery',
            radioValue: radioValue.toApiString(),
            onTap: () {
              setState(() {
                radioValue = OrderPaymentMethod.cardOnDelivery;
              });
            },
          ),
          BlocBuilder<CreateOrderCubit, CreateOrderState>(
            builder: (context, state) {
              final isAvailable = BlocProvider.of<CreateOrderCubit>(
                context,
              ).isPaymentGatewayAvailable;
              if (!isAvailable) {
                return const SizedBox.shrink();
              }
              return radioItem(
                title: LocaleKeys.checkout_delivery_screen_credit_debit_card
                    .tr(),
                iconPath: 'credit-or-debit-card',
                index: 'card',
                radioValue: radioValue.toApiString(),
                onTap: () async {
                  setState(() {
                    radioValue = OrderPaymentMethod.card;
                  });

                  return showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return const CardsContainer();
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
