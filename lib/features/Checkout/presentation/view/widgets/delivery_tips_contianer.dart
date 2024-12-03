import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/svg_asset.dart';
import 'package:negmt_heliopolis/features/Checkout/data/model/create_order_model.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/widgets/tips_widget.dart';

class Tips {
  String textValue;
  double value;

  Tips(this.textValue, this.value);
}

class DeliveryTipsContianer extends StatefulWidget {
  final CreateOrderModel createOrderModel;
  const DeliveryTipsContianer({
    super.key,
    required this.createOrderModel,
  });

  @override
  State<DeliveryTipsContianer> createState() => _DeliveryTipsContianerState();
}

class _DeliveryTipsContianerState extends State<DeliveryTipsContianer> {
  double tipsValue = 0;

  List<Tips> tipsList = [
    Tips('10 EGP', 10),
    Tips('20 EGP', 20),
    Tips('30 EGP', 30),
    Tips('40 EGP', 40),
  ];

  TextEditingController customTipsController = TextEditingController();
  FocusNode customTipsFucosNode = FocusNode();

  bool isCustomTips = false;

  @override
  void dispose() {
    customTipsController.dispose();
    customTipsFucosNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget.createOrderModel.tips = tipsValue;

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
                      isChossen: tipsValue == tipsList[index].value,
                      onTap: () {
                        isCustomTips = false;
                        setState(() {
                          tipsValue = tipsList[index].value;
                        });
                      },
                    );
                  },
                ),
                tipsWidget(
                  text: customTipsController.text.isEmpty
                      ? 'Custom'
                      : '${customTipsController.text} EGP',
                  onTap: () {
                    isCustomTips = true;
                    tipsValue = customTipsController.text.isEmpty
                        ? 0
                        : double.parse(customTipsController.text);

                    FocusScope.of(context).requestFocus(customTipsFucosNode);
                    setState(() {});
                  },
                  isChossen: isCustomTips,
                ),
              ],
            ),
          ),
          if (isCustomTips)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                Text(
                  'Tips Amount',
                  style: Styles.styles17w700Black,
                ),
                SizedBox(height: 20.h),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(33.06.r),
                    border: Border.all(
                      color: const Color.fromRGBO(246, 246, 246, 1),
                    ),
                  ),
                  child: TextField(
                    controller: customTipsController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 15.h,
                      ),
                      hintText: 'Enter Amount',
                      border: InputBorder.none,
                      hintStyle: Styles.styles17w400interFamily.copyWith(
                        color: const Color.fromRGBO(181, 185, 190, 1),
                      ),
                      suffixIcon: TextButton(
                        onPressed: () {
                          tipsValue = customTipsController.text.isEmpty
                              ? 0
                              : double.parse(customTipsController.text);
                          FocusScope.of(context).unfocus();
                          setState(() {});
                        },
                        child: Text(
                          'Apply',
                          style: Styles.styles17w500MainColor,
                        ),
                      ),
                    ),
                    cursorColor: MyColors.mainColor,
                    style: Styles.styles17w700MainColor,
                    onChanged: (value) {},
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
