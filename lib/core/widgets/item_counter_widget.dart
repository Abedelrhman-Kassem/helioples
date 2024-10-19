import 'package:flutter/material.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/db_helper.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/svg_asset.dart';
import 'package:negmt_heliopolis/features/Product/data/model/product_model.dart';

// TODO remove counter when all items received successfully

// ignore: must_be_immutable
class ItemCounterWidget extends StatefulWidget {
  int counter;
  final ItemUiModel? itemUiModel;

  ItemCounterWidget({
    super.key,
    required this.counter,
    this.itemUiModel,
  });

  @override
  State<ItemCounterWidget> createState() => _ItemCounterWidgetState();
}

class _ItemCounterWidgetState extends State<ItemCounterWidget> with RouteAware {
  final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      if (widget.itemUiModel != null) {
        _loadCounterFromDB();
      }
    });
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  int counter = 0;
  late bool isExpanded;

  @override
  void initState() {
    super.initState();
    isExpanded = false;

    if (widget.itemUiModel != null) {
      _loadCounterFromDB();
    }
  }

  // Load counter from SQLite DB
  Future<void> _loadCounterFromDB() async {
    final value = await DBHelper.queryData(
      table: cartItemTable,
      columns: [cartItemQty],
      where: 'id = ?',
      whereArgs: [widget.itemUiModel!.id],
    );

    if (value.isNotEmpty) {
      setState(() {
        counter = value[0][cartItemQty] as int;
      });
    } else {
      setState(() {
        counter = 0;
      });
    }
    isExpanded = counter > 0;
  }

  Future<void> _deleteItem() async {
    if (widget.itemUiModel != null) {
      try {
        DBHelper.deleteData(
          table: cartItemTable,
          where: 'id = ?',
          whereArgs: [widget.itemUiModel!.id],
        );
      } catch (e) {
        print('$e');
      }
    }
  }

  Future<void> _updateCounterInDB(int newCounter) async {
    if (widget.itemUiModel != null) {
      await DBHelper.insertData(
        table: cartItemTable,
        values: {
          cartItemId: widget.itemUiModel!.id,
          cartItemName: widget.itemUiModel!.name,
          cartItemEnName: widget.itemUiModel!.enName,
          cartItemEnDesc: widget.itemUiModel!.enDesc,
          cartItemDesc: widget.itemUiModel!.description,
          cartItemQty: newCounter,
          cartItemImageUrl: widget.itemUiModel!.thumbnailImage,
          cartItemPrice: widget.itemUiModel!.price,
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.itemUiModel != null) {
      return _buildCounterWidget();
    } else {
      return _buildSimpleCounterWidget();
    }
  }

  Widget _buildCounterWidget() {
    isExpanded = counter > 0;

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
            InkWell(
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
            ),
            const SizedBox(width: 10),
            Text(
              '$counter',
              style: Styles.styles12w400NormalWhite.copyWith(fontSize: 12),
            ),
            const SizedBox(width: 10),
          ],
          InkWell(
            onTap: () async {
              setState(() => counter++);
              await _updateCounterInDB(counter);
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

  Widget _buildSimpleCounterWidget() {
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
              style: Styles.styles12w400NormalWhite.copyWith(fontSize: 12),
            ),
            const SizedBox(width: 10),
          ],
          InkWell(
            onTap: () {
              setState(() => widget.counter++);
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
