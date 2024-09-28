import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/widgets/return_arrow.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/checkout_delivery_screen.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/widgets/banches_row.dart';

import 'package:negmt_heliopolis/features/Checkout/presentation/view/widgets/item_widget.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/widgets/payment_details.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/widgets/promo_code_container.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/widgets/time_container.dart';

class PickUpScreen extends StatelessWidget {
  const PickUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: returnArrow(
            context: context,
            onTap: () {
              Navigator.of(context).pop();
            }),
        title: const Text('Checkout'),
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
              Container(
                padding: EdgeInsets.all(20.r),
                margin: EdgeInsets.symmetric(vertical: 20.h ) ,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(15.r),

                ),
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context , index)
                  {
                    return itemWidget();
                  }  ,
                  itemCount: 4 ,
                ),

              ),
              timeScheduleContainer(context , 'Pickup Time'),
              const BranchesRow(),
              
              const PromoCodeContainer(),
              paymentDetails(),
              SizedBox(height: 160.h),

            ],
          ),
        ),
      ),
      bottomSheet: bottomSheet(context , pickupOrderDetails),
    );
  }
}
