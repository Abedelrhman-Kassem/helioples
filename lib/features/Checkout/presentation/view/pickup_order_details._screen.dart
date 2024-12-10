import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/utlis/cubit/main_cubit.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/return_arrow.dart';
import 'package:negmt_heliopolis/core/widgets/svg_asset.dart';
import 'package:negmt_heliopolis/features/Checkout/data/model/branches_model.dart';
import 'package:negmt_heliopolis/features/Checkout/data/model/order_details_model.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/checkout_details_screen.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/widgets/item_widget.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/widgets/shipping_details_container.dart';

class PickupOrderDetails extends StatefulWidget {
  final OrderDetailsModel orderDetailsModel;
  final Branches branch;
  const PickupOrderDetails({
    super.key,
    required this.orderDetailsModel,
    required this.branch,
  });

  @override
  State<PickupOrderDetails> createState() => _PickupOrderDetailsState();
}

class _PickupOrderDetailsState extends State<PickupOrderDetails> {
  List<Map<String, Object?>> tableValues = [];
  late OrderDetailsModel order;

  @override
  void initState() {
    order = widget.orderDetailsModel;

    tableValues = BlocProvider.of<MainCubit>(context).tableValues!;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          homeLayout,
          (route) => false,
        );
      },
      child: Scaffold(
        appBar: AppBar(
          leading: returnArrow(
            context: context,
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                homeLayout,
                (route) => false,
              );
            },
          ),
          title: const Text('Order Details'),
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
                shippingDetailsContainer(order),
                Container(
                  padding: EdgeInsets.all(20.r),
                  margin: EdgeInsets.symmetric(vertical: 20.h),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order Items',
                        style: Styles.styles17w700Black,
                      ),
                      SizedBox(height: 20.h),
                      ListView.builder(
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Pickup Branch",
                        style: Styles.styles17w700Black,
                      ),
                      SizedBox(
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              svgIcon(
                                path: 'assets/svg_icons/location.svg',
                                width: 21.w,
                                height: 21.h,
                                color: const Color.fromRGBO(71, 71, 71, 1),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              SizedBox(
                                height: 240.h,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      widget.branch.name!,
                                      style: Styles.styles16w400NormalBlack,
                                    ),
                                    Text(
                                      'Omar Ibn Al Khatab Street 436A',
                                      style: Styles.styles12w400black,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          trailing: Container(
                            width: 17.w,
                            height: 17.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color.fromRGBO(248, 147, 31, 1),
                                width: 0.88.r,
                              ),
                            ),
                            child: Align(
                              child: Container(
                                width: 6.38.w,
                                height: 6.38.h,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color.fromRGBO(248, 147, 31, 1),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                paymentDetails(context, order),
                SizedBox(
                  height: 160.h,
                ),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: bottomSheet(
          context,
          order,
        ),
      ),
    );
  }
}
