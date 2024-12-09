import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

Widget loadingWidget() {
  return ListView.builder(
    itemBuilder: (context, index) => Skeletonizer(
      child: Container(
        margin: EdgeInsets.all(10.r),
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(10.r),
        ),
        height: 100,
        child: Row(
          children: [
            Image.asset(
              'assets/screens_background/home-category.png',
            ),
            const SizedBox(width: 30),
            const Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('hello there'),
                Text('hello there'),
              ],
            ),
            const Spacer(),
            const Text('4832795')
          ],
        ),
      ),
    ),
    itemCount: 4,
  );
}
