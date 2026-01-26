import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/radio_item.dart';
import 'package:negmt_heliopolis/core/widgets/svg_asset.dart';
import 'package:negmt_heliopolis/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class ModalBottomSheet extends StatefulWidget {
  final int items;
  const ModalBottomSheet({super.key, required this.items});

  @override
  State<ModalBottomSheet> createState() => _ModalBottomSheetState();
}

class _ModalBottomSheetState extends State<ModalBottomSheet> {
  String paymentType = 'onDelivery';

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          // padding: EdgeInsets.only(left: 18.35.r, right: 18.35.r, top: 27.52.h),
          padding: EdgeInsets.symmetric(horizontal: 18.35.r, vertical: 27.52.h),

          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.r),
              topRight: Radius.circular(30.r),
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    LocaleKeys.cart_modal_select_order_type.tr(),
                    style: Styles.styles17w700Black,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: svgIcon(
                      path: 'assets/svg_icons/x-close.svg',
                      width: 27.52.w,
                      height: 27.52.h,
                      color: const Color.fromRGBO(93, 92, 100, 1),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              radioItem(
                title: LocaleKeys.cart_modal_delivery.tr(),
                iconPath: 'ic_outline-delivery-dining',
                index: 'onDelivery',
                radioValue: paymentType,
                onTap: () {
                  setState(() {
                    paymentType = 'onDelivery';
                  });
                },
              ),
              radioItem(
                title: LocaleKeys.cart_modal_pickup.tr(),
                iconPath: 'subway_bag',
                index: 'OnBranch',
                radioValue: paymentType,
                // onTap:
                //  () {
                //   setState(() {
                //     paymentType = 'OnBranch';
                //   });
                // },
              ),
              SizedBox(height: 10.h),
              InkWell(
                borderRadius: BorderRadius.circular(36.77.r),
                onTap: () {
                  if ('onDelivery' == paymentType) {
                    Navigator.pushNamed(context, checkoutScreen);
                  } else {
                    Navigator.pushNamed(context, pickUpScreen);
                  }
                },
                child: Container(
                  width: 284.w,
                  height: 58.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(36.77.r),
                    border: Border.all(color: MyColors.mainColor, width: 2),
                  ),
                  child: Text(
                    LocaleKeys.cart_modal_continue.tr(),
                    style: Styles.styles17w500MainColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
