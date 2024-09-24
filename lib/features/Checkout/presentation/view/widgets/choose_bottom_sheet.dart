import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/button_widget.dart';
import 'package:negmt_heliopolis/core/widgets/radio_animated_widget.dart';

class ChooseBottomSheet extends StatefulWidget {
  const ChooseBottomSheet({super.key});

  @override
  State<ChooseBottomSheet> createState() => _ChooseBottomSheetState();
}

class _ChooseBottomSheetState extends State<ChooseBottomSheet> {
  String radioChoose = 'choose';

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          // height: 300.h,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.r),
          ),
          child: Column(
            children: [
              Text(
                'If we couldn’t reach you in 15 minutes, how you want us to proceed?',
                style: Styles.styles16w600NormalBlack,
              ),
              SizedBox(height: 10.h),
              userChoice(
                radioChoose: radioChoose,
                itemValue: 'choose',
                onTap: () {
                  setState(() {
                    radioChoose = 'choose';
                  });
                },
                title: 'Choose for me',
                text: 'Choose products at approximately with the same price',
              ),
              SizedBox(height: 10.h),
              userChoice(
                radioChoose: radioChoose,
                itemValue: 'not',
                onTap: () {
                  setState(() {
                    radioChoose = 'not';
                  });
                },
                title: 'Do not choose alternative',
                text: 'We will ignore the missing items',
              ),
              buttonWidget(
                child: Text(
                  'Submit',
                  style: Styles.styles17w500NormalWhite,
                ),
                onTap: () {
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
  required String radioChoose,
  required String itemValue,
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
          radioAnimatedWidget(itemValue == radioChoose),
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
