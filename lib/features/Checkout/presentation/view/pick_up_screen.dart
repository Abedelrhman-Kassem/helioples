import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/db_helper.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/helper.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/custom_getx_snak_bar.dart';
import 'package:negmt_heliopolis/core/widgets/custom_snack_bar.dart';
import 'package:negmt_heliopolis/core/widgets/return_arrow.dart';
import 'package:negmt_heliopolis/features/Checkout/data/model/branches_model.dart';
import 'package:negmt_heliopolis/features/Checkout/data/model/create_order_model.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/checkout_delivery_screen.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/widgets/alternative_container.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/widgets/banches_row.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/widgets/item_widget.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/widgets/payment_details.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/widgets/promo_code_container.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/widgets/time_container.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view_model/create_order_cubit/create_order_cubit.dart';
import 'package:negmt_heliopolis/generated/locale_keys.g.dart';

class PickUpScreen extends StatefulWidget {
  const PickUpScreen({super.key});

  @override
  State<PickUpScreen> createState() => _PickUpScreenState();
}

class _PickUpScreenState extends State<PickUpScreen> {
  List<Map<String, Object?>> tableValues = [];

  CreateOrderModel createOrderModel = CreateOrderModel(
    deliverMethod: OrderDeliverMethod.onBranch,
    paymentMethod: OrderPaymentMethod.cashOnDelivery,
    chooseForMe: true,
    alternativeProduct: AlternativeProductType.call,
  );

  late BranchesModel branchesModel;

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

    branchesModel = BranchesModel.fromJson({});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateOrderCubit()
        ..getBranches()
        ..checkPaymentGateway(),
      child: BlocConsumer<CreateOrderCubit, CreateOrderState>(
        listener: (context, state) async {
          CreateOrderCubit createOrderCubit = BlocProvider.of<CreateOrderCubit>(
            context,
          );

          if (state is CreateOrderSuccess) {
            if (createOrderCubit.branch == null) {
              CustomSnackBar.show(
                context: context,
                duration: const Duration(seconds: 10),
                text: LocaleKeys.pick_up_screen_the_branch_is_null.tr(),
                isGreen: false,
              );
              return;
            }

            Navigator.pushNamed(
              context,
              pickupOrderDetails,
              arguments: {
                "order": state.orderDetailsModel,
                "branch": createOrderCubit.branch,
              },
            );
          }

          if (state is CreateOrderFailed) {
            showCustomGetSnack(isGreen: false, text: state.error);
          }

          if (state is BranchesSuccess) {
            branchesModel = state.branchesModel;
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: returnArrow(
                context: context,
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              title: Text(LocaleKeys.pick_up_screen_checkout.tr()),
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
                            LocaleKeys.pick_up_screen_order_items.tr(),
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
                      isDelivery: false,
                      title: LocaleKeys.pick_up_screen_pickup_time.tr(),
                      createOrderModel: createOrderModel,
                    ),
                    if (state is BranchesLoading)
                      Helper.loadingWidget()
                    // else if (state is BranchesFailed)
                    //   Text(state.error)
                    else if (branchesModel.data != null)
                      BranchesRow(
                        branchesModel: branchesModel,
                        createOrderModel: createOrderModel,
                      ),
                    PromoCodeContainer(createOrderModel: createOrderModel),
                    PaymentDetails(createOrderModel: createOrderModel),
                    AlternativeContainer(createOrderModel: createOrderModel),
                    SizedBox(height: 160.h),
                  ],
                ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
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
