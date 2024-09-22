import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/add_widget.dart';
import 'package:negmt_heliopolis/core/widgets/delivery_address_widget.dart';

class DeliveryAddressContainer extends StatefulWidget {
  const DeliveryAddressContainer({super.key});

  @override
  State<DeliveryAddressContainer> createState() =>
      _DeliveryAddressContainerState();
}

class _DeliveryAddressContainerState extends State<DeliveryAddressContainer> {
  String addressRadioValue = 'Home';

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
          SizedBox(height: 20.h),
          deliveryAddressWidget(
            addressTitleRadioValue: addressRadioValue,
            location: 'Salah Salem Street 44C, Maadi, Cairo',
            title: 'Home',
            onTap: () {
              setState(() {
                addressRadioValue = 'Home';
              });
            },
          ),
          deliveryAddressWidget(
              addressTitleRadioValue: addressRadioValue,
              location: 'Omar Ibn Al Khatab Street 436A',
              title: 'Work',
              onTap: () {
                setState(() {
                  addressRadioValue = 'Work';
                });
              }),
        ],
      ),
    );
  }
}
