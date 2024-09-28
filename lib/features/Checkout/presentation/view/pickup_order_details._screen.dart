import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/return_arrow.dart';
import 'package:negmt_heliopolis/core/widgets/svg_asset.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/checkout_details_screen.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/widgets/item_widget.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/widgets/shipping_details_container.dart';

class PickupOrderDetails extends StatelessWidget {
  const PickupOrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: returnArrow(
            context: context,
            onTap: () {
              Navigator.of(context).pop();
            }),
        title: const Text('Order Details'),
      ),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
            'assets/screens_background/grocery_itemsback_ground.png',
          )),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              shippingDetailsContainer(),
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
                                    "Eldabaa Branch",
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
                                width: 0.88.r),
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
              paymentContainer(),
              paymentDetails(context),
              SizedBox(height: 160.h,),
            ],
          ),
        ),
      ),
      bottomSheet: bottomSheet(context , pickupReorderScreen),
    );
  }
}
