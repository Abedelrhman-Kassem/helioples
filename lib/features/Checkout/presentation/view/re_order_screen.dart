import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/utlis/cubit/main_cubit.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/helper.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/custom_snack_bar.dart';
import 'package:negmt_heliopolis/core/widgets/return_arrow.dart';
import 'package:negmt_heliopolis/core/widgets/svg_asset.dart';
import 'package:negmt_heliopolis/features/Checkout/data/model/create_order_model.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/widgets/alternative_container.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/widgets/delivery_address_container.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/widgets/delivery_payment_contianer.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/widgets/exit_order_bottom_sheet.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/widgets/time_container.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/widgets/delivery_tips_contianer.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/widgets/item_widget.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/widgets/payment_details.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/widgets/promo_code_container.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view_model/create_order_cubit/create_order_cubit.dart';
import 'package:negmt_heliopolis/generated/locale_keys.g.dart';

class ReOrderScreen extends StatefulWidget {
  const ReOrderScreen({
    super.key,
  });

  @override
  State<ReOrderScreen> createState() => _ReOrderScreenState();
}

class _ReOrderScreenState extends State<ReOrderScreen> {
  late List<Map<String, Object?>> tableValues;
  late CreateOrderModel createOrderModel;

  @override
  void initState() {
    tableValues = BlocProvider.of<MainCubit>(context).tableValues!;

    List<Item> itemsArray = [];
    for (var value in tableValues) {
      itemsArray.add(
        Item(
          productId: value[cartItemId] as int,
          number: value[cartItemQty] as int,
        ),
      );
    }

    createOrderModel = CreateOrderModel(
      deliverMethod: 'Delivery',
      items: itemsArray,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateOrderCubit(),
      child: BlocConsumer<CreateOrderCubit, CreateOrderState>(
        listener: (context, state) async {
          if (state is CreateOrderFailed) {
            CustomSnackBar.show(
              context: context,
              duration: const Duration(seconds: 10),
              text: state.error,
              isGreen: false,
            );
          }

          if (state is CreateOrderSuccess) {
            await BlocProvider.of<MainCubit>(context).clearDb();

            Navigator.pushNamed(
              context,
              checkoutDetailsScreen,
              arguments: state.orderDetailsModel,
            );
          }
        },
        builder: (context, state) {
          return PopScope(
            canPop: false,
            onPopInvokedWithResult: (didPop, result) async {
              if (state is! CreateOrderLoading) {
                return await showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return exitOrderBottomSheet(context);
                  },
                );
              }
            },
            // onPopInvoked: (didPop) async {
            //   if (state is! CreateOrderLoading) {
            //     return await showModalBottomSheet(
            //       context: context,
            //       builder: (context) {
            //         return exitOrderBottomSheet(context);
            //       },
            //     );
            //   }
            // },
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                leading: returnArrow(
                  context: context,
                  onTap: () async {
                    if (state is! CreateOrderLoading) {
                      return await showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return exitOrderBottomSheet(context);
                        },
                      );
                    }
                  },
                ),
                title: Text(
                  LocaleKeys.checkout_delivery_screen_checkout.tr(),
                ),
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
                        width: double.infinity,
                        padding: EdgeInsets.all(20.r),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                        child: Column(
                          children: [
                            Text(
                              LocaleKeys.re_order_screen_edit_order_terms.tr(),
                              style: Styles.styles17w400interFamily,
                            ),
                            SizedBox(height: 10.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 18.w),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    BlocProvider.of<CreateOrderCubit>(context)
                                        .createOrder(createOrderModel);
                                  },
                                  borderRadius: BorderRadius.circular(40.r),
                                  splashColor:
                                      MyColors.mainColor.withValues(alpha: 0.5),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 64.w,
                                      vertical: 20.h,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: MyColors.mainColor,
                                        width: 2.r,
                                      ),
                                      borderRadius: BorderRadius.circular(40.r),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        if (state is CreateOrderLoading)
                                          Helper.loadingWidget()
                                        else
                                          svgIcon(
                                            path:
                                                'assets/svg_icons/3d-rotate.svg',
                                            width: 24.w,
                                            height: 24.h,
                                            color: MyColors.mainColor,
                                          ),
                                        SizedBox(width: 5.w),
                                        Text(
                                          LocaleKeys.re_order_screen_re_order
                                              .tr(),
                                          style: Styles.styles17w500MainColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(20.r),
                        margin: EdgeInsets.symmetric(vertical: 20.h),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.9),
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return itemWidget(
                              quantity: tableValues[index][cartItemQty] as int,
                              name: tableValues[index][cartItemName] as String,
                              imageUrl: tableValues[index][cartItemImageUrl]
                                  as String,
                              price:
                                  tableValues[index][cartItemPrice] as double,
                            );
                          },
                          itemCount: tableValues.length,
                        ),
                      ),
                      TimeScheduleContainer(
                        title: LocaleKeys.re_order_screen_delivery_time.tr(),
                        createOrderModel: createOrderModel,
                      ),
                      DeliveryAddressContainer(
                        createOrderModel: createOrderModel,
                      ),
                      DeliveryPaymentContianer(
                        createOrderModel: createOrderModel,
                      ),
                      DeliveryTipsContianer(
                        createOrderModel: createOrderModel,
                      ),
                      PromoCodeContainer(
                        createOrderModel: createOrderModel,
                      ),
                      PaymentDetails(
                        createOrderModel: createOrderModel,
                      ),
                      AlternativeContainer(
                        createOrderModel: createOrderModel,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
