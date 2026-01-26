import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/helper.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_service.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/notification_button_controlled.dart';
import 'package:negmt_heliopolis/features/Liked/presentation/view/widgets/heart_widget.dart';
import 'package:negmt_heliopolis/core/widgets/item_counter_widget.dart';
import 'package:negmt_heliopolis/features/Notification/data/repo/notification_repo_imp.dart';
import 'package:negmt_heliopolis/features/Product/data/model/product_model.dart';
import 'package:negmt_heliopolis/core/utlis/notifiers/subscription_notifier.dart';
import 'package:negmt_heliopolis/features/SpecialOffersItem/presentation/view/widgets/discount_widget.dart';

class ItemWidget extends StatefulWidget {
  final Color? color;
  final Products relatedProductsModel;
  final String? heroTagPrefix;
  final void Function()? onTap;

  const ItemWidget({
    super.key,
    this.color,
    required this.relatedProductsModel,
    this.heroTagPrefix,
    this.onTap,
  });

  @override
  State<ItemWidget> createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  double counter = 0;

  @override
  Widget build(BuildContext context) {
    var product = widget.relatedProductsModel;

    return GestureDetector(
      onTap: () {
        // Navigator.pushNamed(
        //   context,
        //   productScreen,
        //   arguments: {'productId': product.id, 'product': product},
        // );
      },
      child: Container(
        width: 120,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 6),
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
                  InkWell(
                    onTap: () {
                      if (widget.onTap != null) {
                        widget.onTap!();
                      }
                      Navigator.pushNamed(
                        context,
                        productScreen,
                        arguments: {
                          'productId': product.id,
                          'product': product,
                        },
                      );
                    },
                    child: Hero(
                      tag: widget.heroTagPrefix != null
                          ? "${widget.heroTagPrefix}${product.id}"
                          : product.id!,
                      child: Helper.loadNetworkImage(
                        imageHeight: 150.h,
                        url: product.thumbnailImage ?? '',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Positioned.directional(
                    textDirection: Directionality.of(context),
                    end: 0,
                    bottom: 0,
                    child: SizedBox(
                      height: 30,
                      child: product.availableQuantity! > 0
                          ? ItemCounterWidget(
                              itemUiModel: Products(
                                id: product.id!,
                                name: product.name!,
                                enName: product.enName ?? 'enName',
                                enDescription:
                                    product.description ?? 'enDescription',
                                description:
                                    product.description ?? 'description',
                                thumbnailImage: product.thumbnailImage ?? '',
                                price: product.price!,
                                discount: product.discount ?? 0,
                                availableQuantity: product.availableQuantity!,
                                quantity: counter,
                              ),
                            )
                          : NotificationButtonControlled(
                              isnotification: product.isSubscribed ?? false,
                              productId: product.id!,
                              addNotiOrRemoveNoti: () async {
                                final notificationRepo = NotificationRepoImp(
                                  api: Get.find<ApiService>(),
                                );
                                if (product.isSubscribed == true) {
                                  // Unsubscribe
                                  product.isSubscribed = false;
                                  SubscriptionNotifier().triggerNotification(
                                    product.id!,
                                    false,
                                  );
                                  await notificationRepo.unsubscribe(
                                    eventType: '6',
                                    targetId: product.id!,
                                  );
                                } else {
                                  // Subscribe
                                  product.isSubscribed = true;
                                  SubscriptionNotifier().triggerNotification(
                                    product.id!,
                                    true,
                                  );
                                  await notificationRepo.subscribe(
                                    eventType: "6",
                                    targetType: 'Product',
                                    targetId: product.id!,
                                    route: 'Product',
                                  );
                                }
                              },
                            ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Row(
                      mainAxisAlignment: product.price! == 0
                          ? MainAxisAlignment.spaceBetween
                          : MainAxisAlignment.end,
                      children: [
                        // if (product.availableQuantity == 0)
                        // Container(
                        //   padding: const EdgeInsets.symmetric(
                        //     horizontal: 7.34,
                        //     vertical: 3.67,
                        //   ),
                        //   decoration: BoxDecoration(
                        //     color: const Color.fromRGBO(248, 147, 31, 0.1),
                        //     borderRadius: BorderRadius.circular(3.67),
                        //   ),
                        //   child: Text(
                        //     'Sold Out',
                        //     style: Styles.styles8w400interFamily
                        //         .copyWith(fontSize: 8),
                        //   ),
                        // ),
                        HeartWidget(
                          isFavorite: product.isLiked ?? false,
                          width: 22,
                          height: 20.37,
                          productId: product.id!,
                        ),
                      ],
                    ),
                  ),
                  if (product.state != "InStock")
                    Positioned(
                      left: 3.w,
                      top: 13.h,
                      child: _statusItem(product.state!),
                    ),
                ],
              ),
            ),
            // const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: AlignmentDirectional.centerStart,
                    child: RichText(
                      text: Helper.priceSpan(
                        product.afterDiscount ?? product.price!,
                        Styles.styles16w800interFamily.copyWith(
                          fontSize: 17.sp,
                        ),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                if (product.price != product.afterDiscount)
                  Expanded(
                    child: discountWidget(
                      discount: Helper.formatPrice(product.price!),
                      alignBottom: 6,
                      color: const Color.fromRGBO(204, 42, 40, 1),
                      textStyle: const TextStyle(
                        fontFamily: interFamily,
                        color: Color.fromRGBO(204, 42, 40, 1),
                        fontWeight: FontWeight.w500,
                        fontSize: 10,
                      ),
                    ),
                  ),
              ],
            ),

            SizedBox(
              height: 50.h,
              child: Text(
                product.displayName,
                style: Styles.styles10w300interFamily.copyWith(fontSize: 13),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _statusItem(String status) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 7.34, vertical: 3.67),
    decoration: BoxDecoration(
      color: const Color.fromRGBO(248, 147, 31, 0.1),
      borderRadius: BorderRadius.circular(3.67),
    ),
    child: Text(
      status,
      style: Styles.styles8w400interFamily.copyWith(fontSize: 8),
    ),
  );
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
