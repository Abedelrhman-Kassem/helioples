import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:negmt_heliopolis/controller/map/address_controller.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/handlingdataviwe.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/helper.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/validate.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/widgets/custom_button.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/custom_getx_snak_bar.dart';
import 'package:negmt_heliopolis/features/Checkout/data/model/create_order_model.dart';
import 'package:negmt_heliopolis/features/maps/model/address_model.dart';
import 'package:negmt_heliopolis/features/Widgets/custtextfeld.dart';
import 'package:negmt_heliopolis/generated/locale_keys.g.dart';

class Addlocattion extends StatefulWidget {
  final LatLng latLngg;
  final bool isUsOne;

  const Addlocattion({super.key, required this.latLngg, required this.isUsOne});

  @override
  State<Addlocattion> createState() => _AddlocattionState();
}

class _AddlocattionState extends State<Addlocattion> {
  final GlobalKey<FormState> formkey = .new();
  late final TextEditingController addressTitle;
  late final TextEditingController street;
  late final TextEditingController buildingNumber;
  late final TextEditingController floor;
  late final TextEditingController apartment;

  @override
  void initState() {
    super.initState();
    final controller = Get.find<AddressControllerImpl>();
    addressTitle = .new(
      text: '${controller.country}-${controller.city}-${controller.street}',
    );
    street = .new(text: controller.street);
    buildingNumber = .new();
    floor = .new();
    apartment = .new();
  }

  @override
  void dispose() {
    addressTitle.dispose();
    street.dispose();
    buildingNumber.dispose();
    floor.dispose();
    apartment.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddressControllerImpl>(
      builder: (controller) {
        return Form(
          key: formkey,
          child: SingleChildScrollView(
            child: Column(
              spacing: 10.h,
              children: [
                Custtextfeld(
                  hint: StringTranslateExtension(
                    LocaleKeys.add_location_address_title,
                  ).tr(),
                  controller: addressTitle,
                  validator: (val) {
                    return vlidateInPut(val: val!, min: 3, max: 100);
                  },
                ),
                Custtextfeld(
                  hint: StringTranslateExtension(
                    LocaleKeys.add_location_street,
                  ).tr(),
                  controller: street,
                  validator: (val) {
                    return vlidateInPut(val: val!, min: 2, max: 100);
                  },
                ),
                Custtextfeld(
                  hint: StringTranslateExtension(
                    LocaleKeys.add_location_floor,
                  ).tr(),
                  controller: floor,
                  validator: (val) {
                    return vlidateInPut(val: val!, min: 1, max: 100);
                  },
                  keyboardType: const TextInputType.numberWithOptions(),
                ),
                Custtextfeld(
                  hint: StringTranslateExtension(
                    LocaleKeys.add_location_building_number,
                  ).tr(),
                  controller: buildingNumber,
                  validator: (val) {
                    return vlidateInPut(val: val!, min: 1, max: 100);
                  },
                  keyboardType: const TextInputType.numberWithOptions(),
                ),
                Custtextfeld(
                  hint: StringTranslateExtension(
                    LocaleKeys.add_location_department,
                  ).tr(),
                  controller: apartment,
                  validator: (val) {
                    return vlidateInPut(val: val!, min: 2, max: 100);
                  },
                ),
                SizedBox(height: 20.h),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    spacing: 20.w,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Handlingdataviwe(
                          shimmer: Helper.loadingWidget(),
                          statusrequest: controller.addAddressesstatusrequest,
                          widget: CustomButton(
                            backgroundColor: MyColors.mainColor,
                            textColor: Colors.white,

                            text: StringTranslateExtension(
                              LocaleKeys.add_location_save_address,
                            ).tr(),
                            onTap: () {
                              if (formkey.currentState!.validate()) {
                                Address address = Address(
                                  locationStr: addressTitle.text,
                                  street: street.text,
                                  department: apartment.text,
                                  buildingNo: buildingNumber.text,
                                  floor: floor.text,
                                  latitude: widget.latLngg.latitude,
                                  longitude: widget.latLngg.longitude,
                                );
                                controller.addAddress(address);
                              }
                            },
                          ),
                        ),
                      ),
                      if (widget.isUsOne)
                        Expanded(
                          child: CustomButton(
                            backgroundColor: Colors.white,
                            textColor: MyColors.mainColor,
                            borderColor: MyColors.mainColor,
                            borderWidth: 2,

                            text: StringTranslateExtension(
                              LocaleKeys.add_location_use_once,
                            ).tr(),
                            onTap: () {
                              // Only validate title for "Use One"
                              final titleError = vlidateInPut(
                                val: addressTitle.text,
                                min: 3,
                                max: 100,
                              );
                              if (titleError != null) {
                                showCustomGetSnack(
                                  isGreen: false,
                                  text: StringTranslateExtension(
                                    LocaleKeys.add_location_title_required,
                                  ).tr(),
                                );
                                return;
                              }
                              Navigator.pop(context);
                              Navigator.pop(
                                context,
                                UseOnceAddress(
                                  locationStr: addressTitle.text,
                                  latitude: widget.latLngg.latitude,
                                  longitude: widget.latLngg.longitude,
                                ),
                              );
                            },
                          ),
                        ),
                    ],
                  ),
                ),

                SizedBox(height: 250.h),
              ],
            ),
          ),
        );
      },
    );
  }
}
