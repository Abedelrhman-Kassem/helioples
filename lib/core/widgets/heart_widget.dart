import 'package:flutter/material.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/widgets/svg_asset.dart';

// ignore: must_be_immutable
class HeartWidget extends StatefulWidget {
  bool isFavorite;
  final double width;
  final double height;

  HeartWidget({
    super.key,
    required this.isFavorite,
    required this.width,
    required this.height,
  });

  @override
  State<HeartWidget> createState() => _HeartWidgetState();
}

class _HeartWidgetState extends State<HeartWidget>
    with TickerProviderStateMixin {
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
    widget.isFavorite = !widget.isFavorite;

    if (widget.isFavorite) {
      _favoriteAnimationController
          .forward()
          .then((_) => _favoriteAnimationController.reverse());
    } else {
      _favoriteAnimationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _favoriteScaleAnimation,
      child: GestureDetector(
        onTap: () {
          setState(() {
            _toggleFavorite();
          });
        },
        child: svgIcon(
          path: 'assets/svg_icons/white-heart.svg',
          color: widget.isFavorite
              ? MyColors.mainColor
              : const Color.fromRGBO(181, 185, 190, 1),
          width: widget.width,
          height: widget.height,
        ),
      ),
    );
  }
}
