import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/radio_item.dart';
import 'package:negmt_heliopolis/features/Checkout/data/model/create_order_model.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/widgets/cards_container.dart';

class DeliveryPaymentContianer extends StatefulWidget {
  final CreateOrderModel createOrderModel;
  const DeliveryPaymentContianer({
    super.key,
    required this.createOrderModel,
  });

  @override
  State<DeliveryPaymentContianer> createState() =>
      _DeliveryPaymentContianerState();
}

class _DeliveryPaymentContianerState extends State<DeliveryPaymentContianer> {
  String radioValue = 'cashOnDelivery';

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
            'Payment',
            style: Styles.styles17w700Black,
          ),
          SizedBox(height: 20.h),
          radioItem(
            title: 'Cash on delivery',
            iconPath: 'cash-on-delivery',
            index: 'cashOnDelivery',
            radioValue: radioValue,
            onTap: () {
              setState(() {
                radioValue = 'cashOnDelivery';
              });
            },
          ),
          radioItem(
            title: 'Card on delivery',
            iconPath: 'card-on-delivery',
            index: 'cardOnDelivery',
            radioValue: radioValue,
            onTap: () {
              setState(() {
                radioValue = 'cardOnDelivery';
              });
            },
          ),
          radioItem(
            title: 'Credit/Debit card',
            iconPath: 'credit-or-debit-card',
            index: 'card',
            radioValue: radioValue,
            onTap: () async {
              setState(() {
                radioValue = 'card';
              });

              return showModalBottomSheet(
                context: context,
                builder: (context) {
                  return const CardsContainer();
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
