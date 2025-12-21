import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/helper.dart';
import 'package:negmt_heliopolis/generated/locale_keys.g.dart';
import 'package:skeletonizer/skeletonizer.dart';

class RelatedProdLoading extends StatelessWidget {
  const RelatedProdLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: SizedBox(
        height: 210,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: [
            const SizedBox(width: 5),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 25,
                  horizontal: 10,
                ),
                margin: const EdgeInsets.symmetric(
                  horizontal: 5,
                ),
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
                    Text(LocaleKeys.product_screen_hello_there.tr()),
                  ],
                ),
              ),
              separatorBuilder: (context, index) => SizedBox(width: 1.w),
              itemCount: 7,
            ),
            const SizedBox(width: 20),
          ],
        ),
      ),
    );
  }
}
