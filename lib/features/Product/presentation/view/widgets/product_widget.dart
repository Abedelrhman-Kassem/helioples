import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/helper.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/features/Liked/presentation/view/widgets/heart_widget.dart';
import 'package:negmt_heliopolis/core/widgets/item_counter_widget.dart';
import 'package:negmt_heliopolis/features/Product/data/model/product_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductWidget extends StatefulWidget {
  final Product product;
  const ProductWidget({super.key, required this.product});

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextDirection textDirection = Directionality.of(context);

    return Column(
      children: [
        Container(
          height: 250.h,
          margin: EdgeInsets.symmetric(vertical: 20.h),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: PageView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: 1,
                  controller: _pageController,
                  itemBuilder: (context, index) => Helper.loadNetworkImage(
                    url: widget.product.thumbnailImage ?? '',
                    assetsErrorPath:
                        'assets/ayman/—Pngtree—3d beauty cosmetics product design_6380191 (2).png',
                    // assetsErrorPath: 'assets/test_images/white-toast.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Text(
                widget.product.state!,
                style: Styles.styles14w400Gold,
              ),
              Positioned.directional(
                textDirection: textDirection,
                end: 0,
                top: 0,
                child: HeartWidget(
                  isFavorite: widget.product.isLiked!,
                  width: 30.w,
                  height: 28.h,
                  productId: widget.product.id!,
                ),
              ),
              Positioned.directional(
                textDirection: textDirection,
                start: 0,
                bottom: 0,
                child: SmoothPageIndicator(
                  controller: _pageController,
                  count: 1,
                  effect: ExpandingDotsEffect(
                    activeDotColor: MyColors.mainColor,
                    dotColor: const Color.fromRGBO(217, 217, 217, 1),
                    dotHeight: 4.84.r,
                    dotWidth: 4.84.r,
                    expansionFactor: 8,
                    spacing: 4.w,
                  ),
                  onDotClicked: (index) {
                    _pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width - 170.w,
              ),
              child: Text(
                widget.product.enDesc!,
                style: Styles.styles18w500BlackWhite,
              ),
            ),
            ItemCounterWidget(
              itemUiModel: ItemUiModel(
                id: widget.product.id!,
                name: widget.product.name!,
                description: widget.product.description ?? 'description',
                enName: widget.product.enName ?? 'enName',
                enDesc: widget.product.enDesc ?? 'enDesc',
                thumbnailImage: widget.product.thumbnailImage ?? '',
                price: widget.product.price!,
                availablePieces: widget.product.availabelPieces!,
                discount: widget.product.discount ?? 0,
              ),
            )
          ],
        ),
        SizedBox(height: 20.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${widget.product.availabelPieces!} Pcs',
                  style: Styles.styles14w400NormalBlack,
                ),
                Text(
                  'Damfi',
                  style: Styles.styles14w400NormalBlack,
                ),
              ],
            ),
            Column(
              children: [
                RichText(
                  text: TextSpan(
                    text:
                        '${widget.product.afterDiscount ?? widget.product.price}',
                    style: Styles.styles25w900MainColor,
                    children: [
                      TextSpan(
                        text: ' EGP',
                        style: Styles.styles25w500MainColor,
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                if (widget.product.afterDiscount != null)
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 17.w,
                          vertical: 8.h,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          color: const Color.fromRGBO(254, 237, 229, 1),
                        ),
                        child: Text(
                          '12% off',
                          style: Styles.styles12w600Gold,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        '${widget.product.price}',
                        style: Styles.styles12w600Black.copyWith(
                          decoration: TextDecoration.lineThrough,
                        ),
                        // selectionColor: Colors.red,
                      )
                    ],
                  ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
