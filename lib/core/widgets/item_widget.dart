import 'package:flutter/material.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/helper.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/heart_widget.dart';
import 'package:negmt_heliopolis/core/widgets/item_counter_widget.dart';
import 'package:negmt_heliopolis/features/SpecialOffersItem/presentation/view/widgets/discount_widget.dart';

// ignore: must_be_immutable
class ItemWidget extends StatefulWidget {
  final Color? color;

  int counter  ;
  bool isFavorite ;
  ItemWidget({
    super.key, 
     this.color,
     required this.counter,
     required this.isFavorite,
  });

  @override
  State<ItemWidget> createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, productScreen);
      },
      child: Container(
        width: 113,
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 10,
        ),
        decoration: BoxDecoration(
          color: widget.color ?? const Color.fromRGBO(241, 241, 241, 1), 
          borderRadius: BorderRadius.circular(15.5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
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
                    style: Styles.styles8w400interFamily.copyWith(fontSize: 8),
                  ),
                ),
                HeartWidget(
                  isFavorite: false,
                  width: 22,
                  height: 20.37,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Helper.loadNetworkImage(
              assetsErrorPath: 'assets/test_images/mango-category.png',
            ),
            const SizedBox(height: 10),
            ItemCounterWidget(
              counter: widget.counter,
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
                      style:
                          Styles.styles16w800interFamily.copyWith(fontSize: 16),
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
