import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:negmt_heliopolis/controller/map/addresse_controller.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/handlingdataviwe.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/helper.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/validate.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/widgets/custom_button.dart';
import 'package:negmt_heliopolis/features/Widgets/custtextfeld.dart';
import 'package:negmt_heliopolis/features/maps/model/address_model.dart';
import 'package:negmt_heliopolis/generated/locale_keys.g.dart';

class EditLocation extends StatefulWidget {
  final Address address;

  const EditLocation({super.key, required this.address});

  @override
  State<EditLocation> createState() => _EditLocationState();
}

class _EditLocationState extends State<EditLocation> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  late final TextEditingController addressTitle;
  late final TextEditingController street;
  late final TextEditingController buildingNumber;
  late final TextEditingController floor;
  late final TextEditingController apartment;

  @override
  void initState() {
    super.initState();
    addressTitle = .new(text: widget.address.locationStr);
    street = .new(text: widget.address.street);
    buildingNumber = .new(text: widget.address.buildingNo);
    floor = .new(text: widget.address.floor);
    apartment = .new(text: widget.address.department);
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
    return GetBuilder<AddressesControllerImpl>(
      id: 'updateAddresses',
      builder: (controller) {
        return Form(
          key: formkey,
          child: GestureDetector(
            onTap: () => Get.back(),
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
                      return vlidateInPut(val: val!, min: 3, max: 100);
                    },
                  ),
                  SizedBox(height: 20.h),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Handlingdataviwe(
                      shimmer: Helper.loadingWidget(),
                      statusrequest: controller.updateAddressesstatusrequest,
                      widget: CustomButton(
                        backgroundColor: MyColors.mainColor,
                        textColor: Colors.white,
                        text: StringTranslateExtension(
                          LocaleKeys.add_location_edit,
                        ).tr(),
                        onTap: () async {
                          if (formkey.currentState!.validate()) {
                            Address address = Address(
                              id: widget.address.id,
                              locationStr: addressTitle.text,
                              street: street.text,
                              department: apartment.text,
                              buildingNo: buildingNumber.text,
                              floor: floor.text,
                            );
                            controller.updateAddress(address);
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 250.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
