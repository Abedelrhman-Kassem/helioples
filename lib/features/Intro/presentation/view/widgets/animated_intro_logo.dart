import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/widgets/svg_asset.dart';

class AnimatedIntroLogo extends StatelessWidget {
  const AnimatedIntroLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<Offset>(
      duration: const Duration(seconds: 2),
      tween: Tween<Offset>(begin: const Offset(-200, 0), end: Offset.zero),
      curve: Curves.elasticOut,
      builder: (context, offset, child) {
        return Transform.translate(
          offset: offset,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 21.w, vertical: 20.h),
            child: child,
          ),
        );
      },
      child: svgIcon(
        path: 'assets/svg_icons/negma-intro-title.svg',
        width: 188.22.w,
        height: 42.h,
        color: Colors.white,
      ),
    );
  }
}
