import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/radio_item.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/widgets/cards_container.dart';

class DeliveryPaymentContianer extends StatefulWidget {
  const DeliveryPaymentContianer({super.key});

  @override
  State<DeliveryPaymentContianer> createState() =>
      _DeliveryPaymentContianerState();
}

class _DeliveryPaymentContianerState extends State<DeliveryPaymentContianer> {
  int radioValue = 0;

  @override
  Widget build(BuildContext context) {
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
            index: 0,
            radioValue: radioValue,
            onTap: () {
              setState(() {
                radioValue = 0;
              });
            },
          ),
          radioItem(
            title: 'Card on delivery',
            iconPath: 'card-on-delivery',
            index: 1,
            radioValue: radioValue,
            onTap: () {
              setState(() {
                radioValue = 1;
              });
            },
          ),
          radioItem(
            title: 'Credit/Debit card',
            iconPath: 'credit-or-debit-card',
            index: 2,
            radioValue: radioValue,
            onTap: () async {
              setState(() {
                radioValue = 2;
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
