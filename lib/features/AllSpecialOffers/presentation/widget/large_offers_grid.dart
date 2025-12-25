import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/widgets/special_offer_widget.dart';
import 'package:negmt_heliopolis/features/AllSpecialOffers/presentation/view_model/cubit/all_special_offer_cubit.dart';

class LargeOffersGrid extends StatelessWidget {
  final AllSpecialOfferCubit allSpecialOffersCubit;

  const LargeOffersGrid({
    super.key,
    required this.allSpecialOffersCubit,
  });

  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: allSpecialOffersCubit.isGrid,
      child: AnimatedSlide(
        duration: const Duration(milliseconds: 300),
        offset: Offset(allSpecialOffersCubit.initialOffset, 0),
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
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
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
                              vertical: 2.h,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
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
                      mainAxisAlignment: MainAxisAlignment.center,
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
                              borderRadius: BorderRadius.circular(
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
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 500,
                crossAxisSpacing: 20,
                mainAxisSpacing: 10,
                mainAxisExtent: 270.h,
              ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: allSpecialOffersCubit.offers.length,
              itemBuilder: (context, index) {
                return SpecialOfferWidget(
                  offer: allSpecialOffersCubit.offers[index],
                  canNavigate: true,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
