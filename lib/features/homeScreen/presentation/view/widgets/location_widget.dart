import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/utlis/theming/boxshadow.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/add_widget.dart';
import 'package:negmt_heliopolis/core/widgets/button_widget.dart';
import 'package:negmt_heliopolis/core/widgets/delivery_address_widget.dart';
import 'package:negmt_heliopolis/core/widgets/svg_asset.dart';

class LocationWidget extends StatefulWidget {
  const LocationWidget({super.key});

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  int addressRadioValue = 0;
  String addressTitle = 'Home';
  String addressLocation = 'Salah Salem Street 44C, Maadi, Cairo';

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final Map? result = await showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) => AddressModalBottomSheet(title: addressTitle),
        );
        if (result != null &&
            result.containsKey('title') &&
            result.containsKey('location')) {
          setState(() {
            addressTitle = result['title'];
            addressLocation = result['location'];
          });
        }
      },
      child: Container(
        width: 375.w,
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 49.w),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(255, 255, 255, 0.8),
          boxShadow: [
            MyBoxShadows.locationBoxShadow,
          ],
          borderRadius: BorderRadius.all(
            Radius.circular(20.r),
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                svgIcon(
                  path: 'assets/svg_icons/location.svg',
                  width: 18,
                  height: 18,
                  color: MyColors.mainColor,
                ),
                RichText(
                  text: TextSpan(
                    text: 'Delivery Duration:',
                    style: Styles.styles13w300interFamily,
                    children: [
                      TextSpan(
                        text: '35 min',
                        style: Styles.styles13w400interFamily,
                      ),
                    ],
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            SizedBox(height: 4.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 250.w,
                  child: RichText(
                    text: TextSpan(
                      text: '$addressTitle ',
                      style: Styles.styles17w700Black,
                      children: [
                        TextSpan(
                          text: addressLocation,
                          style: Styles.styles17w400interFamily,
                        ),
                      ],
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: 4.w),
                svgIcon(
                  path: 'assets/svg_icons/arrow-bottom.svg',
                  width: 13.w,
                  height: 6.h,
                  color: const Color.fromRGBO(115, 115, 115, 1),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class AddressModalBottomSheet extends StatefulWidget {
  String title;
  AddressModalBottomSheet({super.key, required this.title});

  @override
  State<AddressModalBottomSheet> createState() =>
      _AddressModalBottomSheetState();
}

class _AddressModalBottomSheetState extends State<AddressModalBottomSheet> {
  Map<String, String> address = {
    'title': 'Home',
    'location': 'Salah Salem Street 44C, Maadi, Cairo',
  };

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20.r),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Delivery Address',
                    style: Styles.styles17w700Black,
                  ),
                  addWidget(
                    text: 'Add Address',
                    onTap: () {
                      Navigator.pushNamed(context, setLocationScreen);
                    },
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              deliveryAddressWidget(
                title: 'Home',
                location: 'Salah Salem Street 44C, Maadi, Cairo',
                addressTitleRadioValue: widget.title,
                onTap: () {
                  setState(() {
                    widget.title = 'Home';
                  });
                },
              ),
              // SizedBox(height: 10.h),
              deliveryAddressWidget(
                title: 'Work',
                location: 'Salah Salem Street 44C, Maadi',
                addressTitleRadioValue: widget.title,
                onTap: () {
                  setState(() {
                    widget.title = 'Work';
                    address = {
                      'title': 'Work',
                      'location': 'Salah Salem Street 44C, Maadi',
                    };
                  });
                },
              ),
              SizedBox(height: 30.h),
              buttonWidget(
                color: MyColors.mainColor,
                padding: EdgeInsets.symmetric(
                  horizontal: 30.w,
                  vertical: 20.h,
                ),
                borderRadius: 53.r,
                child: Text(
                  'Done',
                  style: Styles.styles17w600White,
                ),
                onTap: () {
                  Navigator.pop(context, address);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
