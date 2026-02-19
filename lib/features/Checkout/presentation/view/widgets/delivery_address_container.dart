import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:negmt_heliopolis/controller/map/addresse_controller.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/add_widget.dart';
import 'package:negmt_heliopolis/core/widgets/delivery_address_widget.dart';
import 'package:negmt_heliopolis/features/Checkout/data/model/create_order_model.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view_model/create_order_cubit/create_order_cubit.dart';
import 'package:negmt_heliopolis/features/maps/model/address_model.dart';
import 'package:negmt_heliopolis/generated/locale_keys.g.dart';

class DeliveryAddressContainer extends StatefulWidget {
  final CreateOrderModel createOrderModel;

  const DeliveryAddressContainer({super.key, required this.createOrderModel});

  @override
  State<DeliveryAddressContainer> createState() =>
      _DeliveryAddressContainerState();
}

class _DeliveryAddressContainerState extends State<DeliveryAddressContainer> {
  AddressModel? addressModel;
  late AddressesControllerImpl addressesControllerImpl;
  bool isUsOne = false;

  bool _isFirstBuild = true;

  @override
  void initState() {
    addressesControllerImpl = Get.find<AddressesControllerImpl>();
    // if (addressesControllerImpl.mainAddressModel == addressModel) {
    //   log("not equal");
    // }
    addressModel = addressesControllerImpl.mainAddressModel;
    if (addressesControllerImpl.address?.id != null) {
      widget.createOrderModel.addressId = addressesControllerImpl.address!.id!;
    }
    super.initState();

    // if (addressesControllerImpl.mainAddressModel == addressModel) {
    //   log("gggggggggggggggggggggggg-----------0");
    // }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isFirstBuild) {
      _isFirstBuild = false;
      if (widget.createOrderModel.addressId?.isNotEmpty ?? false) {
        context.read<CreateOrderCubit>().calculateFee(
          addressId: widget.createOrderModel.addressId,
        );
      }
    }
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
                  Text(
                    StringTranslateExtension(
                      LocaleKeys.location_widget_delivery_address,
                    ).tr(),
                    style: Styles.styles17w700Black,
                  ),
                  addWidget(
                    text: StringTranslateExtension(
                      LocaleKeys.location_widget_add_address,
                    ).tr(),
                    onTap: () async {
                      final result = await Navigator.pushNamed(
                        context,
                        addAddressScreen,
                        arguments: {'isUsOne': true},
                      );
                      if (addressesControllerImpl.mainAddressModel !=
                          addressModel) {
                        setState(() {
                          addressModel =
                              addressesControllerImpl.mainAddressModel;
                        });
                      }
                      if (result != null && result is UseOnceAddress) {
                        setState(() {
                          isUsOne = true;
                          addressesControllerImpl.usOneAddress = result;
                          widget.createOrderModel.useOnceAddress = result;
                          widget.createOrderModel.addressId = null;
                          context.read<CreateOrderCubit>().calculateFee(
                            lat: result.latitude,
                            long: result.longitude,
                          );
                        });
                      }
                    },
                  ),
                ],
              ),
              SizedBox(height: 10.h),

              isUsOne
                  ? deliveryAddressWidget(
                      title:
                          addressesControllerImpl.usOneAddress?.locationStr ??
                          '',
                      isChossen: true,
                      isUsOne: true,
                      onEdit: () {
                        setState(() {
                          isUsOne = false;
                          addressesControllerImpl.usOneAddress = null;
                          widget.createOrderModel.useOnceAddress = null;
                          if (addressesControllerImpl.address?.id != null) {
                            widget.createOrderModel.addressId =
                                addressesControllerImpl.address!.id!;
                            context.read<CreateOrderCubit>().calculateFee(
                              addressId: widget.createOrderModel.addressId,
                            );
                          }
                        });
                      },
                    )
                  : ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: addressModel?.address.length ?? 0,
                      itemBuilder: (context, index) => deliveryAddressWidget(
                        title: addressModel!.address[index].locationStr ?? '',
                        location: addressModel!.address[index].street ?? '',
                        isChossen:
                            addressesControllerImpl.address?.id ==
                            addressModel!.address[index].id,
                        onTap: () {
                          setState(() {
                            addressesControllerImpl.address =
                                addressModel!.address[index];
                            addressesControllerImpl.setChossenAddress(
                              addressesControllerImpl.address!.id!,
                            );
                            widget.createOrderModel.addressId =
                                addressesControllerImpl.address!.id!;
                            widget.createOrderModel.useOnceAddress = null;
                            context.read<CreateOrderCubit>().calculateFee(
                              addressId: widget.createOrderModel.addressId,
                            );
                          });
                        },
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }
}
