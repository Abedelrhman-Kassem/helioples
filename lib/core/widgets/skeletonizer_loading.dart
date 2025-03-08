import 'package:flutter/material.dart';
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
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(Icons.heart_broken),
            ],
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
