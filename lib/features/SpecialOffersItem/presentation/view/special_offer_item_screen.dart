import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/models/language/app_localizations.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/special_offer_widget.dart';
import 'package:negmt_heliopolis/features/SpecialOffersItem/presentation/view/widgets/item_widget.dart';

class SpecialOfferItemScreen extends StatelessWidget {
  const SpecialOfferItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Special Offers'.tr(context),
          style: Styles.styles16w700interFamily,
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(17.0.r),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              specialOfferWidget(
                context: context,
                assetImagePath: 'assets/test_images/offers.png',
                upToOfferWidget: () => upToOfferWidget(
                  iconHeight: 17,
                  iconWidth: 17,
                  context: context,
                  text: Text(
                    'Up to 20% off',
                    style: Styles.styles9w500interFamily.copyWith(
                      color: const Color.fromRGBO(255, 255, 255, 1),
                    ),
                  ),
                ),
                descriptionOfferWidget: () => descriptionOfferWidget(
                  titleText: Text(
                    'Seasonal Offers',
                    style: Styles.styles17w700interFamily,
                  ),
                  offerRichText: RichText(
                    text: TextSpan(
                      text: 'Offer Ends At ',
                      style: Styles.styles12w400interFamily,
                      children: [
                        TextSpan(
                          text: '1 Day 16 Hours',
                          style: Styles.styles12w500interFamily,
                        )
                      ],
                    ),
                  ),
                  beneficiaryText: RichText(
                    text: TextSpan(
                      text: 'Beneficiary ',
                      style: Styles.styles12w400interFamily,
                      children: [
                        TextSpan(
                          text: '33',
                          style: Styles.styles12w800interFamily,
                        )
                      ],
                    ),
                  ),
                  iconWidth: 13.66,
                  iconHeight: 13.66,
                ),
              ),
              SizedBox(height: 30.h),
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 5,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 150,
                  crossAxisSpacing: 7,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.25 / 2.25,
                ),
                itemBuilder: (context, index) => const ItemWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}