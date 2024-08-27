import 'package:flutter/material.dart';
import 'package:negmt_heliopolis/core/widgets/item_widget.dart';

Widget itemWidgetGridView({bool isFavorite = false, int counter = 0}) {
  return GridView.builder(
    physics: const NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: 5,
    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: 150,
      crossAxisSpacing: 7,
      mainAxisSpacing: 10,
      childAspectRatio: 1.2 / 2.25,
    ),
    itemBuilder: (context, index) => ItemWidget(
      counter: counter,
      isFavorite: isFavorite,
    ),
  );
}
