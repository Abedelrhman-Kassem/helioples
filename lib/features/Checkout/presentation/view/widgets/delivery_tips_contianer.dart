import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/svg_asset.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/widgets/tips_widget.dart';

class Tips {
  String textValue;
  int value;

  Tips(this.textValue, this.value);
}

class DeliveryTipsContianer extends StatefulWidget {
  const DeliveryTipsContianer({super.key});

  @override
  State<DeliveryTipsContianer> createState() => _DeliveryTipsContianerState();
}

class _DeliveryTipsContianerState extends State<DeliveryTipsContianer> {
  int tipsValue = 0;

  List<Tips> tipsList = [
    Tips('10 EGP', 10),
    Tips('20 EGP', 20),
    Tips('30 EGP', 30),
    Tips('40 EGP', 40),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.r),
      margin: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Appreciate delivery with tips',
                    style: Styles.styles17w700Black,
                  ),
                  Text(
                    'Tips amount will go directly to the delivery labor',
                    style: Styles.styles12w300NormalBlack.copyWith(
                      color: const Color.fromRGBO(120, 120, 120, 1),
                    ),
                  ),
                ],
              ),
              svgIcon(
                path: 'assets/svg_icons/appreciate-delivery-with-tips.svg',
                width: 29.w,
                height: 29.h,
                color: const Color.fromRGBO(255, 202, 40, 1),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          SizedBox(
            width: double.infinity,
            child: Wrap(
              spacing: 10.w,
              children: [
                ...List.generate(
                  tipsList.length,
                  (index) {
                    return tipsWidget(
                      text: tipsList[index].textValue,
                      value: tipsList[index].value,
                      tipsValue: tipsValue,
                      onTap: () {
                        setState(() {
                          tipsValue = tipsList[index].value;
                        });
                      },
                    );
                  },
                ),
                tipsWidget(
                  text: 'Custom',
                  onTap: () {
                    setState(() {
                      tipsValue = 500;
                    });
                  },
                  value: 500,
                  tipsValue: tipsValue,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
