import 'package:flutter/material.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';

Widget categoryBuilder() {
  return SizedBox(
    width: 100,
    child: Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 180,
              height: 100,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(255, 240, 245, 1),
                borderRadius: BorderRadius.all(
                  Radius.circular(25),
                ),
              ),
            ),
            const Image(
              fit: BoxFit.cover,
              image: AssetImage(
                'assets/screens_background/home-category.png',
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 16,
          ),
          child: Text(
            'Deals And Offers',
            style: Styles.styles11w700interFamily,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
  );
}
