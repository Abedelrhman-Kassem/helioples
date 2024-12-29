import 'package:flutter/material.dart';
import 'package:negmt_heliopolis/core/utlis/notifiers/liked_notifier.dart';
import 'package:negmt_heliopolis/core/widgets/item_widget.dart';
import 'package:negmt_heliopolis/features/Product/data/model/product_model.dart';

// ignore: must_be_immutable
class BodySuccessWidget extends StatefulWidget {
  List<RelatedProductsModel> productList;
  BodySuccessWidget({
    super.key,
    required this.productList,
  });

  @override
  State<BodySuccessWidget> createState() => _BodySuccessWidgetState();
}

class _BodySuccessWidgetState extends State<BodySuccessWidget> {
  final LikedNotifier likedNotifier = LikedNotifier();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    likedNotifier.addListener(removeUnlikedProduct);

    _scrollController.addListener(hello);

    super.initState();
  }

  void hello() {
    print(_scrollController.position.maxScrollExtent);
  }

  void removeUnlikedProduct() {
    widget.productList
        .removeWhere((item) => item.id == likedNotifier.productId);
    setState(() {});
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
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 20,
      ),
      child: GridView.builder(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.productList.length,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 150,
          crossAxisSpacing: 7,
          mainAxisSpacing: 10,
          mainAxisExtent: 220,
          // childAspectRatio: 1 / 2,
        ),
        itemBuilder: (context, index) => ItemWidget(
          key: ValueKey(widget.productList[index].id),
          relatedProductsModel: widget.productList[index],
        ),
      ),
    );
  }
}
