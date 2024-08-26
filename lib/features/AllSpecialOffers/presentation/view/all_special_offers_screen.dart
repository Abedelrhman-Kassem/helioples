import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/special_offer_widget.dart';
import 'package:negmt_heliopolis/features/AllSpecialOffers/presentation/view_model/cubit/all_special_offer_cubit.dart';

class AllSpecialOffersScreen extends StatelessWidget {
  const AllSpecialOffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AllSpecialOfferCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Special Offers',
            style: Styles.styles16w700interFamily,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0.r),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: BlocBuilder<AllSpecialOfferCubit, AllSpecialOfferState>(
              builder: (context, state) {
                AllSpecialOfferCubit allSpecialOffersCubit =
                    BlocProvider.of<AllSpecialOfferCubit>(context);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      splashRadius: 2,
                      onPressed: () {
                        allSpecialOffersCubit.changeGrid(
                            context, allspecialOffersScreen);
                      },
                      icon: Container(
                        width: 37.w,
                        height: 36.w,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(237, 237, 237, 1),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: allSpecialOffersCubit.isGrid
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(
                                      3,
                                      (index) {
                                        return Container(
                                          width: 9.53.w,
                                          height: 3.81.h,
                                          margin: EdgeInsets.symmetric(
                                              vertical: 2.h),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12.r),
                                            color: MyColors.mainColor,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 3.w),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(
                                      3,
                                      (index) {
                                        return Container(
                                          width: 9.53.w,
                                          height: 3.81.h,
                                          margin: EdgeInsets.symmetric(
                                              vertical: 2.h),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12.r),
                                            color: MyColors.mainColor,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  3,
                                  (index) {
                                    return Container(
                                      width: 20.77.w,
                                      height: 2.38.h,
                                      margin:
                                          EdgeInsets.symmetric(vertical: 2.h),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                        color: MyColors.mainColor,
                                      ),
                                    );
                                  },
                                ),
                              ),
                      ),
                    ),
                    allSpecialOffersCubit.isGrid
                        ? GridView.builder(
                            key: const ValueKey(1),
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 500,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 10,
                              mainAxisExtent: 220,
                            ),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return specialOfferWidget(
                                context: context,
                                assetImagePath:
                                    'assets/test_images/nestle-offer.png',
                                brandImagePath:
                                    'assets/test_images/offer-brand.png',
                                imageHeight: 145,
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, specialOfferItemScreen);
                                },
                                upToOfferWidget: () => upToOfferWidget(
                                  iconHeight: 18,
                                  iconWidth: 18,
                                  context: context,
                                  text: Text(
                                    'Up to 20% off',
                                    style:
                                        Styles.styles9w500interFamily.copyWith(
                                      color: const Color.fromRGBO(
                                          255, 255, 255, 1),
                                      fontSize: 9,
                                    ),
                                  ),
                                ),
                                descriptionOfferWidget: () =>
                                    descriptionOfferWidget(
                                  titleText: Text(
                                    'Nestle Pure Life',
                                    style: Styles.styles17w700interFamily
                                        .copyWith(fontSize: 17),
                                  ),
                                  offerRichText: RichText(
                                    text: TextSpan(
                                      text: 'Offer Ends At ',
                                      style: Styles.styles12w400interFamily
                                          .copyWith(fontSize: 12),
                                      children: [
                                        TextSpan(
                                          text: '1 Day 16 Hours',
                                          style: Styles.styles12w500interFamily
                                              .copyWith(fontSize: 12),
                                        )
                                      ],
                                    ),
                                  ),
                                  beneficiaryText: RichText(
                                    text: TextSpan(
                                      text: 'Beneficiary ',
                                      style: Styles.styles12w400interFamily
                                          .copyWith(fontSize: 12),
                                      children: [
                                        TextSpan(
                                          text: '33',
                                          style: Styles.styles12w800interFamily
                                              .copyWith(fontSize: 12),
                                        )
                                      ],
                                    ),
                                  ),
                                  iconWidth: 18,
                                  iconHeight: 18,
                                ),
                              );
                            },
                          )
                        : GridView.builder(
                            key: const ValueKey(2),
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 250,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 0,
                              mainAxisExtent: 220,
                            ),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return specialOfferWidget(
                                context: context,
                                assetImagePath:
                                    'assets/test_images/nestle-offer.png',
                                brandImagePath:
                                    'assets/test_images/offer-brand.png',
                                imageHeight: 145,
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, specialOfferItemScreen);
                                },
                                upToOfferWidget: () => upToOfferWidget(
                                  iconHeight: 13,
                                  iconWidth: 13,
                                  context: context,
                                  text: Text(
                                    'Up to 20% off',
                                    style:
                                        Styles.styles7w500interFamily.copyWith(
                                      fontSize: 9,
                                    ),
                                  ),
                                ),
                                descriptionOfferWidget: () =>
                                    descriptionOfferWidget(
                                  titleText: Text(
                                    'Nestle Pure Life',
                                    style: Styles.styles10w700interFamily
                                        .copyWith(fontSize: 10),
                                  ),
                                  offerOrderedText: RichText(
                                    text: TextSpan(
                                      text: '33 ',
                                      style: Styles.styles8w800interFamily
                                          .copyWith(fontSize: 8),
                                      children: [
                                        TextSpan(
                                          text: 'Offer Ordered',
                                          style: Styles.styles8w500interFamily
                                              .copyWith(fontSize: 8),
                                        ),
                                      ],
                                    ),
                                  ),
                                  offerRichText: RichText(
                                    text: TextSpan(
                                      text: 'Offer Ends At ',
                                      style: Styles.styles10w400interFamily
                                          .copyWith(fontSize: 10),
                                      children: [
                                        TextSpan(
                                          text: '1 Day 16 Hours',
                                          style: Styles.styles10w500interFamily
                                              .copyWith(fontSize: 10),
                                        )
                                      ],
                                    ),
                                  ),
                                  beneficiaryText:
                                      RichText(text: const TextSpan()),
                                  iconWidth: 15,
                                  iconHeight: 15,
                                ),
                              );
                            },
                          )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
