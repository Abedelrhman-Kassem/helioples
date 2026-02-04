import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/db_helper.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/helper.dart';
import 'package:negmt_heliopolis/core/utlis/notifiers/db_change_notifier.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/custom_getx_snak_bar.dart';
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
import 'package:negmt_heliopolis/generated/locale_keys.g.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  List<Map<String, Object?>> tableValues = [];
  CreateOrderModel createOrderModel = CreateOrderModel(
    deliverMethod: OrderDeliverMethod.delivery,
  );

  @override
  void initState() {
    DBHelper.queryData(table: cartTable).then((value) {
      setState(() {
        tableValues = value;

        List<Item> itemsArray = [];
        for (var value in tableValues) {
          itemsArray.add(
            Item(
              productId: value[cartItemId] as String,
              number: (value[cartItemQty] as num).toInt(),
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
      create: (context) => CreateOrderCubit()..checkPaymentGateway(),
      child: BlocConsumer<CreateOrderCubit, CreateOrderState>(
        listener: (context, state) async {
          if (state is CreateOrderSuccess) {
            Navigator.pushNamed(
              context,
              checkoutDetailsScreen,
              arguments: state.orderDetailsModel,
            );
          }

          if (state is CreateOrderFailed) {
            showCustomGetSnack(
              isGreen: false,
              text: state.error,
              isSnackOpen: false,
              duration: const Duration(seconds: 3),
            );
          }

          if (state is CalculateFeeFailed) {
            showCustomGetSnack(
              isGreen: false,
              text: state.error,
              isSnackOpen: false,
              duration: const Duration(seconds: 3),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: returnArrow(
                context: context,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(LocaleKeys.cart_modal_checkout.tr()),
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
                        color: Colors.white.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            LocaleKeys.checkout_delivery_screen_order_items
                                .tr(),
                            style: Styles.styles17w700Black,
                          ),
                          SizedBox(height: 20.h),
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return itemWidget(
                                quantity:
                                    (tableValues[index][cartItemQty] as num)
                                        .toDouble(),
                                name:
                                    tableValues[index][cartItemName] as String,
                                imageUrl:
                                    tableValues[index][cartItemImageUrl]
                                        as String,
                                price:
                                    (tableValues[index][cartItemPrice] as num)
                                        .toDouble(),
                              );
                            },
                            itemCount: tableValues.length,
                          ),
                        ],
                      ),
                    ),
                    TimeScheduleContainer(
                      isDelivery: true,
                      title: LocaleKeys.re_order_screen_delivery_time.tr(),
                      createOrderModel: createOrderModel,
                    ),
                    DeliveryAddressContainer(
                      createOrderModel: createOrderModel,
                    ),
                    DeliveryPaymentContianer(
                      createOrderModel: createOrderModel,
                    ),
                    DeliveryTipsContianer(createOrderModel: createOrderModel),
                    PromoCodeContainer(createOrderModel: createOrderModel),
                    PaymentDetails(createOrderModel: createOrderModel),
                    AlternativeContainer(createOrderModel: createOrderModel),
                    SizedBox(height: 160.h),
                  ],
                ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniCenterDocked,
            floatingActionButton: CheckOutBottomSheet(
              createOrderModel: createOrderModel,
            ),
            resizeToAvoidBottomInset: false,
          );
        },
      ),
    );
  }
}

class CheckOutBottomSheet extends StatefulWidget {
  final CreateOrderModel createOrderModel;
  const CheckOutBottomSheet({super.key, required this.createOrderModel});

  @override
  State<CheckOutBottomSheet> createState() => _CheckOutBottomSheetState();
}

class _CheckOutBottomSheetState extends State<CheckOutBottomSheet> {
  late CreateOrderCubit createOrderCubit;

  final DbChangeNotifier dbChangeNotifier = DbChangeNotifier();

  late double tips;
  double deliveryFee = 0;

  double promoCodeValue = 0;
  bool isPercentage = false;

  @override
  void initState() {
    createOrderCubit = BlocProvider.of<CreateOrderCubit>(context);

    tips = widget.createOrderModel.tips ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateOrderCubit, CreateOrderState>(
      listener: (context, state) {
        if (state is TipsToBottomSheet) {
          tips = state.tips;
        }

        if (state is CheckPromoCodeLoading || state is CheckPromoCodeFailed) {
          promoCodeValue = 0;
        }

        if (state is CheckPromoCodeSuccess) {
          showCustomGetSnack(
            isGreen: true,
            text: state.promoCodeModel.message ?? '',
          );
          promoCodeValue = state.promoCodeModel.data!.discount!;
          isPercentage = state.promoCodeModel.data!.isPercentage!;

          if (isPercentage) {
            promoCodeValue = createOrderCubit.calcPromoCode(
              dbChangeNotifier.dbData.totalPrice,
              promoCodeValue,
            );
          }
        }
        if (state is CalculateFeeSuccess) {
          deliveryFee = state.fee;
        }

        if (state is CalculateFeeLoading) {
          // We could set deliveryFee to 0 or keep previous, but total price might be inaccurate while loading.
          // For now, let's keep previous or 0.
        }
      },
      builder: (context, state) {
        double totalPrice =
            tips +
            dbChangeNotifier.dbData.totalPrice +
            deliveryFee -
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
                padding: EdgeInsets.only(left: 5.w, right: 5.w, bottom: 5.w),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Color.fromRGBO(210, 210, 210, 1)),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      LocaleKeys.cart_modal_total_price.tr(),
                      style: Styles.styles18w500BlackWhite,
                    ),
                    Flexible(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: AlignmentDirectional.centerEnd,
                        child: RichText(
                          text: Helper.priceSpan(
                            totalPrice,
                            Styles.styles18w800Black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (state is CreateOrderLoading)
                Helper.loadingWidget()
              else
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(36.77.r),
                    splashColor: MyColors.mainColor,
                    onTap: () {
                      if (widget.createOrderModel.isDelivery &&
                          widget.createOrderModel.addressId == null &&
                          widget.createOrderModel.useOnceAddress == null) {
                        showCustomGetSnack(
                          isGreen: false,
                          text: LocaleKeys
                              .checkout_delivery_screen_please_select_address
                              .tr(),
                        );
                        return;
                      }

                      log(
                        widget.createOrderModel.isDelivery
                            ? widget.createOrderModel
                                  .toDeliveryJson()
                                  .toString()
                            : widget.createOrderModel.toPickUpJson().toString(),
                      );
                      createOrderCubit.createOrder(widget.createOrderModel);
                    },
                    child: Container(
                      width: 284.w,
                      height: 58.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(36.77.r),
                        color: MyColors.mainColor.withValues(alpha: .9),
                      ),
                      child: Text(
                        LocaleKeys.checkout_delivery_screen_place_order.tr(),
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
}
