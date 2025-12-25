import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/db_helper.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/custom_snack_bar.dart';
import 'package:negmt_heliopolis/core/widgets/svg_asset.dart';
import 'package:negmt_heliopolis/features/Product/data/model/product_model.dart';

class ItemCounterWidget extends StatefulWidget {
  final Products itemUiModel;

  const ItemCounterWidget({super.key, required this.itemUiModel});

  @override
  State<ItemCounterWidget> createState() => _ItemCounterWidgetState();
}

class _ItemCounterWidgetState extends State<ItemCounterWidget> with RouteAware {
  bool _showDetails = false;
  Timer? _detailsTimer;
  final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      _loadCounterFromDB();
    });
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    _detailsTimer?.cancel();
    super.dispose();
  }

  int counter = 0;
  late bool isExpanded;

  @override
  void initState() {
    super.initState();
    isExpanded = false;

    _loadCounterFromDB();
  }

  // Load counter from SQLite DB
  Future<void> _loadCounterFromDB() async {
    final value = await DBHelper.queryData(
      table: cartTable,
      columns: [cartItemQty],
      where: 'id = ?',
      whereArgs: [widget.itemUiModel.id],
    );

    if (value.isNotEmpty) {
      counter = int.parse(value.first[cartItemQty].toString());
      if (mounted) {
        setState(() {});
      }
    } else {
      counter = 0;
      if (mounted) {
        setState(() {});
      }
    }
    isExpanded = counter > 0;
  }

  Future<void> _deleteItem() async {
    try {
      DBHelper.deleteData(
        table: cartTable,
        where: 'id = ?',
        whereArgs: [widget.itemUiModel.id],
      );
    } catch (e) {
      if (kDebugMode) {
        print('$e');
      }
    }
  }

  Future<void> _updateCounterInDB(int newCounter) async {
    await DBHelper.insertData(
      table: cartTable,
      values: {
        cartItemId: widget.itemUiModel.id,
        cartItemName: widget.itemUiModel.name,
        cartItemEnName: widget.itemUiModel.enName,
        cartItemEnDesc: widget.itemUiModel.description,
        cartItemDesc: widget.itemUiModel.description,
        cartItemQty: newCounter,
        cartItemImageUrl: widget.itemUiModel.thumbnailImage,
        cartItemPrice: widget.itemUiModel.price,
        cartItemDiscount: widget.itemUiModel.discount,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildCounterWidget();
  }

  Widget _buildCounterWidget() {
    isExpanded = counter > 0;
    _scheduleShowDetails(isExpanded);

    return AnimatedContainer(
      alignment: Alignment.center,
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      width: isExpanded ? 95 : 33,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: isExpanded ? MyColors.mainColor : Colors.transparent,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (isExpanded) ...[
            if (_showDetails)
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: _showDetails
                    ? InkWell(
                        key: ValueKey(counter),
                        onTap: () async {
                          if (counter > 1) {
                            setState(() => counter--);
                            await _updateCounterInDB(counter);
                          } else {
                            setState(() => counter--);
                            await _deleteItem();
                          }
                        },
                        child: svgIcon(
                          path: 'assets/svg_icons/empty-minus.svg',
                          width: 22,
                          height: 22,
                          color: Colors.white,
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            if (_showDetails) const SizedBox(width: 10),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: _showDetails
                  ? Text(
                      '$counter',
                      key: ValueKey(counter),
                      style: Styles.styles12w400NormalWhite.copyWith(
                        fontSize: 12,
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
            if (_showDetails) const SizedBox(width: 10),
          ],
          InkWell(
            onTap: () async {
              if (counter < widget.itemUiModel.availableQuantity!) {
                setState(() => counter++);
                await _updateCounterInDB(counter);
              } else {
                CustomSnackBar.show(
                  context: context,
                  duration: const Duration(seconds: 10),
                  text:
                      "You can't increase above ${widget.itemUiModel.availableQuantity}",
                  isGreen: false,
                );
              }
            },
            child: svgIcon(
              path: 'assets/svg_icons/empty-plus.svg',
              width: 22,
              height: 22,
              color: isExpanded ? Colors.white : MyColors.mainColor,
            ),
          ),
        ],
      ),
    );
  }

  void _scheduleShowDetails(bool isExpanded) {
    _detailsTimer?.cancel();

    if (isExpanded) {
      _detailsTimer = Timer(const Duration(milliseconds: 300), () {
        if (!mounted) return;
        setState(() {
          _showDetails = true;
        });
      });
    } else {
      if (_showDetails) {
        setState(() {
          _showDetails = false;
        });
      }
    }
  }
}
