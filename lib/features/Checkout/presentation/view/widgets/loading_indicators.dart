import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SmoothLoadingIndicators extends StatefulWidget {
  const SmoothLoadingIndicators({super.key});

  @override
  State<SmoothLoadingIndicators> createState() =>
      _SmoothLoadingIndicatorsState();
}

class _SmoothLoadingIndicatorsState extends State<SmoothLoadingIndicators> {
  late Timer _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();

    // Initialize the timer to update the active page index every second
    _timer = Timer.periodic(
      const Duration(milliseconds: 500),
      (timer) {
        setState(() {
          if (_currentPage < 2) {
            _currentPage++;
          } else {
            _currentPage = 0;
          }
        });
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: PageController(
        initialPage: _currentPage,
      ),
      count: 3,
      effect: ScaleEffect(
        activeDotColor: const Color.fromRGBO(187, 187, 187, 1),
        dotColor: const Color.fromRGBO(217, 217, 217, 1),
        dotWidth: 5.3.r,
        dotHeight: 5.3.r,
        radius: 200,
        spacing: 5.w,
        scale: 1.6,
      ),
    );
  }
}
