import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/helper.dart';
import 'package:skeletonizer/skeletonizer.dart';

Widget gridProductsLoading(int iteCount) {
  return GridView.builder(
    physics: const NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: iteCount,
    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: 150,
      crossAxisSpacing: 7,
      mainAxisSpacing: 10,
      mainAxisExtent: 220,
    ),
    itemBuilder: (context, index) => loadingProduct(),
  );
}

Widget loadingProduct() {
  return Skeletonizer(
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
      height: 240,
      width: 130,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [Icon(Icons.heart_broken)],
          ),
          Helper.loadNetworkImage(
            assetsErrorPath: 'assets/screens_background/home-category.png',
          ),
          const Text('hello there'),
        ],
      ),
    ),
  );
}

Widget listProductsLoading(int itemCount) {
  return ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: itemCount,
    itemBuilder: (context, index) => loadingListItem(),
  );
}

Widget loadingListItem() {
  return Skeletonizer(
    child: Container(
      height: 65.h,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
      child: Row(
        children: [
          Container(
            width: 60.w,
            height: 60.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[200],
            ),
          ),
          const SizedBox(width: 20),
          const Expanded(child: Text('Product Name Placeholder')),
        ],
      ),
    ),
  );
}

Widget productScreenLoading() {
  return Skeletonizer(
    child: SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: loadingProductDetails(),
          ),
          SizedBox(height: 30.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              width: 150.w,
              height: 20.h,
              color: Colors.grey[200],
            ),
          ),
          SizedBox(height: 10.h),
          SizedBox(
            height: 210,
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) => Container(
                width: 130,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              separatorBuilder: (context, index) => SizedBox(width: 10.w),
            ),
          ),
          SizedBox(height: 100.h),
        ],
      ),
    ),
  );
}

Widget loadingProductDetails() {
  return Column(
    children: [
      Container(
        height: 200.h,
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 20.h, horizontal: 100.w),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(width: 200.w, height: 25.h, color: Colors.grey[200]),
          Container(width: 80.w, height: 30.h, color: Colors.grey[200]),
        ],
      ),
      SizedBox(height: 20.h),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(width: 100.w, height: 20.h, color: Colors.grey[200]),
          Container(width: 120.w, height: 35.h, color: Colors.grey[200]),
        ],
      ),
    ],
  );
}
