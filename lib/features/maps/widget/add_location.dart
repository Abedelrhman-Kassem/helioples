import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:negmt_heliopolis/controller/map/address_controller.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/handlingdataviwe.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/validate.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/widgets/custom_button.dart';
import 'package:negmt_heliopolis/features/maps/model/address_model.dart';
import 'package:negmt_heliopolis/features/Widgets/custtextfeld.dart';

class Addlocattion extends StatefulWidget {
  final LatLng latLngg;

  const Addlocattion({super.key, required this.latLngg});

  @override
  State<Addlocattion> createState() => _AddlocattionState();
}

class _AddlocattionState extends State<Addlocattion> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  late final TextEditingController addressTitle;
  late final TextEditingController street;
  late final TextEditingController buildingNumber;
  late final TextEditingController floor;
  late final TextEditingController apartment;

  @override
  void initState() {
    super.initState();
    final controller = Get.find<AddressControllerImpl>();
    addressTitle = TextEditingController(
      text: '${controller.country}-${controller.city}-${controller.street}',
    );
    street = TextEditingController(text: controller.street);
    buildingNumber = TextEditingController();
    floor = TextEditingController();
    apartment = TextEditingController();
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
            physics: const BouncingScrollPhysics(),
            child: Column(
              spacing: 10.h,
              children: [
                Custtextfeld(
                  hint: "address title",
                  controller: addressTitle,
                  validator: (val) {
                    return vlidateInPut(val: val!, min: 3, max: 100);
                  },
                ),
                Custtextfeld(
                  hint: "street",
                  controller: street,
                  validator: (val) {
                    return vlidateInPut(val: val!, min: 2, max: 100);
                  },
                ),
                Custtextfeld(
                  hint: "floor",
                  controller: floor,
                  validator: (val) {
                    return vlidateInPut(val: val!, min: 2, max: 100);
                  },
                ),
                Custtextfeld(
                  hint: "building number",
                  controller: buildingNumber,
                  validator: (val) {
                    return vlidateInPut(val: val!, min: 2, max: 100);
                  },
                ),
                Custtextfeld(
                  hint: "department",
                  controller: apartment,
                  validator: (val) {
                    return vlidateInPut(val: val!, min: 2, max: 100);
                  },
                ),
                SizedBox(height: 20.h),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Handlingdataviwe(
                    shimmer: CircularProgressIndicator(
                      color: MyColors.mainColor,
                    ),
                    statusrequest: controller.addAddressesstatusrequest,
                    widget: CustomButton(
                      backgroundColor: MyColors.mainColor,
                      textColor: Colors.white,

                      text: "Save",
                      onTap: () {
                        log("lat ${widget.latLngg.latitude}");
                        log("lng ${widget.latLngg.longitude}");
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
              ],
            ),
          ),
        );
      },
    );
  }
}
