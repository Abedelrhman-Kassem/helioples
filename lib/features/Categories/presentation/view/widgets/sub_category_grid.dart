import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/notifiers/sub_categories_notifier.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/item_widget.dart';
import 'package:negmt_heliopolis/features/Categories/data/model/sub_categories.dart';
import 'package:negmt_heliopolis/core/widgets/skeletonizer_loading.dart';
import 'package:negmt_heliopolis/features/Product/data/model/product_model.dart';
import 'package:negmt_heliopolis/generated/locale_keys.g.dart';

class SubCategoryGrid extends StatefulWidget {
  final GlobalKey globalKey;
  final SubCatByCatidData subCategory;
  final int? index;

  const SubCategoryGrid({
    super.key,
    required this.subCategory,
    required this.globalKey,
    this.index,
  });

  @override
  State<SubCategoryGrid> createState() => _SubCategoryGridState();
}

class _SubCategoryGridState extends State<SubCategoryGrid> {
  final SubCategoriesNotifier notifier = SubCategoriesNotifier();
  List<Products> products = [];
  bool endFetching = false;

  void refreshState() {
    if (endFetching) {
      return;
    }

    products.addAll(
      notifier.subCategoriesProducts[widget.subCategory.id!] ?? [],
    );
    setState(() {});
    notifier.subCategoriesProducts[widget.subCategory.id!] = [];

    endFetching = notifier.endFetching[widget.subCategory.id!] ?? false;
  }

  @override
  void initState() {
    products = widget.subCategory.products;
    notifier.addListener(refreshState);

    super.initState();
  }

  @override
  void dispose() {
    notifier.removeListener(refreshState);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int modules = products.length % 3 == 0 ? 6 : products.length % 3;
    int addedQty = modules == 6
        ? products.length + 6
        : products.length - modules + 6;

    int itemCount = (notifier.isFetching[widget.subCategory.id!] ?? false)
        ? addedQty
        : products.length;

    return SliverToBoxAdapter(
      key: widget.globalKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 40.h, bottom: 20.h),
            child: Text(
              widget.subCategory.name ?? '',
              style: Styles.styles21w700black,
            ),
          ),
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: itemCount,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 150,
              crossAxisSpacing: 7,
              mainAxisSpacing: 10,
              mainAxisExtent: 220,
              // childAspectRatio: 1 / 2,
            ),
            itemBuilder: (context, gridIndex) {
              if (gridIndex < products.length) {
                var product = products[gridIndex];

                return ItemWidget(relatedProductsModel: product);
              }

              return loadingProduct();
            },
          ),
          // if (notifier.isFetching[widget.subCategory.id!]!)
          //   gridProductsLoading(6),
          if (!(notifier.isFetching[widget.subCategory.id!] ?? false) &&
              products.isEmpty)
            Center(
              child: Text(
                LocaleKeys.sub_categories_screen_No_Products_Found.tr(),
                style: Styles.styles16w400Black,
              ),
            ),
        ],
      ),
    );
  }
}
