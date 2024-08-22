import 'package:flutter/material.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/Helper.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/svgAsset.dart';
import 'package:negmt_heliopolis/features/SpecialOffersItem/presentation/view/widgets/discount_widget.dart';

class ItemWidget extends StatefulWidget {
  const ItemWidget({super.key});

  @override
  State<ItemWidget> createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget>
    with SingleTickerProviderStateMixin {
  bool isFavorite = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scaleAnimation = Tween<double>(begin: 1, end: 1.2).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  void _toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;

      if (isFavorite) {
        _animationController
            .forward()
            .then((_) => _animationController.reverse());
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isRtl = Directionality.of(context) == TextDirection.rtl;

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(241, 241, 241, 1),
        borderRadius: BorderRadius.circular(15.5),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 7.34,
                  vertical: 3.67,
                ),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(248, 147, 31, 0.1),
                  borderRadius: BorderRadius.circular(3.67),
                ),
                child: Text(
                  'Sold Out',
                  style: Styles.styles8w400interFamily.copyWith(fontSize: 8),
                ),
              ),
              ScaleTransition(
                scale: _scaleAnimation,
                child: InkWell(
                  onTap: _toggleFavorite,
                  child: svgIcon(
                    path: 'assets/svg_icons/white-heart.svg',
                    color: isFavorite
                        ? MyColors.mainColor
                        : const Color.fromRGBO(181, 185, 190, 1),
                    width: 22,
                    height: 20,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Helper.loadNetworkImage(
            isRtl: isRtl,
            assetsErrorPath: 'assets/test_images/mango-category.png',
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {},
                child: svgIcon(
                  path: 'assets/svg_icons/empty-plus.svg',
                  width: 18.5,
                  height: 18.5,
                  color: MyColors.mainColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                constraints: const BoxConstraints(
                  maxWidth: 74,
                ),
                child: RichText(
                  text: TextSpan(
                    text: '750',
                    style:
                        Styles.styles16w800interFamily.copyWith(fontSize: 16),
                    children: [
                      TextSpan(
                        text: '.00',
                        style:
                            Styles.styles9w300interFamily.copyWith(fontSize: 9),
                      ),
                    ],
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              discountWidget('80'),
            ],
          ),
          Text(
            'Nestle Pure Life 5 Liters',
            style: Styles.styles10w300interFamily.copyWith(fontSize: 13),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
