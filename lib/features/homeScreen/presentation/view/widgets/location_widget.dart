import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/utlis/cubit/main_cubit.dart';
import 'package:negmt_heliopolis/core/utlis/theming/boxshadow.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/add_widget.dart';
import 'package:negmt_heliopolis/core/widgets/button_widget.dart';
import 'package:negmt_heliopolis/core/widgets/delivery_address_widget.dart';
import 'package:negmt_heliopolis/core/widgets/svg_asset.dart';
import 'package:negmt_heliopolis/features/homeScreen/presentation/view/widgets/screens/confirm_address_screen.dart';
import 'package:negmt_heliopolis/features/homeScreen/data/model/address_model.dart';

class LocationWidget extends StatefulWidget {
  final AddressModel addressModel;
  const LocationWidget({super.key, required this.addressModel});

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  late AddressModel addressModel;
  late Address chossenAddress;

  @override
  Widget build(BuildContext context) {
    addressModel = widget.addressModel;
    chossenAddress = BlocProvider.of<MainCubit>(context).address!;

    return InkWell(
      onTap: () async {
        await showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) => AddressModalBottomSheet(
            addressModel: addressModel,
          ),
        );
        setState(() {});
        // Navigator.pushNamed(context, confirmAddress);
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
                      text: '${chossenAddress.locationStr} ',
                      style: Styles.styles17w700Black,
                      children: [
                        TextSpan(
                          text: '${chossenAddress.street}',
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

class AddressModalBottomSheet extends StatefulWidget {
  final AddressModel addressModel;
  const AddressModalBottomSheet({super.key, required this.addressModel});

  @override
  State<AddressModalBottomSheet> createState() =>
      _AddressModalBottomSheetState();
}

class _AddressModalBottomSheetState extends State<AddressModalBottomSheet> {
  Map<String, String> address = {
    'title': 'Home',
    'location': 'Salah Salem Street 44C, Maadi, Cairo',
  };

  int? addressId;

  @override
  void initState() {
    addressId = BlocProvider.of<MainCubit>(context).address!.id;
    super.initState();
  }

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
              ListView.builder(
                // physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.addressModel.address!.length,
                itemBuilder: (context, index) => deliveryAddressWidget(
                  title: widget.addressModel.address![index].locationStr!,
                  location: widget.addressModel.address![index].street!,
                  isChossen:
                      addressId == widget.addressModel.address![index].id,
                  onTap: () {
                    setState(() {
                      addressId = widget.addressModel.address![index].id;
                    });
                  },
                ),
              ),
              // SizedBox(height: 10.h),
              // deliveryAddressWidget(
              //   title: 'Work',
              //   location: 'Salah Salem Street 44C, Maadi',
              //   addressTitleRadioValue: widget.title,
              //   onTap: () {
              //     setState(() {
              //       widget.title = 'Work';
              //       address = {
              //         'title': 'Work',
              //         'location': 'Salah Salem Street 44C, Maadi',
              //       };
              //     });
              //   },
              // ),
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
                onTap: () async {
                  await BlocProvider.of<MainCubit>(context)
                      .setChossenAddress(addressId!);

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
