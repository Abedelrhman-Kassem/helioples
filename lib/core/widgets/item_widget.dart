import 'package:flutter/material.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/helper.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/features/Liked/presentation/view/widgets/heart_widget.dart';
import 'package:negmt_heliopolis/core/widgets/item_counter_widget.dart';
import 'package:negmt_heliopolis/features/Product/data/model/product_model.dart';
import 'package:negmt_heliopolis/features/SpecialOffersItem/presentation/view/widgets/discount_widget.dart';

// ignore: must_be_immutable
class ItemWidget extends StatefulWidget {
  final Color? color;
  final RelatedProductsModel? relatedProductsModel;

  const ItemWidget({
    super.key,
    this.color,
    this.relatedProductsModel,
  });

  @override
  State<ItemWidget> createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    var product = widget.relatedProductsModel;

    if (product != null) {
      return GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            productScreen,
            arguments: {'productId': product.id},
          );
        },
        child: Container(
          width: 120,
          padding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 6,
          ),
          decoration: BoxDecoration(
            color: widget.color ?? const Color.fromRGBO(241, 241, 241, 1),
            borderRadius: BorderRadius.circular(15.5),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Helper.loadNetworkImage(
                      url: product.thumbnailImage ?? '',
                      // assetsErrorPath: 'assets/test_images/white-toast.png',
                      assetsErrorPath:
                          'assets/ayman/—Pngtree—3d beauty cosmetics product design_6380191 (1).png',
                      fit: BoxFit.contain,
                    ),
                    Positioned.directional(
                      textDirection: Directionality.of(context),
                      end: 0,
                      bottom: 0,
                      child: SizedBox(
                        height: 30,
                        child: ItemCounterWidget(
                          counter: counter,
                          itemUiModel: ItemUiModel(
                            id: product.id!,
                            name: product.name!,
                            enName: product.enName ?? 'enName',
                            enDesc: product.enDescription ?? 'enDescription',
                            description: product.enDescription ?? 'description',
                            thumbnailImage: product.thumbnailImage ?? '',
                            price: product.price!,
                            discount: product.discount ?? 0,
                            quantity: counter,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Row(
                        mainAxisAlignment: product.state != "InStock"
                            ? MainAxisAlignment.spaceBetween
                            : MainAxisAlignment.end,
                        children: [
                          if (product.state != "InStock")
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 7.34,
                                vertical: 3.67,
                              ),
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(248, 147, 31, 0.1),
                                borderRadius: BorderRadius.circular(3.67),
                              ),
                              child: Text(
                                'Sold Out',
                                style: Styles.styles8w400interFamily
                                    .copyWith(fontSize: 8),
                              ),
                            ),
                          HeartWidget(
                            isFavorite: product.isLiked!,
                            width: 22,
                            height: 20.37,
                            productId: product.id!,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    constraints: const BoxConstraints(
                      maxWidth: 74,
                    ),
                    child: RichText(
                      text: TextSpan(
                        text:
                            '${product.afterDiscount ?? product.price!.toInt()}',
                        style: Styles.styles16w800interFamily
                            .copyWith(fontSize: 16),
                        children: [
                          TextSpan(
                            text:
                                '.${((product.price! - product.price!.toInt()) * 100).round()}',
                            style: Styles.styles9w300interFamily
                                .copyWith(fontSize: 9),
                          ),
                        ],
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (product.afterDiscount != null)
                    discountWidget(
                      discount: '${product.price!}',
                      alignBottom: 6,
                      color: const Color.fromRGBO(204, 42, 40, 1),
                      textStyle: const TextStyle(
                        fontFamily: interFamily,
                        color: Color.fromRGBO(204, 42, 40, 1),
                        fontWeight: FontWeight.w500,
                        fontSize: 10,
                      ),
                    ),
                ],
              ),
              Text(
                product.name!,
                style: Styles.styles10w300interFamily.copyWith(fontSize: 13),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      );
    } else {
      // TO DO : REMOVE THIS WIDGET
      return GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            productScreen,
            arguments: {'productId': 1627},
          );
        },
        child: Container(
          width: 120,
          padding: const EdgeInsets.symmetric(
            vertical: 7,
            horizontal: 10,
          ),
          decoration: BoxDecoration(
            color: widget.color ?? const Color.fromRGBO(241, 241, 241, 1),
            borderRadius: BorderRadius.circular(15.5),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 7.34,
                      vertical: 3.67,
                    ),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(248, 147, 31, 0.1),
                      borderRadius: BorderRadius.circular(3.67),
                    ),
                    child: Text(
                      'Sold Out',
                      style:
                          Styles.styles8w400interFamily.copyWith(fontSize: 8),
                    ),
                  ),
                  const HeartWidget(
                    isFavorite: false,
                    width: 22,
                    height: 20.37,
                    productId: 1630,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Helper.loadNetworkImage(
                assetsErrorPath: 'assets/test_images/mango-category.png',
              ),
              const SizedBox(height: 10),
              ItemCounterWidget(
                counter: counter,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    constraints: const BoxConstraints(
                      maxWidth: 74,
                    ),
                    child: RichText(
                      text: TextSpan(
                        text: '750',
                        style: Styles.styles16w800interFamily
                            .copyWith(fontSize: 16),
                        children: [
                          TextSpan(
                            text: '.00',
                            style: Styles.styles9w300interFamily
                                .copyWith(fontSize: 9),
                          ),
                        ],
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  discountWidget(
                    discount: '80.00',
                    alignBottom: 6,
                    color: const Color.fromRGBO(204, 42, 40, 1),
                    textStyle: const TextStyle(
                      fontFamily: interFamily,
                      color: Color.fromRGBO(204, 42, 40, 1),
                      fontWeight: FontWeight.w500,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              Text(
                'Nestle Pure Life 5 Liters',
                style: Styles.styles10w300interFamily.copyWith(fontSize: 13),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      );
    }
  }
}

// Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: product.state != "InStock"
//                     ? MainAxisAlignment.spaceBetween
//                     : MainAxisAlignment.end,
//                 children: [
//                   if (product.state != "InStock")
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 7.34,
//                         vertical: 3.67,
//                       ),
//                       decoration: BoxDecoration(
//                         color: const Color.fromRGBO(248, 147, 31, 0.1),
//                         borderRadius: BorderRadius.circular(3.67),
//                       ),
//                       child: Text(
//                         'Sold Out',
//                         style:
//                             Styles.styles8w400interFamily.copyWith(fontSize: 8),
//                       ),
//                     ),
//                   HeartWidget(
//                     isFavorite: product.isLiked!,
//                     width: 22,
//                     height: 20.37,
//                     productId: product.id!,
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 10),
//               Expanded(
//                 child: Helper.loadNetworkImage(
//                   url: product.thumbnailImage ?? '',
//                   assetsErrorPath: 'assets/test_images/white-toast.png',
//                   fit: BoxFit.contain,
//                 ),
//               ),
//               const SizedBox(height: 10),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   ItemCounterWidget(
//                     counter: counter,
//                     itemUiModel: ItemUiModel(
//                       id: product.id!,
//                       name: product.name!,
//                       enName: product.enName ?? 'enName',
//                       enDesc: product.enDescription ?? 'enDescription',
//                       description: product.enDescription ?? 'description',
//                       thumbnailImage: product.thumbnailImage ?? '',
//                       price: product.price!,
//                       discount: product.discount ?? 0,
//                       quantity: counter,
//                     ),
//                   ),
//                 ],
//               ),
//               // const SizedBox(height: 10),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Container(
//                     constraints: const BoxConstraints(
//                       maxWidth: 74,
//                     ),
//                     child: RichText(
//                       text: TextSpan(
//                         text:
//                             '${product.afterDiscount ?? product.price!.toInt()}',
//                         style: Styles.styles16w800interFamily
//                             .copyWith(fontSize: 16),
//                         children: [
//                           TextSpan(
//                             text:
//                                 '.${((product.price! - product.price!.toInt()) * 100).round()}',
//                             style: Styles.styles9w300interFamily
//                                 .copyWith(fontSize: 9),
//                           ),
//                         ],
//                       ),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                   if (product.afterDiscount != null)
//                     discountWidget(
//                       discount: '${product.price!}',
//                       alignBottom: 6,
//                       color: const Color.fromRGBO(204, 42, 40, 1),
//                       textStyle: const TextStyle(
//                         fontFamily: interFamily,
//                         color: Color.fromRGBO(204, 42, 40, 1),
//                         fontWeight: FontWeight.w500,
//                         fontSize: 10,
//                       ),
//                     ),
//                 ],
//               ),
//               Text(
//                 product.name!,
//                 style: Styles.styles10w300interFamily.copyWith(fontSize: 13),
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ],
//           ),
        