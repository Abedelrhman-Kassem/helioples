import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:negmt_heliopolis/controller/map/addresse_controller.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/handlingdataviwe.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/validate.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/widgets/custom_button.dart';
import 'package:negmt_heliopolis/features/Widgets/custtextfeld.dart';
import 'package:negmt_heliopolis/features/maps/model/address_model.dart';

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
    addressTitle = TextEditingController(text: widget.address.locationStr);
    street = TextEditingController(text: widget.address.street);
    buildingNumber = TextEditingController(text: widget.address.buildingNo);
    floor = TextEditingController(text: widget.address.floor);
    apartment = TextEditingController(text: widget.address.department);
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
          child: SingleChildScrollView(
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
                    return vlidateInPut(val: val!, min: 3, max: 100);
                  },
                ),
                Custtextfeld(
                  hint: "building number",
                  controller: buildingNumber,
                  validator: (val) {
                    return vlidateInPut(val: val!, min: 3, max: 100);
                  },
                ),
                Custtextfeld(
                  hint: "department",
                  controller: apartment,
                  validator: (val) {
                    return vlidateInPut(val: val!, min: 3, max: 100);
                  },
                ),
                SizedBox(height: 20.h),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Handlingdataviwe(
                    shimmer: CircularProgressIndicator(
                      color: MyColors.mainColor,
                    ),
                    statusrequest: controller.updateAddressesstatusrequest,
                    widget: CustomButton(
                      backgroundColor: MyColors.mainColor,
                      textColor: Colors.white,
                      text: "edit",
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
              ],
            ),
          ),
        );
      },
    );
  }
}
