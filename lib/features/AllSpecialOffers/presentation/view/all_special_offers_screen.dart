import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/custom_snack_bar.dart';
import 'package:negmt_heliopolis/core/widgets/return_arrow.dart';
import 'package:negmt_heliopolis/core/widgets/special_offer_widget.dart';
import 'package:negmt_heliopolis/features/AllSpecialOffers/presentation/view_model/cubit/all_special_offer_cubit.dart';
import 'package:negmt_heliopolis/features/homeScreen/data/model/special_offer_model.dart';
import 'package:negmt_heliopolis/features/homeScreen/presentation/view/widgets/loading_offer_wiget.dart';
import 'package:negmt_heliopolis/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class AllSpecialOffersScreen extends StatefulWidget {
  const AllSpecialOffersScreen({super.key});

  @override
  State<AllSpecialOffersScreen> createState() => _AllSpecialOffersScreenState();
}

class _AllSpecialOffersScreenState extends State<AllSpecialOffersScreen> {
  late List<Offer> offers;

  @override
  void initState() {
    offers = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AllSpecialOfferCubit()..getSpecialOffers(homeScreen: false, page: 0),
      child: BlocConsumer<AllSpecialOfferCubit, AllSpecialOfferState>(
        listener: (context, state) {
          if (state is FetchOffersFailed) {
            CustomSnackBar.show(
              context: context,
              duration: const Duration(seconds: 10),
              text: state.error,
              isGreen: false,
            );
          }

          if (state is FetchOffersSuccess) {
            offers.addAll(state.specialOfferModel.offers!);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: returnArrow(
                context: context,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(
                LocaleKeys.all_special_offers_screen_special_offers.tr(),
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

                    return Stack(
                      children: [
                        if (state is FetchOffersLoading)
                          GridView.builder(
                            key: const ValueKey(2),
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 500,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 10,
                              mainAxisExtent: 220,
                            ),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 7,
                            itemBuilder: (context, index) {
                              return const LoadingOfferWiget();
                            },
                          ),
                        if (offers.isNotEmpty)
                          Offstage(
                            offstage: allSpecialOffersCubit.isGrid,
                            child: AnimatedSlide(
                              duration: const Duration(milliseconds: 300),
                              offset: Offset(
                                  allSpecialOffersCubit.initialOffset, 0),
                              curve: Curves.easeInOutSine,
                              child: Column(
                                key: const ValueKey(1),
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  IconButton(
                                    splashRadius: 2,
                                    onPressed: () {
                                      allSpecialOffersCubit.changeOffset();
                                    },
                                    icon: Container(
                                      width: 37.w,
                                      height: 36.w,
                                      decoration: BoxDecoration(
                                        color: const Color.fromRGBO(
                                          237,
                                          237,
                                          237,
                                          1,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: List.generate(
                                              3,
                                              (index) {
                                                return Container(
                                                  width: 9.53.w,
                                                  height: 3.81.h,
                                                  margin: EdgeInsets.symmetric(
                                                    vertical: 2.h,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      12.r,
                                                    ),
                                                    color: MyColors.mainColor,
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                          SizedBox(width: 3.w),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: List.generate(
                                              3,
                                              (index) {
                                                return Container(
                                                  width: 9.53.w,
                                                  height: 3.81.h,
                                                  margin: EdgeInsets.symmetric(
                                                    vertical: 2.h,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      12.r,
                                                    ),
                                                    color: MyColors.mainColor,
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  GridView.builder(
                                    key: const ValueKey(1),
                                    gridDelegate:
                                        const SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 500,
                                      crossAxisSpacing: 20,
                                      mainAxisSpacing: 10,
                                      mainAxisExtent: 220,
                                    ),
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: offers.length,
                                    itemBuilder: (context, index) {
                                      return SpecialOfferWidget(
                                        offer: offers[index],
                                        canNavigate: true,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        if (offers.isNotEmpty)
                          AnimatedSlide(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOutSine,
                            offset: Offset(
                              allSpecialOffersCubit.initialOffset + 1.5,
                              0,
                            ),
                            child: Column(
                              key: const ValueKey(2),
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IconButton(
                                  splashRadius: 2,
                                  onPressed: () {
                                    allSpecialOffersCubit.changeOffset();
                                  },
                                  icon: Container(
                                    width: 37.w,
                                    height: 36.w,
                                    decoration: BoxDecoration(
                                      color: const Color.fromRGBO(
                                          237, 237, 237, 1),
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: List.generate(
                                        3,
                                        (index) {
                                          return Container(
                                            width: 20.77.w,
                                            height: 2.38.h,
                                            margin: EdgeInsets.symmetric(
                                              vertical: 2.h,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                12.r,
                                              ),
                                              color: MyColors.mainColor,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                GridView.builder(
                                  key: const ValueKey(2),
                                  gridDelegate:
                                      const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 300,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 0,
                                    mainAxisExtent: 220,
                                  ),
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: offers.length,
                                  itemBuilder: (context, index) {
                                    return SpecialOfferWidget(
                                      canNavigate: true,
                                      offer: offers[index],
                                      isSmall: true,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
