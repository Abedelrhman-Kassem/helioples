import 'package:flutter/material.dart';
import 'package:negmt_heliopolis/core/widgets/item_widget.dart';

Widget itemWidgetGridView({
  bool isFavorite = false,
  int counter = 0,
  int itemCount = 5,
  ScrollController? scrollController,
}) {
  return GridView.builder(
    controller: scrollController,
    physics:
        scrollController == null ? const NeverScrollableScrollPhysics() : null,
    shrinkWrap: true,
    itemCount: itemCount,
    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: 150,
      crossAxisSpacing: 7,
      mainAxisSpacing: 10,
      mainAxisExtent: 220,
      // childAspectRatio: 1 / 2,
    ),
    itemBuilder: (context, index) => ItemWidget(),
  );
}
