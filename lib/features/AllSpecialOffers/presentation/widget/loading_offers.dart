import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/features/homeScreen/presentation/view/widgets/loading_offer_wiget.dart';

class LoadingOffers extends StatelessWidget {
  final int crossAxisCount;
  const LoadingOffers({super.key, required this.crossAxisCount});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.only(top: 10.h),
      key: const ValueKey(2),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 20,
        mainAxisExtent: 250.h,
        childAspectRatio: 2,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 8,
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          child: const LoadingOfferWiget(
            width: double.infinity,
            height: 150,
          ),
        );
      },
    );
  }
}
