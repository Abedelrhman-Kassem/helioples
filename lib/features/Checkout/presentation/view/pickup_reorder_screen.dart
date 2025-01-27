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
import 'package:negmt_heliopolis/features/Checkout/data/model/branches_model.dart';
import 'package:negmt_heliopolis/features/Checkout/data/model/create_order_model.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/widgets/alternative_container.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/widgets/banches_row.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/widgets/exit_order_bottom_sheet.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/widgets/item_widget.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/widgets/payment_details.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/widgets/promo_code_container.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/widgets/time_container.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view_model/create_order_cubit/create_order_cubit.dart';

class PickupReorderScreen extends StatefulWidget {
  const PickupReorderScreen({super.key});

  @override
  State<PickupReorderScreen> createState() => _PickupReorderScreenState();
}

class _PickupReorderScreenState extends State<PickupReorderScreen> {
  List<Map<String, Object?>> tableValues = [];
  late CreateOrderModel createOrderModel;

  late BranchesModel branchesModel;

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
      deliverMethod: 'OnBranch',
      // deliverTimeId: 2,
      paymentMethod: 'cashOnDelivery',
      chooseForMe: true,
      alternativeProduct: 'call',
      items: itemsArray,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateOrderCubit()..getBranches(),
      child: BlocConsumer<CreateOrderCubit, CreateOrderState>(
        listener: (context, state) async {
          CreateOrderCubit createOrderCubit =
              BlocProvider.of<CreateOrderCubit>(context);

          if (state is CreateOrderSuccess) {
            if (createOrderCubit.branch == null) {
              CustomSnackBar.show(
                context: context,
                duration: const Duration(seconds: 10),
                text: 'the branch is null',
                isGreen: false,
              );
              return;
            }

            await BlocProvider.of<MainCubit>(context).clearDb();

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
            CustomSnackBar.show(
              context: context,
              duration: const Duration(seconds: 10),
              text: state.error,
              isGreen: false,
            );
          }

          if (state is BranchesSuccess) {
            branchesModel = state.branchesModel;
          }
        },
        builder: (context, state) {
          return PopScope(
            canPop: false,
            onPopInvoked: (didPop) async {
              if (state is! CreateOrderLoading) {
                return await showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return exitOrderBottomSheet(context);
                  },
                );
              }
            },
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                leading: returnArrow(
                    context: context,
                    onTap: () async {
                      return await showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return exitOrderBottomSheet(context);
                        },
                      );
                    }),
                title: const Text('Checkout'),
                // actions: [
                //   Padding(
                //     padding: EdgeInsets.symmetric(horizontal: 10.w),
                //     child: Material(
                //       color: Colors.transparent,
                //       child: InkWell(
                //         borderRadius: BorderRadius.circular(100.r),
                //         onTap: () async {
                //           return await showModalBottomSheet(
                //             context: context,
                //             builder: (context) {
                //               return exitOrderBottomSheet(context);
                //             },
                //           );
                //         },
                //         child: Container(
                //           decoration: BoxDecoration(
                //             border: Border.all(
                //               width: 1.22.r,
                //               color: const Color.fromRGBO(0, 0, 0, 0.1),
                //             ),
                //             shape: BoxShape.circle,
                //           ),
                //           child: svgIcon(
                //             path: 'assets/svg_icons/x-close.svg',
                //             width: 22.93.w,
                //             height: 22.93.h,
                //             color: const Color.fromRGBO(36, 36, 36, 1),
                //           ),
                //         ),
                //       ),
                //     ),
                //   ),
                // ],
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
                              'You can edit order’s terms and re-order',
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
                                      MyColors.mainColor.withOpacity(0.5),
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
                                          'Re-Order',
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
                        title: 'PickUp Time',
                        createOrderModel: createOrderModel,
                      ),
                      if (state is BranchesLoading)
                        Helper.loadingWidget()
                      else if (state is BranchesFailed)
                        Text(state.error)
                      else
                        BranchesRow(
                          branchesModel: branchesModel,
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
