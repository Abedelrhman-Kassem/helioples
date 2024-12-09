import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/db_helper.dart';
import 'package:negmt_heliopolis/core/widgets/return_arrow.dart';
import 'package:negmt_heliopolis/core/widgets/svg_asset.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/widgets/banches_row.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/widgets/exit_order_bottom_sheet.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/widgets/item_widget.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/widgets/payment_details.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/widgets/promo_code_container.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/widgets/re_order_container.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/widgets/time_container.dart';

class PickupReorderScreen extends StatefulWidget {
  const PickupReorderScreen({super.key});

  @override
  State<PickupReorderScreen> createState() => _PickupReorderScreenState();
}

class _PickupReorderScreenState extends State<PickupReorderScreen> {
  List<Map<String, Object?>> tableValues = [];

  @override
  void initState() {
    DBHelper.queryData(table: cartItemTable).then((value) {
      setState(() {
        tableValues = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(100.r),
                onTap: () async {
                  return await showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return exitOrderBottomSheet(context);
                    },
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1.22.r,
                      color: const Color.fromRGBO(0, 0, 0, 0.1),
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: svgIcon(
                    path: 'assets/svg_icons/x-close.svg',
                    width: 22.93.w,
                    height: 22.93.h,
                    color: const Color.fromRGBO(36, 36, 36, 1),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                    'assets/screens_background/grocery_itemsback_ground.png'))),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const ReOrderContainer(route: pickupOrderDetails),
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
                      imageUrl: tableValues[index][cartItemImageUrl] as String,
                      price: tableValues[index][cartItemPrice] as double,
                    );
                  },
                  itemCount: tableValues.length,
                ),
              ),
              timeScheduleContainer(context, 'Pickup Time'),
              // const BranchesRow(),
              const PromoCodeContainer(),
              // PaymentDetails(createOrderModel: createOrderModel,),
            ],
          ),
        ),
      ),
    );
  }
}
