import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/helper.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:skeletonizer/skeletonizer.dart';

class LoadingCategory extends StatelessWidget {
  const LoadingCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 18.w,
      ),
      child: GridView.builder(
        padding: EdgeInsets.only(top: 5.h),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 9,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 125,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          // childAspectRatio: 1 / 1.5,
          mainAxisExtent: 135,
        ),
        itemBuilder: (context, index) => Skeletonizer(
          child: SizedBox(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(25),
                    ),
                  ),
                  child: Helper.loadNetworkImage(
                    assetsErrorPath:
                        'assets/screens_background/home-category.png',
                  ),
                ),
                Text(
                  'hello how',
                  style: Styles.styles11w700interFamily.copyWith(fontSize: 11),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
