import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/add_widget.dart';
import 'package:negmt_heliopolis/core/widgets/button_widget.dart';
import 'package:negmt_heliopolis/core/widgets/radio_item.dart';

class CardsContainer extends StatefulWidget {
  const CardsContainer({super.key});

  @override
  State<CardsContainer> createState() => _CardsContainerState();
}

class _CardsContainerState extends State<CardsContainer> {
  String radioValue = 0.toString();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20.r),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(255, 255, 255, 1),
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Manage Cards',
                style: Styles.styles17w700Black.copyWith(
                  color: const Color.fromRGBO(41, 41, 41, 1),
                ),
              ),
              SizedBox(height: 10.h),
              radioItem(
                title: 'XXXX XXXX XXXX 5565',
                iconPath: 'card-on-delivery',
                index: 0.toString(),
                radioValue: radioValue,
                onTap: () {
                  setState(() {
                    radioValue = 0.toString();
                  });
                },
              ),
              radioItem(
                title: 'XXXX XXXX XXXX 1234',
                iconPath: 'card-on-delivery',
                index: 1.toString(),
                radioValue: radioValue,
                onTap: () {
                  setState(() {
                    radioValue = 1.toString();
                  });
                },
              ),
              SizedBox(height: 20.h),
              addWidget(
                text: 'Add Card',
                onTap: () {
                  Navigator.pushReplacementNamed(context, cardScreen);
                },
              ),
              SizedBox(height: 20.h),
              buttonWidget(
                color: MyColors.mainColor,
                borderRadius: 37.r,
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: Text(
                  'Sumbit',
                  style: Styles.styles17w500NormalWhite,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
