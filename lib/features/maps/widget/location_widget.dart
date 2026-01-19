import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:negmt_heliopolis/controller/map/addresse_controller.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/utlis/theming/boxshadow.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/add_widget.dart';
import 'package:negmt_heliopolis/core/widgets/button_widget.dart';
import 'package:negmt_heliopolis/core/widgets/delivery_address_widget.dart';
import 'package:negmt_heliopolis/core/widgets/svg_asset.dart';
import 'package:negmt_heliopolis/features/Widgets/bluer_dilog.dart';
import 'package:negmt_heliopolis/features/maps/widget/edit_address.dart';
import 'package:skeletonizer/skeletonizer.dart';

class LocationWidgetWithGetX extends StatelessWidget {
  const LocationWidgetWithGetX({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddressesControllerImpl>(
      id: 'ChossenAddressId',
      builder: (controller) {
        if (controller.loading) {
          return FractionalTranslation(
            translation: const Offset(0, -0.1),
            child: Skeletonizer(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 10.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('hello there how are you customer'),
                        Text('hello there how are you customer'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (controller.errorMessage != null) {
          return CustWidgetaddress(
            onTap: () {
              Navigator.pushNamed(context, signInScreen);
            },
            locationStr: "Please login to set address",
            isErorr: controller.errorMessage!,
          );
        } else if (controller.address == null) {
          log("address is null------------");
          return CustWidgetaddress(
            onTap: () async {
              await showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) => const AddressModalBottomSheet(),
              );
            },
            locationStr: "Tap to add address",
            isErorr: "No Address Found",
            showIcon: false,
          );
        } else {
          return CustWidgetaddress(
            onTap: () async {
              await showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) => const AddressModalBottomSheet(),
              );
            },
            locationStr: controller.address?.locationStr ?? 'No Address',
            street: controller.address?.street ?? '',
          );
        }
      },
    );
  }
}

class AddressModalBottomSheet extends GetView<AddressesControllerImpl> {
  const AddressModalBottomSheet({super.key});

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
                  Text('Delivery Address', style: Styles.styles17w700Black),
                  addWidget(
                    text: 'Add Address',
                    onTap: () {
                      // Get.toNamed(setLocationScreen);
                      Navigator.pushNamed(context, addAddressScreen);
                    },
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              GetBuilder<AddressesControllerImpl>(
                id: 'addressId',
                builder: (controller) {
                  return ListView.builder(
                    // physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.mainAddressModel?.address.length ?? 0,
                    itemBuilder: (context, index) => deliveryAddressWidget(
                      title: controller
                          .mainAddressModel!
                          .address[index]
                          .locationStr!,
                      location:
                          controller.mainAddressModel!.address[index].street!,
                      isChossen:
                          controller.addressId ==
                          controller.mainAddressModel!.address[index].id,
                      onTap: () {
                        final id =
                            controller.mainAddressModel!.address[index].id;

                        controller.chaingId(id ?? '');
                      },
                      onEdit: () {
                        blurDilog(
                          EditLocation(
                            address:
                                controller.mainAddressModel!.address[index],
                          ),
                          context,
                        );
                      },
                    ),
                  );
                },
              ),

              SizedBox(height: 30.h),
              buttonWidget(
                color: MyColors.mainColor,
                padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
                borderRadius: 53.r,
                child: Text('Done', style: Styles.styles17w600White),
                onTap: () async {
                  await controller.setChossenAddress(
                    controller.addressId ?? '',
                  );
                  Get.back();

                  // Navigator.pop(context, address);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CustWidgetaddress extends StatelessWidget {
  final void Function()? onTap;
  final String? locationStr;
  final String? street;
  final String? isErorr;
  final bool showIcon;
  const CustWidgetaddress({
    super.key,
    this.locationStr,
    this.street,
    this.onTap,
    this.isErorr,
    this.showIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 375.w,
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 49.w),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(255, 255, 255, 0.8),
          boxShadow: [MyBoxShadows.locationBoxShadow],
          borderRadius: BorderRadius.all(Radius.circular(20.r)),
        ),
        child: Column(
          children: [
            isErorr != null
                ? RichText(
                    text: TextSpan(
                      text: '$isErorr ',
                      style: Styles.styles12w400Gold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  )
                : Row(
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
            isErorr != null
                ? Row(
                    spacing: 3.w,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: locationStr ?? '',
                          style: Styles.styles12w400MainColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      showIcon
                          ? Icon(
                              Icons.login,
                              color: MyColors.mainColor,
                              size: 14.r,
                            )
                          : svgIcon(
                              path: 'assets/svg_icons/arrow-bottom.svg',
                              width: 13.w,
                              height: 6.h,
                              color: const Color.fromRGBO(115, 115, 115, 1),
                            ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 250.w,
                        child: RichText(
                          text: TextSpan(
                            text: locationStr ?? '',
                            style: Styles.styles17w700Black,
                            children: [
                              TextSpan(
                                text: street ?? '',
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
