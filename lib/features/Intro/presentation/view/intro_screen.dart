import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/models/language/app_localizations.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/svg_asset.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/screens_background/intro-background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TweenAnimationBuilder(
                duration: const Duration(seconds: 2),
                tween: Tween<Offset>(
                  begin: const Offset(-200, 0),
                  end: const Offset(0, 0),
                ),
                curve: Curves.elasticOut,
                child: svgIcon(
                  path: 'assets/svg_icons/negma-intro-title.svg',
                  width: 188.22.w,
                  height: 42.h,
                  color: Colors.white,
                ),
                builder: (context, value, child) {
                  return Transform.translate(
                    offset: value,
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 21.w,
                        vertical: 20.h,
                      ),
                      child: child,
                    ),
                  );
                },
              ),
              TweenAnimationBuilder(
                duration: const Duration(seconds: 2),
                tween: Tween<Offset>(
                  begin: const Offset(0, 350),
                  end: const Offset(0, 0),
                ),
                curve: Curves.elasticOut,
                builder: (context, value, child) {
                  return Transform.translate(
                    offset: value,
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        child!,
                      ],
                    ),
                  );
                },
                child: Column(
                  children: [
                    Transform.scale(
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
                    ),
                    Transform.translate(
                      offset: Offset(0, -65.h),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 53.w),
                        child: Column(
                          children: [
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text: 'Better'.tr(context),
                                style: Styles.styles40w800NormalWhite,
                                children: [
                                  TextSpan(
                                    text: 'Prices,'.tr(context),
                                    style: Styles.styles40w400NormalWhite,
                                  ),
                                  TextSpan(
                                    text: '\n',
                                    style: Styles.styles40w400NormalWhite,
                                  ),
                                  TextSpan(
                                    text: 'Faster'.tr(context),
                                    style: Styles.styles40w400NormalWhite,
                                  ),
                                  TextSpan(
                                    text: 'Delivery'.tr(context),
                                    style: Styles.styles40w800NormalWhite,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20.h),
                            IconButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, homeLayout);
                              },
                              icon: Container(
                                width: 268.w,
                                height: 66.h,
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(0, 174, 198, 1),
                                  borderRadius: BorderRadius.circular(50.r),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Start Shopping'.tr(context),
                                      style: Styles.styles20w500NormalWhite,
                                    ),
                                    SizedBox(width: 10.w),
                                    Transform.rotate(
                                      angle: isRtl ? 135 : 0,
                                      child: svgIcon(
                                        path:
                                            'assets/svg_icons/arrow-circle-right.svg',
                                        width: 24.16.w,
                                        height: 24.16.h,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Already Have account?'.tr(context),
                                  style: Styles.styles16w400White,
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, signInScreen);
                                  },
                                  child: Text(
                                    'Sign In.'.tr(context),
                                    style: Styles.styles16w500NormalWhite,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
