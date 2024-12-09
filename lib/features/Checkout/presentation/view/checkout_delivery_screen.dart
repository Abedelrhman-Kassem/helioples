import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/db_helper.dart';
import 'package:negmt_heliopolis/core/utlis/notifiers/db_change_notifier.dart';
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
import 'package:negmt_heliopolis/features/Checkout/presentation/view_model/create_order_cubit/create_order_cubit.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  List<Map<String, Object?>> tableValues = [];
  CreateOrderModel createOrderModel = CreateOrderModel(
    deliverMethod: 'Delivery',
    deliverTimeId: 2,
    addressId: 2,
    chooseForMe: true,
  );

  @override
  void initState() {
    DBHelper.queryData(table: cartItemTable).then((value) {
      setState(() {
        tableValues = value;

        List<Item> itemsArray = [];
        for (var value in tableValues) {
          itemsArray.add(
            Item(
              productId: value[cartItemId] as int,
              number: value[cartItemQty] as int,
            ),
          );
        }

        createOrderModel.items = itemsArray;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateOrderCubit(),
      child: BlocConsumer<CreateOrderCubit, CreateOrderState>(
        listener: (context, state) {
          if (state is CreateOrderSuccess) {
            print(state.order);
          }
          if (state is CreateOrderFailed) {
            print(state.error);
          }
        },
        builder: (context, state) {
          BlocProvider.of<CreateOrderCubit>(context);

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
                          return itemWidget(
                            quantity: tableValues[index][cartItemQty] as int,
                            name: tableValues[index][cartItemName] as String,
                            imageUrl:
                                tableValues[index][cartItemImageUrl] as String,
                            price: tableValues[index][cartItemPrice] as double,
                          );
                        },
                        itemCount: tableValues.length,
                      ),
                    ),
                    timeScheduleContainer(context, 'Delivery Time'),
                    const DeliveryAddressContainer(),
                    DeliveryPaymentContianer(
                      createOrderModel: createOrderModel,
                    ),
                    DeliveryTipsContianer(
                      createOrderModel: createOrderModel,
                    ),
                    const PromoCodeContainer(),
                    PaymentDetails(
                      createOrderModel: createOrderModel,
                    ),
                    AlternativeContainer(
                      createOrderModel: createOrderModel,
                    ),
                    SizedBox(height: 160.h),
                  ],
                ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniCenterDocked,
            floatingActionButton: bottomSheet(
              context,
              checkoutDetailsScreen,
              createOrderModel,
            ),
            resizeToAvoidBottomInset: false,
          );
        },
      ),
    );
  }
}

Widget bottomSheet(
  BuildContext context,
  String route,
  CreateOrderModel createOrderModel,
) {
  CreateOrderCubit createOrderCubit =
      BlocProvider.of<CreateOrderCubit>(context);

  double promoCodeValue = createOrderCubit.promoCodeValue;
  final DbChangeNotifier dbChangeNotifier = DbChangeNotifier();
  dbChangeNotifier.fetchItemCount();

  double tips = createOrderModel.tips ?? 0;

  return BlocConsumer<CreateOrderCubit, CreateOrderState>(
    listener: (context, state) {
      if (state is TipsToBottomSheet) {
        tips = state.tips;
      }
    },
    builder: (context, state) {
      double totalPrice = tips +
          dbChangeNotifier.dbData.totalPrice -
          (dbChangeNotifier.dbData.totalDiscount + promoCodeValue);

      totalPrice = double.parse(totalPrice.toStringAsFixed(2));

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
                    '$totalPrice EGP',
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
                  // print(json.encode(createOrderModel));
                  createOrderCubit.createOrder(createOrderModel);

                  // Navigator.pushNamed(context, route);
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
    },
  );
}
