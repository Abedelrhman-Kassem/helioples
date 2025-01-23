import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/utlis/cubit/main_cubit.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/add_widget.dart';
import 'package:negmt_heliopolis/core/widgets/delivery_address_widget.dart';
import 'package:negmt_heliopolis/features/homeScreen/data/model/address_model.dart';

class DeliveryAddressContainer extends StatefulWidget {
  const DeliveryAddressContainer({super.key});

  @override
  State<DeliveryAddressContainer> createState() =>
      _DeliveryAddressContainerState();
}

class _DeliveryAddressContainerState extends State<DeliveryAddressContainer> {
  String addressRadioValue = 'Home';
  late AddressModel addressModel;
  late MainCubit mainCubit;
  int? addressId;

  @override
  void initState() {
    mainCubit = BlocProvider.of<MainCubit>(context);
    addressModel = mainCubit.mainaddressModel;
    addressId = mainCubit.address!.id;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {},
      builder: (context, state) {
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
              SizedBox(height: 10.h),
              ListView.builder(
                // physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: addressModel.address!.length,
                itemBuilder: (context, index) => deliveryAddressWidget(
                  title: addressModel.address![index].locationStr!,
                  location: addressModel.address![index].street!,
                  isChossen: addressId == addressModel.address![index].id,
                  onTap: () {
                    setState(() {
                      addressId = addressModel.address![index].id;
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
