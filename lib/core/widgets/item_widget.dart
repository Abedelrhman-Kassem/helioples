import 'package:flutter/material.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/Helper.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/svgAsset.dart';
import 'package:negmt_heliopolis/features/SpecialOffersItem/presentation/view/widgets/discount_widget.dart';

// ignore: must_be_immutable
class ItemWidget extends StatefulWidget {
  final Color? color;

  int counter;
  bool isFavorite;
  ItemWidget({
    super.key, this.color,
    required this.counter,
    required this.isFavorite,
  });

  @override
  State<ItemWidget> createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> with TickerProviderStateMixin {
  late AnimationController _favoriteAnimationController;
  late Animation<double> _favoriteScaleAnimation;

  @override
  void initState() {
    super.initState();

    _favoriteAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _favoriteScaleAnimation = Tween<double>(begin: 1, end: 1.2).animate(
      CurvedAnimation(
        parent: _favoriteAnimationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _favoriteAnimationController.dispose();
  }

  void _toggleFavorite() {
    setState(() {
      widget.isFavorite = !widget.isFavorite;

      if (widget.isFavorite) {
        _favoriteAnimationController
            .forward()
            .then((_) => _favoriteAnimationController.reverse());
      } else {
        _favoriteAnimationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isRtl = Directionality.of(context) == TextDirection.rtl;
    bool isExpanded = widget.counter > 0;

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        color: widget.color ?? const Color.fromRGBO(241, 241, 241, 1), 
        borderRadius: BorderRadius.circular(15.5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
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
                scale: _favoriteScaleAnimation,
                child: InkWell(
                  onTap: _toggleFavorite,
                  child: svgIcon(
                    path: 'assets/svg_icons/white-heart.svg',
                    color: widget.isFavorite
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
          AnimatedContainer(
            alignment: Alignment.center,
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            width: isExpanded ? 78 : 25,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: isExpanded ? MyColors.mainColor : Colors.transparent,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (isExpanded) ...[
                  InkWell(
                    onTap: () {
                      setState(() {
                        if (widget.counter > 0) {
                          widget.counter--;
                        }
                      });
                    },
                    child: svgIcon(
                      path: 'assets/svg_icons/empty-minus.svg',
                      width: 18.5,
                      height: 18.5,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '${widget.counter}',
                    style: Styles.styles12w400interFamily
                        .copyWith(color: Colors.white),
                  ),
                  const SizedBox(width: 10),
                ],
                InkWell(
                  onTap: () {
                    setState(() {
                      widget.counter++;
                    });
                  },
                  child: svgIcon(
                    path: 'assets/svg_icons/empty-plus.svg',
                    width: 18.5,
                    height: 18.5,
                    color: isExpanded ? Colors.white : MyColors.mainColor,
                  ),
                ),
              ],
            ),
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
