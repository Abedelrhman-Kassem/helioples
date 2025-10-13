import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:negmt_heliopolis/controller/addresse_controller.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/utlis/theming/boxshadow.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/add_widget.dart';
import 'package:negmt_heliopolis/core/widgets/button_widget.dart';
import 'package:negmt_heliopolis/core/widgets/custom_getx_snak_bar.dart';
import 'package:negmt_heliopolis/core/widgets/delivery_address_widget.dart';
import 'package:negmt_heliopolis/core/widgets/svg_asset.dart';
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
              translation: const Offset(0, -0.5),
              child: Skeletonizer(
                child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 50.w,
                      vertical: 10.h,
                    ),
                    height: 85.h,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('hello there how are you'),
                        Text('hello there how are you'),
                      ],
                    )),
              ),
            );
          } else if (controller.errorMessage != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              // Future.delayed(const Duration(seconds: 5), () {
              showCustomGetSnack(
                duration: const Duration(seconds: 10),
                isGreen: false,
                text: controller.errorMessage!,
              );
              // });
            });
            return SizedBox(
              height: 50.h,
            );
          } else {
            return InkWell(
              onTap: () async {
                await showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => const AddressModalBottomSheet(),
                );
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
                              text: '${controller.address?.locationStr} ',
                              style: Styles.styles17w700Black,
                              children: [
                                TextSpan(
                                  text: '${controller.address?.street}',
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
        });
  }
}

class AddressModalBottomSheet extends GetView<AddressesControllerImpl> {
  const AddressModalBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    // log(controller.addressId.toString());

    // Map<String, String> address = {
    //   'title': 'Home',
    //   'location': 'Salah Salem Street 44C, Maadi, Cairo',
    // };
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
                      // Get.toNamed(setLocationScreen);
                      Navigator.pushNamed(context, setLocationScreen);
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
                      itemCount: controller.mainAddressModel.address!.length,
                      itemBuilder: (context, index) => deliveryAddressWidget(
                        title: controller
                            .mainAddressModel.address![index].locationStr!,
                        location:
                            controller.mainAddressModel.address![index].street!,
                        isChossen: controller.addressId ==
                            controller.mainAddressModel.address![index].id,
                        onTap: () {
                          final id =
                              controller.mainAddressModel.address![index].id;

                          controller.chaingId(id ?? 0);
                        },
                      ),
                    );
                  }),
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
                  await controller.setChossenAddress(controller.addressId ?? 0);
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
