import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/custom_snack_bar.dart';
import 'package:negmt_heliopolis/core/widgets/svg_asset.dart';
import 'package:negmt_heliopolis/features/Checkout/data/model/create_order_model.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/helper.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/widgets/tips_widget.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view_model/create_order_cubit/create_order_cubit.dart';
import 'package:negmt_heliopolis/generated/locale_keys.g.dart';

class Tips {
  String textValue;
  double value;

  Tips(this.textValue, this.value);
}

class DeliveryTipsContianer extends StatefulWidget {
  final CreateOrderModel createOrderModel;
  const DeliveryTipsContianer({super.key, required this.createOrderModel});

  @override
  State<DeliveryTipsContianer> createState() => _DeliveryTipsContianerState();
}

class _DeliveryTipsContianerState extends State<DeliveryTipsContianer> {
  double tipsValue = 0;

  List<Tips> tipsList = [
    Tips(Helper.formatPrice(10), 10),
    Tips(Helper.formatPrice(20), 20),
    Tips(Helper.formatPrice(30), 30),
    Tips(Helper.formatPrice(40), 40),
  ];

  TextEditingController customTipsController = TextEditingController();
  FocusNode customTipsFucosNode = FocusNode();

  bool isCustomTips = false;

  late CreateOrderCubit createOrderCubit;

  @override
  void initState() {
    createOrderCubit = BlocProvider.of<CreateOrderCubit>(context);
    super.initState();
  }

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
        color: Colors.white.withValues(alpha: 0.9),
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
                    LocaleKeys
                        .delivery_tips_container_appreciate_delivery_with_tips
                        .tr(),
                    style: Styles.styles17w700Black,
                  ),
                  Text(
                    LocaleKeys.delivery_tips_container_tips_amount_goes_to_labor
                        .tr(),
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
                ...List.generate(tipsList.length, (index) {
                  return tipsWidget(
                    text: tipsList[index].textValue,
                    isChossen: tipsValue == tipsList[index].value,
                    onTap: () {
                      isCustomTips = false;
                      setState(() {
                        tipsValue = tipsList[index].value;
                        createOrderCubit.tipsToBottomSheet(tipsValue);
                      });
                    },
                  );
                }),
                tipsWidget(
                  text: customTipsController.text.isEmpty
                      ? LocaleKeys.delivery_tips_container_custom.tr()
                      : Helper.formatPrice(
                          double.parse(customTipsController.text),
                        ),
                  onTap: () {
                    isCustomTips = !isCustomTips;
                    tipsValue = customTipsController.text.isEmpty
                        ? 0
                        : double.parse(customTipsController.text);

                    createOrderCubit.tipsToBottomSheet(tipsValue);
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
                  LocaleKeys.delivery_tips_container_enter_amount.tr(),
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
                    onSubmitted: (value) {
                      try {
                        tipsValue = customTipsController.text.isEmpty
                            ? 0
                            : double.parse(customTipsController.text);

                        createOrderCubit.tipsToBottomSheet(tipsValue);
                      } catch (e) {
                        CustomSnackBar.show(
                          context: context,
                          duration: const Duration(milliseconds: 5000),
                          text: LocaleKeys
                              .delivery_tips_container_enter_valid_number
                              .tr(),
                          isGreen: false,
                        );
                      }
                    },
                    controller: customTipsController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 15.h,
                      ),
                      hintText: LocaleKeys.delivery_tips_container_enter_amount
                          .tr(),
                      border: InputBorder.none,
                      hintStyle: Styles.styles17w400interFamily.copyWith(
                        color: const Color.fromRGBO(181, 185, 190, 1),
                      ),
                      suffixIcon: TextButton(
                        onPressed: () {
                          try {
                            tipsValue = customTipsController.text.isEmpty
                                ? 0
                                : double.parse(customTipsController.text);

                            createOrderCubit.tipsToBottomSheet(tipsValue);
                          } catch (e) {
                            CustomSnackBar.show(
                              context: context,
                              duration: const Duration(milliseconds: 5000),
                              text: LocaleKeys
                                  .delivery_tips_container_enter_valid_number
                                  .tr(),
                              isGreen: false,
                            );
                          }
                        },
                        child: Text(
                          LocaleKeys.delivery_tips_container_apply.tr(),
                          style: Styles.styles17w500MainColor,
                        ),
                      ),
                    ),
                    cursorColor: MyColors.mainColor,
                    style: Styles.styles17w700MainColor,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
