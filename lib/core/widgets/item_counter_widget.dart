import 'package:flutter/material.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/svg_asset.dart';

// ignore: must_be_immutable
class ItemCounterWidget extends StatefulWidget {
  int counter;
  ItemCounterWidget({
    super.key,
    required this.counter,
  });

  @override
  State<ItemCounterWidget> createState() => _ItemCounterWidgetState();
}

class _ItemCounterWidgetState extends State<ItemCounterWidget> {
  @override
  Widget build(BuildContext context) {
    final bool isExpanded = widget.counter > 0;

    return AnimatedContainer(
      alignment: Alignment.center,
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      width: isExpanded ? 85 : 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: isExpanded ? MyColors.mainColor : Colors.transparent,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (isExpanded) ...[
            InkWell(
              onTap: () {
                setState(() {
                  if (widget.counter > 0) {
                    widget.counter--;
                  }
                });
              },
              child: svgIcon(
                path: 'assets/svg_icons/empty-minus.svg',
                width: 18.5,
                height: 18.5,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              '${widget.counter}',
              style: Styles.styles12w400NormalWhite.copyWith(
                fontSize: 12,
              ),
            ),
            const SizedBox(width: 10),
          ],
          InkWell(
            onTap: () {
              setState(() {
                widget.counter++;
              });
            },
            child: svgIcon(
              path: 'assets/svg_icons/empty-plus.svg',
              width: 18.5,
              height: 18.5,
              color: isExpanded ? Colors.white : MyColors.mainColor,
            ),
          ),
        ],
      ),
    );
  }
}
