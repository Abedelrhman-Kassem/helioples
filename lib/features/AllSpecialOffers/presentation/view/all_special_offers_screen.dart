import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/special_offer_widget.dart';

class AllSpecialOffersScreen extends StatelessWidget {
  const AllSpecialOffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Special Offers',
          style: Styles.styles16w700interFamily,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(17.0.r),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 500,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  mainAxisExtent: 200,
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return specialOfferWidget(
                    context: context,
                    assetImagePath: 'assets/test_images/nestle-offer.png',
                    brandImagePath: 'assets/test_images/offer-brand.png',
                    onTap: () {
                      Navigator.pushNamed(context, specialOfferItemScreen);
                    },
                    upToOfferWidget: () => upToOfferWidget(
                      iconHeight: 18,
                      iconWidth: 18,
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
                        'Nestle Pure Life',
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
                      iconWidth: 18,
                      iconHeight: 18,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
