import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/return_arrow.dart';
import 'package:negmt_heliopolis/features/Checkout/data/model/create_order_model.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/widgets/alternative_container.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/widgets/delivery_address_container.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/widgets/delivery_payment_contianer.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/widgets/time_container.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/widgets/delivery_tips_contianer.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/widgets/item_widget.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/widgets/payment_details.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/widgets/promo_code_container.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view_model/delivery_cubit/delivery_cubit.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});
//       {
//     "deliverMethod": "Delivery",
//     "paymentMethod": "cashOnDelivery",
//     "tips": 20,
//     "alternativeProduct": "whatsapp",
//     // "branchId": "1",
//     "addressId": 1,
//     "chooseForMe":false,
//     "promoCode": null,
//     "items": [
//         {
//             "productId": 1628,
//             "number": 1
//         },
//         {
//             "productId": 1627,
//             "number": 5
//         }
//     ]
// }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeliveryCubit, DeliveryState>(
      listener: (context, state) {
        if (state is CreateOrderFailed) {
          print(state.error);
        }
      },
      builder: (context, state) {
        CreateOrderModel createOrderModel = CreateOrderModel(
          deliverMethod: 'Delivery',
          items: [
            Items(
              productId: 1,
              number: 2,
            ),
          ],
        );

        BlocProvider.of<DeliveryCubit>(context).printing();

        return Scaffold(
          appBar: AppBar(
            leading: returnArrow(
              context: context,
              onTap: () {
                Navigator.pop(context);
              },
            ),
            title: const Text('Checkout'),
          ),
          body: Container(
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/screens_background/grocery_itemsback_ground.png',
                ),
              ),
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(20.r),
                    margin: EdgeInsets.symmetric(vertical: 20.h),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return itemWidget();
                      },
                      itemCount: 4,
                    ),
                  ),
                  timeScheduleContainer(context, 'Delivery Time'),
                  const DeliveryAddressContainer(),
                  const DeliveryPaymentContianer(),
                  const DeliveryTipsContianer(),
                  const PromoCodeContainer(),
                  paymentDetails(),
                  const AlternativeContainer(),
                  SizedBox(height: 160.h),
                ],
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: bottomSheet(context, checkoutDetailsScreen),
        );
      },
    );
  }
}

Widget bottomSheet(BuildContext context, String route) {
  return Container(
    padding: EdgeInsets.all(20.r),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15.r),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 20.h),
          padding: EdgeInsets.only(
            left: 5.w,
            right: 5.w,
            bottom: 5.w,
          ),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Color.fromRGBO(210, 210, 210, 1),
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Price',
                style: Styles.styles18w500BlackWhite,
              ),
              Text(
                '214 EGP',
                style: Styles.styles18w800Black,
              ),
            ],
          ),
        ),
        Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(36.77.r),
            splashColor: MyColors.mainColor,
            onTap: () {
              try {
                // BlocProvider.of<DeliveryCubit>(context).createOrder();
              } catch (e) {
                //
              }

              Navigator.pushNamed(context, route);
            },
            child: Container(
              width: 284.w,
              height: 58.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(36.77.r),
                color: MyColors.mainColor.withOpacity(.9),
              ),
              child: Text(
                'Place Order',
                style: Styles.styles17w500NormalWhite,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
