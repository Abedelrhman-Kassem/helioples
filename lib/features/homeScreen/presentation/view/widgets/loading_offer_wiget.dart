import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/helper.dart';
import 'package:skeletonizer/skeletonizer.dart';

class LoadingOfferWiget extends StatelessWidget {
  const LoadingOfferWiget({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: AspectRatio(
        aspectRatio: 297 / 140,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            2,
            (index) {
              return SizedBox(
                width: 185.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Helper.loadNetworkImage(
                      assetsErrorPath: 'assets/test_images/home_categories.png',
                    ),
                    const Text('Hi There'),
                    const Text('Nice To Meet You'),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
