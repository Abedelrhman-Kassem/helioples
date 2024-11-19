import 'package:flutter/material.dart';
import 'package:negmt_heliopolis/core/utlis/notifiers/liked_notifier.dart';
import 'package:negmt_heliopolis/core/widgets/item_widget.dart';
import 'package:negmt_heliopolis/features/Liked/presentation/view_model/cubit/liked_cubit.dart';

// ignore: must_be_immutable
class BodySuccessWidget extends StatefulWidget {
  FetchLikedSuccess state;
  BodySuccessWidget({super.key, required this.state});

  @override
  State<BodySuccessWidget> createState() => _BodySuccessWidgetState();
}

class _BodySuccessWidgetState extends State<BodySuccessWidget> {
  final LikedNotifier likedNotifier = LikedNotifier();

  @override
  void initState() {
    likedNotifier.addListener(removeUnlikedProduct);
    super.initState();
  }

  void removeUnlikedProduct() {
    widget.state.product.products
        ?.removeWhere((item) => item.id == likedNotifier.productId);
    setState(() {});
  }

  @override
  void dispose() {
    likedNotifier.removeListener(removeUnlikedProduct);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 20,
        ),
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget.state.product.products!.length,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 150,
            crossAxisSpacing: 7,
            mainAxisSpacing: 10,
            mainAxisExtent: 220,
            // childAspectRatio: 1 / 2,
          ),
          itemBuilder: (context, index) => ItemWidget(
            key: ValueKey(widget.state.product.products?[index].id),
            relatedProductsModel: widget.state.product.products?[index],
          ),
        ),
      ),
    );
  }
}

// Widget bodySuccessWidget(FetchLikedSuccess state) {

//   void removeUnlikedProduct(int productId) {
//     state.product.products?.removeWhere((item) => item.id == productId);
//   }

//   return SingleChildScrollView(
//     physics: const BouncingScrollPhysics(),
//     child: Padding(
//       padding: const EdgeInsets.symmetric(
//         horizontal: 10,
//         vertical: 20,
//       ),
//       child: GridView.builder(
//         physics: const NeverScrollableScrollPhysics(),
//         shrinkWrap: true,
//         itemCount: state.product.products!.length,
//         gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
//           maxCrossAxisExtent: 150,
//           crossAxisSpacing: 7,
//           mainAxisSpacing: 10,
//           mainAxisExtent: 220,
//           // childAspectRatio: 1 / 2,
//         ),
//         itemBuilder: (context, index) => ItemWidget(
//           relatedProductsModel: state.product.products?[index],
//         ),
//       ),
//     ),
//   );
// }
