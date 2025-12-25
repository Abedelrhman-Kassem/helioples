import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/notifiers/sub_categories_notifier.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/item_widget.dart';
import 'package:negmt_heliopolis/core/widgets/pagination_listener.dart';
import 'package:negmt_heliopolis/features/Categories/data/model/featur_model.dart';
import 'package:negmt_heliopolis/features/Categories/presentation/view%20model/cubit/sub_categories_cubit.dart';
import 'package:negmt_heliopolis/features/Product/data/model/product_model.dart';
import 'package:skeletonizer/skeletonizer.dart';

class FeaturedProductsWidget extends StatefulWidget {
  final SubCategoriesCubit subCategoriesCubit;
  final List<FeaturData> features;
  const FeaturedProductsWidget({
    super.key,
    required this.features,
    required this.subCategoriesCubit,
  });

  @override
  State<FeaturedProductsWidget> createState() => _FeaturedProductsWidgetState();
}

class _FeaturedProductsWidgetState extends State<FeaturedProductsWidget> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  final SubCategoriesNotifier notifier = SubCategoriesNotifier();

  // Local map to store products for each feature ID
  final Map<String, List<Products>> _featureProductsMap = {};

  final List<Color> _cardColors = [
    const Color(0xFFD36E28), // Orange
    const Color(0xFF28D36E), // Green
    const Color(0xFF6E28D3), // Purple
    const Color(0xFFE91E63), // Pink
    const Color(0xFF2196F3), // Blue
  ];

  @override
  void initState() {
    super.initState();
    // Initialize local map with initial products from features
    for (var feature in widget.features) {
      if (feature.id != null) {
        _featureProductsMap[feature.id!] = List.from(feature.products);
        // Initialize pages in cubit for this feature if not exists (defensive)
        if (!widget.subCategoriesCubit.productsFeaturedPages.containsKey(
          feature.id,
        )) {
          widget.subCategoriesCubit.productsFeaturedPages[feature.id!] = 0;
        }
      }
    }

    // Listen to notifier for new products
    notifier.addListener(_refreshState);
  }

  @override
  void dispose() {
    notifier.removeListener(_refreshState);
    _pageController.dispose();
    super.dispose();
  }

  void _refreshState() {
    // Check if there are new products for current feature
    if (widget.features.isEmpty) return;

    bool productsUpdated = false;

    // We iterate through features to check updates for any of them (as async calls might complete for non-current)
    // Or just check current? Ideally check all keys in notifier.productsFeatured
    notifier.productsFeatured.forEach((featureId, newProducts) {
      if (newProducts.isNotEmpty) {
        if (_featureProductsMap.containsKey(featureId)) {
          _featureProductsMap[featureId]!.addAll(newProducts);
          productsUpdated = true;
        }
      }
    });

    // Clean up consumed lists safely
    List<String> keysToClear = [];
    notifier.productsFeatured.forEach((k, v) {
      if (v.isNotEmpty) keysToClear.add(k);
    });
    for (var k in keysToClear) {
      notifier.productsFeatured[k] = [];
    }

    // Always setState to reflect isFetching changes or product updates
    if (mounted) {
      setState(() {});
    }
  }

  void _nextFeature() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % widget.features.length;
    });
    _pageController.animateToPage(
      _currentIndex,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _onLoadMore() {
    final currentFeature = widget.features[_currentIndex];
    if (currentFeature.id == null) return;

    widget.subCategoriesCubit.fetchProductsFeatured(
      currentFeature.id!,
      context,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.features.isEmpty) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }

    final currentFeature = widget.features[_currentIndex];
    final currentProducts = _featureProductsMap[currentFeature.id] ?? [];
    final bool isFetching = notifier.isFetching[currentFeature.id] ?? false;

    return SliverToBoxAdapter(
      child: Column(
        children: [
          // Header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
            child: Row(
              children: [
                Text("👑", style: TextStyle(fontSize: 24.sp)),
                SizedBox(width: 8.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Featured",
                      style: Styles.styles17w600interFamily.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Our Best Products From Best Partners",
                      style: Styles.styles12w400interFamily.copyWith(
                        color: Colors.grey,
                        fontSize: 10.sp,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios, size: 14),
                  onPressed: _nextFeature,
                  color: Colors.black,
                  constraints: const BoxConstraints(
                    minWidth: 30,
                    minHeight: 30,
                  ),
                  padding: EdgeInsets.zero,
                ),
              ],
            ),
          ),

          // Product List with Background
          SizedBox(
            height: 370.h,
            child: Stack(
              children: [
                // Background Banner (PageView for navigation)
                Positioned(
                  top: 20.h,
                  left: 10.w,
                  right: 10.w,
                  height: 210.h,
                  child: PageView.builder(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.features.length,
                    itemBuilder: (context, index) {
                      final feature = widget.features[index];
                      log("image url: ${widget.features[index].bannerImage}");
                      // Use modulo to cycle through colors
                      final color = _cardColors[index % _cardColors.length];

                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 5.w),
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(15.r),
                          image:
                              (feature.bannerImage != null &&
                                  feature.bannerImage!.isNotEmpty)
                              ? DecorationImage(
                                  image: NetworkImage(feature.bannerImage!),
                                  fit: BoxFit.cover,
                                  opacity: 0.2, // Subtle texture
                                )
                              : null,
                        ),
                      );
                    },
                  ),
                ),

                // Product Cards List
                Positioned(
                  top: 90.h,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: PaginationListener(
                      key: ValueKey<int>(
                        _currentIndex,
                      ), // Rebuild/reset listener on feature change
                      onLoadMore: _onLoadMore,
                      isLoading: isFetching,
                      scrollDirection: Axis.horizontal,
                      // threshold: 100, // Trigger early
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(horizontal: 40.w),
                        itemCount:
                            currentProducts.length + (isFetching ? 3 : 0),
                        itemBuilder: (context, index) {
                          if (index >= currentProducts.length) {
                            return Padding(
                              padding: EdgeInsets.only(right: 15.w),
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: SizedBox(
                                  width: 150.w,
                                  child: Skeletonizer(
                                    child: ItemWidget(
                                      relatedProductsModel: Products(
                                        id: 'loading_id_$index',
                                        name: 'Loading Product',
                                        enName: 'Loading Product',
                                        description: 'Loading Description',
                                        enDescription: 'Loading Description',
                                        thumbnailImage: '',
                                        price: 100.0,
                                        afterDiscount: 80.0,
                                        availableQuantity: 10,
                                        state: 'InStock',
                                        discount: 0,
                                        isLiked: false,
                                        quantity: 0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }

                          final product = currentProducts[index];
                          return Padding(
                            padding: EdgeInsets.only(right: 15.w),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: SizedBox(
                                width:
                                    150.w, // Ensure width works nicely in list
                                child: ItemWidget(
                                  relatedProductsModel: product,
                                  heroTagPrefix:
                                      'featured_${currentFeature.id}_',
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
