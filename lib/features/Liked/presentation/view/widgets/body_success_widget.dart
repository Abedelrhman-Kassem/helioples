import 'package:flutter/material.dart';
import 'package:negmt_heliopolis/core/widgets/item_widget.dart';
import 'package:negmt_heliopolis/features/Liked/presentation/view_model/cubit/liked_cubit.dart';

Widget bodySuccessWidget(FetchLikedSuccess state) {
  return Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: 10,
      vertical: 20,
    ),
    child: GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: state.product.products!.length,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 150,
        crossAxisSpacing: 7,
        mainAxisSpacing: 10,
        mainAxisExtent: 220,
        // childAspectRatio: 1 / 2,
      ),
      itemBuilder: (context, index) => ItemWidget(
        relatedProductsModel: state.product.products?[index],
      ),
    ),
  );
}
