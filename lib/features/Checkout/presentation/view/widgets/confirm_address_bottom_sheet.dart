import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/button_widget.dart';

class ConfirmAddressBottomSheet extends StatefulWidget {
  const ConfirmAddressBottomSheet({super.key});

  @override
  State<ConfirmAddressBottomSheet> createState() =>
      _ConfirmAddressBottomSheetState();
}

class _ConfirmAddressBottomSheetState extends State<ConfirmAddressBottomSheet> {
  double mainContainerHeight = 280;

  TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 0),
          height: mainContainerHeight.h,
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 25.h,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.r),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Address Name',
                    style: Styles.styles14w500interFamily.copyWith(
                      color: const Color.fromRGBO(40, 40, 40, 1),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Back',
                      style: Styles.styles14w400Black.copyWith(
                        color: const Color.fromRGBO(41, 41, 41, 1),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 10.h),
              RichText(
                text: TextSpan(
                  text: 'Cairo, Egypt ',
                  style: Styles.styles12w600Black.copyWith(
                    color: const Color.fromRGBO(70, 70, 70, 1),
                  ),
                  children: [
                    TextSpan(
                      text:
                          '8228 Imam Ali Road Riyadh 12345-6789 Kingdom Of Saudi Arabia Generate A Fake address',
                      style: Styles.styles12w400black.copyWith(
                        color: const Color.fromRGBO(70, 70, 70, 1),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(246, 246, 246, 1),
                  borderRadius: BorderRadius.circular(40.r),
                  border: Border.all(
                    color: const Color.fromRGBO(210, 210, 210, 1),
                    width: 1.5.r,
                  ),
                ),
                child: TextField(
                  controller: addressController,
                  onTap: () {
                    Future.delayed(const Duration(milliseconds: 300), () {
                      // TO DO GET THE KEYBOARD HEIGHT WHEN THE USER LOGIN
                      setState(() {
                        mainContainerHeight = 600;
                        // print(MediaQuery.of(context).viewInsets.bottom);
                      });
                    });
                  },
                  onSubmitted: (val) {
                    // TO DO GET THE KEYBOARD HEIGHT WHEN THE USER LOGIN
                    setState(() {
                      mainContainerHeight = 300;
                      // print(MediaQuery.of(context).viewInsets.bottom);
                    });
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 15.w,
                      vertical: 15.h,
                    ),
                    hintText: 'Enter Address Name',
                    border: InputBorder.none,
                    hintStyle: Styles.styles17w400interFamily.copyWith(
                      color: const Color.fromRGBO(181, 185, 190, 1),
                    ),
                  ),
                  cursorColor: MyColors.mainColor,
                  style: Styles.styles17w700MainColor,
                ),
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  Expanded(
                    child: buttonWidget(
                      color: MyColors.mainColor,
                      padding: EdgeInsets.symmetric(
                        horizontal: 30.w,
                        vertical: 20.h,
                      ),
                      borderRadius: 53.r,
                      child: Text(
                        'Save Address',
                        style: Styles.styles17w600White,
                      ),
                      onTap: () {
                        // addressController.text;
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: buttonWidget(
                      padding: EdgeInsets.symmetric(
                        horizontal: 30.w,
                        vertical: 20.h,
                      ),
                      borderRadius: 53.r,
                      border: Border.all(
                        color: MyColors.mainColor,
                        width: 1.5.r,
                      ),
                      child: Text(
                        'Use Once',
                        style: Styles.styles17w600White.copyWith(
                          color: MyColors.mainColor,
                        ),
                      ),
                      onTap: () {
                        // addressController.text;
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
