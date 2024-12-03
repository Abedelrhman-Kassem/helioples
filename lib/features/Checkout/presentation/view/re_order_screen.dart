import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/db_helper.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/return_arrow.dart';
import 'package:negmt_heliopolis/core/widgets/svg_asset.dart';
import 'package:negmt_heliopolis/features/Checkout/data/model/create_order_model.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/widgets/delivery_address_container.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/widgets/delivery_payment_contianer.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/widgets/exit_order_bottom_sheet.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/widgets/time_container.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/widgets/delivery_tips_contianer.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/widgets/item_widget.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/widgets/payment_details.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/widgets/promo_code_container.dart';

class ReOrderScreen extends StatefulWidget {
  const ReOrderScreen({super.key});

  @override
  State<ReOrderScreen> createState() => _ReOrderScreenState();
}

class _ReOrderScreenState extends State<ReOrderScreen> {
  List<Map<String, Object?>> tableValues = [];

  CreateOrderModel createOrderModel = CreateOrderModel(
    deliverMethod: 'Delivery',
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

        createOrderModel = CreateOrderModel(
          items: itemsArray,
        );
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        return await showModalBottomSheet(
          context: context,
          builder: (context) {
            return exitOrderBottomSheet(context);
          },
        );
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
                              Navigator.pushNamed(
                                  context, checkoutDetailsScreen);
                            },
                            borderRadius: BorderRadius.circular(40.r),
                            splashColor: MyColors.mainColor.withOpacity(0.5),
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  svgIcon(
                                    path: 'assets/svg_icons/3d-rotate.svg',
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
                paymentDetails(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
