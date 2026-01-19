import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:negmt_heliopolis/core/utlis/notifiers/liked_notifier.dart';
import 'package:negmt_heliopolis/core/widgets/item_widget.dart';
import 'package:negmt_heliopolis/features/Liked/presentation/view_model/cubit/liked_cubit.dart';
import 'package:negmt_heliopolis/features/Product/data/model/product_model.dart';

class BodySuccessWidget extends StatefulWidget {
  final List<Products> productList;
  const BodySuccessWidget({super.key, required this.productList});

  @override
  State<BodySuccessWidget> createState() => _BodySuccessWidgetState();
}

class _BodySuccessWidgetState extends State<BodySuccessWidget> {
  final LikedNotifier likedNotifier = LikedNotifier();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    likedNotifier.addListener(removeUnlikedProduct);

    _scrollController.addListener(getPages);

    super.initState();
  }

  void getPages() {
    if (_scrollController.position.pixels >=
        (_scrollController.position.maxScrollExtent - 300)) {
      context.read<LikedCubit>().getLikedProducts();
    }
  }

  void removeUnlikedProduct() {
    if (!likedNotifier.isLikedStatus) {
      context.read<LikedCubit>().removeProduct(likedNotifier.productId);
    }
  }

  @override
  void dispose() {
    likedNotifier.removeListener(removeUnlikedProduct);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: GridView.builder(
        controller: _scrollController,
        itemCount: widget.productList.length,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 150,
          crossAxisSpacing: 7,
          mainAxisSpacing: 10,
          mainAxisExtent: 220,
        ),
        itemBuilder: (context, index) => ItemWidget(
          key: ValueKey(widget.productList[index].id),
          relatedProductsModel: widget.productList[index],
        ),
      ),
    );
  }
}
