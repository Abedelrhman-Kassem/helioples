import 'package:flutter/material.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/Helper.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';

Widget categoryBuilder(BuildContext context, bool isRtl) {
  return GestureDetector(
    onTap: () {},
    child: SizedBox(
      width: 100,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Color.fromRGBO(255, 248, 232, 1),
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
            ),
            child: Helper.loadNetworkImage(
              isRtl: isRtl,
              assetsErrorPath: 'assets/screens_background/home-category.png',
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 16,
            ),
            child: Text(
              'Deals And Offers',
              style: Styles.styles11w700interFamily.copyWith(fontSize: 11),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    ),
  );
}
