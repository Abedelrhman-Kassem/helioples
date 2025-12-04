import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/button_widget.dart';
import 'package:negmt_heliopolis/core/widgets/radio_animated_widget.dart';
import 'package:negmt_heliopolis/features/Checkout/data/model/create_order_model.dart';
import 'package:negmt_heliopolis/generated/locale_keys.g.dart';

class ChooseBottomSheet extends StatefulWidget {
  final CreateOrderModel createOrderModel;
  const ChooseBottomSheet({
    super.key,
    required this.createOrderModel,
  });

  @override
  State<ChooseBottomSheet> createState() => _ChooseBottomSheetState();
}

class _ChooseBottomSheetState extends State<ChooseBottomSheet> {
  bool radioChoose = true;

  @override
  void initState() {
    if (widget.createOrderModel.chooseForMe == null) {
      widget.createOrderModel.chooseForMe = radioChoose;
    } else {
      radioChoose == widget.createOrderModel.chooseForMe!;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                LocaleKeys.choose_bottom_sheet_choose_how_to_proceed.tr(),
                style: Styles.styles16w600NormalBlack,
              ),
              SizedBox(height: 10.h),
              userChoice(
                radioChoose: radioChoose == true,
                onTap: () {
                  setState(() {
                    radioChoose = true;
                  });
                },
                title: LocaleKeys.choose_bottom_sheet_choose_for_me.tr(),
                text: LocaleKeys.choose_bottom_sheet_choose_for_me_desc.tr(),
              ),
              SizedBox(height: 10.h),
              userChoice(
                radioChoose: radioChoose == false,
                onTap: () {
                  setState(() {
                    radioChoose = false;
                  });
                },
                title: LocaleKeys.choose_bottom_sheet_do_not_choose_alternative
                    .tr(),
                text: LocaleKeys
                    .choose_bottom_sheet_do_not_choose_alternative_desc
                    .tr(),
              ),
              buttonWidget(
                child: Text(
                  LocaleKeys.choose_bottom_sheet_submit.tr(),
                  style: Styles.styles17w500NormalWhite,
                ),
                onTap: () {
                  widget.createOrderModel.chooseForMe = radioChoose;
                  Navigator.pop(context);
                },
                color: MyColors.mainColor,
                padding: EdgeInsets.symmetric(vertical: 20.h),
                borderRadius: 37.r,
                margin: EdgeInsets.only(top: 30.h),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget userChoice({
  required bool radioChoose,
  required void Function() onTap,
  required String title,
  required String text,
}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(15.r),
    child: Container(
      constraints: BoxConstraints(minHeight: 80.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 11.h),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(232, 232, 232, 1),
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          radioAnimatedWidget(radioChoose),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Styles.styles16w400Black41,
                ),
                Text(
                  text,
                  style: Styles.styles12w400Gray.copyWith(
                    color: const Color.fromRGBO(70, 70, 70, 1),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
