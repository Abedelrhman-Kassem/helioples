import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/widgets/special_offer_widget.dart';
import 'package:negmt_heliopolis/features/AllSpecialOffers/presentation/view_model/cubit/all_special_offer_cubit.dart';

class SmallOffersGrid extends StatelessWidget {
  final AllSpecialOfferCubit allSpecialOffersCubit;

  const SmallOffersGrid({
    super.key,
    required this.allSpecialOffersCubit,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
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
                color: const Color.fromRGBO(237, 237, 237, 1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                        borderRadius: BorderRadius.circular(
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
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 300,
              crossAxisSpacing: 10,
              mainAxisSpacing: 0,
              mainAxisExtent: 220,
            ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: allSpecialOffersCubit.offers.length,
            itemBuilder: (context, index) {
              return SpecialOfferWidget(
                canNavigate: true,
                offer: allSpecialOffersCubit.offers[index],
                isSmall: true,
              );
            },
          ),
        ],
      ),
    );
  }
}
