import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:negmt_heliopolis/controller/map/addresse_controller.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/add_widget.dart';
import 'package:negmt_heliopolis/core/widgets/delivery_address_widget.dart';
import 'package:negmt_heliopolis/features/Checkout/data/model/create_order_model.dart';
import 'package:negmt_heliopolis/features/maps/model/address_model.dart';

class DeliveryAddressContainer extends StatefulWidget {
  final CreateOrderModel createOrderModel;

  const DeliveryAddressContainer({super.key, required this.createOrderModel});

  @override
  State<DeliveryAddressContainer> createState() =>
      _DeliveryAddressContainerState();
}

class _DeliveryAddressContainerState extends State<DeliveryAddressContainer> {
  late AddressModel addressModel;
  late AddressesControllerImpl addressesControllerImpl;
  // late MainCubit mainCubit;

  @override
  void initState() {
    addressesControllerImpl = Get.find<AddressesControllerImpl>();
    // mainCubit = BlocProvider.of<MainCubit>(context);
    addressModel = addressesControllerImpl.mainAddressModel!;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddressesControllerImpl>(
      builder: (controller) {
        return Container(
          padding: EdgeInsets.all(20.r),
          margin: EdgeInsets.symmetric(vertical: 10.h),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(15.r),
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
                      Navigator.pushNamed(context, setLocationScreen);
                    },
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: addressModel.address.length,
                itemBuilder: (context, index) => deliveryAddressWidget(
                  title: addressModel.address[index].locationStr!,
                  location: addressModel.address[index].street!,
                  isChossen:
                      addressesControllerImpl.address!.id ==
                      addressModel.address[index].id,
                  onTap: () {
                    setState(() {
                      addressesControllerImpl.address =
                          addressModel.address[index];
                      addressesControllerImpl.setChossenAddress(
                        addressesControllerImpl.address!.id!,
                      );
                      widget.createOrderModel.addressId =
                          addressesControllerImpl.address!.id!;
                    });
                  },

                  onEdit: () {},
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
