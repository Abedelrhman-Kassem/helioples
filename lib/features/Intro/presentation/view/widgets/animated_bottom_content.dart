import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/features/Intro/presentation/view/widgets/intro_cta_button.dart';
import 'package:negmt_heliopolis/features/Intro/presentation/view/widgets/intro_hero_text.dart';
import 'package:negmt_heliopolis/features/Intro/presentation/view/widgets/intro_sign_in_row.dart';

class AnimatedBottomContent extends StatelessWidget {
  const AnimatedBottomContent({super.key});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<Offset>(
      duration: const Duration(seconds: 2),
      tween: Tween<Offset>(begin: const Offset(0, 350), end: Offset.zero),
      curve: Curves.elasticOut,
      builder: (context, offset, child) {
        return Transform.translate(
          offset: offset,
          child: Stack(alignment: Alignment.topCenter, children: [child!]),
        );
      },
      child: Column(
        children: [
          _buildCircleOverlay(),
          Transform.translate(
            offset: Offset(0, -65.h),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 53.w),
              child: Column(
                children: [
                  const IntroHeroText(),
                  SizedBox(height: 20.h),
                  const IntroCtaButton(),
                  const IntroSignInRow(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircleOverlay() {
    return Transform.scale(
      scale: 4,
      child: Transform.translate(
        offset: Offset(0, 99.h),
        child: Container(
          height: 219.5.h,
          constraints: const BoxConstraints(
            maxHeight: double.infinity,
            maxWidth: double.infinity,
          ),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color.fromRGBO(0, 0, 0, 0.4),
          ),
        ),
      ),
    );
  }
}
