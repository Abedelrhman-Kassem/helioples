import 'package:flutter/material.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/helper.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/features/homeScreen/data/model/all_categories_model.dart';

Widget categoryBuilder(
    {required BuildContext context, required CategoryModel category}) {
  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(context, categoriesScreen);
    },
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
              assetsErrorPath: 'assets/screens_background/home-category.png',
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 16,
            ),
            child: Text(
              category.name,
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
