import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/helper.dart';
import 'package:negmt_heliopolis/core/widgets/special_offer_widget.dart';
import 'package:negmt_heliopolis/features/homeScreen/data/model/special_offer_model.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SpecialOfferItemLoading extends StatelessWidget {
  const SpecialOfferItemLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: Column(
        children: [
          SpecialOfferWidget(
            offer: Offer(
              id: '0',
              name: 'Loading ...',
              thumbnailImage: '',
              companyImage: '',
              visits: 0,
              homeScreen: false,
              active: false,
              badge: 'Loading',
              expiresAt: DateTime.now(),
              pagedProducts: null,
            ),
            canNavigate: false,
          ),
          SizedBox(height: 30.h),
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 9,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 150,
              crossAxisSpacing: 7,
              mainAxisSpacing: 10,
              mainAxisExtent: 220,
            ),
            itemBuilder: (context, index) => Skeletonizer(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
                height: 240,
                width: 130,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.heart_broken),
                      ],
                    ),
                    Helper.loadNetworkImage(
                      assetsErrorPath:
                          'assets/screens_background/home-category.png',
                    ),
                    const Text('hello there'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
