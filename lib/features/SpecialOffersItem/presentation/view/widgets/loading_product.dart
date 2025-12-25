import 'package:flutter/material.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/helper.dart';
import 'package:skeletonizer/skeletonizer.dart';

class LoadingProduct extends StatelessWidget {
  const LoadingProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
        height: 240,
        width: 130,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(15),
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
}
