import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/cubit/main_cubit.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/helper.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/category_builder.dart';
import 'package:skeletonizer/skeletonizer.dart';

class GategoryWidget extends StatelessWidget {
  final ScrollController scrollController;
  final MainCubit mainCubit;
  const GategoryWidget(
      {super.key, required this.scrollController, required this.mainCubit});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
          controller: scrollController,
          padding: EdgeInsets.only(top: 5.h),
          physics: const BouncingScrollPhysics(),
          // Add extra items for loading indicator
          itemCount: mainCubit.categories.length +
              (mainCubit.loadingCategories && !mainCubit.endFetching ? 3 : 0),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 125,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            mainAxisExtent: 135,
          ),
          itemBuilder: (context, index) {
            // Show loading skeletons at the end
            if (index >= mainCubit.categories.length) {
              return Skeletonizer(
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
                        'Loading...',
                        style: Styles.styles11w700interFamily
                            .copyWith(fontSize: 11),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            }
            // Show actual category
            return categoryBuilder(
              islistview: false,
              context: context,
              category: mainCubit.categories[index],
            );
          }),
    );
  }
}
