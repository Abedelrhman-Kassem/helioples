import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/db_helper.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/widgets/return_arrow.dart';
import 'package:negmt_heliopolis/features/Cart/presentation/view/widgets/cart_item_widget.dart';
import 'package:negmt_heliopolis/features/Cart/presentation/view/widgets/floating_button_widget.dart';
import 'package:negmt_heliopolis/features/Checkout/checkout_router.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view_model/delivery_cubit/delivery_cubit.dart';
import 'package:negmt_heliopolis/features/Home_layout/presentation/view_model/cubit/home_layout_cubit.dart';
import 'package:negmt_heliopolis/features/Product/data/model/product_model.dart';
import 'package:negmt_heliopolis/mytest/test.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final testRouter = OrderRouter();

    return BlocProvider(
      create: (context) => DeliveryCubit(),
      child: MaterialApp(
        onGenerateRoute: testRouter.generate,
      ),
    );
  }
}

class InitialCartScreen extends StatefulWidget {
  const InitialCartScreen({super.key});

  @override
  State<InitialCartScreen> createState() => _InitialCartScreenState();
}

class _InitialCartScreenState extends State<InitialCartScreen> {
  List<Map<String, Object?>> tableValues = [];

  @override
  void initState() {
    DBHelper.queryData(table: cartItemTable).then((value) {
      setState(() {
        tableValues = value;
      });
    });

    super.initState();
  }

  Future<void> deleteItem(int id) async {
    try {
      await DBHelper.deleteData(
        table: cartItemTable,
        where: 'id = ?',
        whereArgs: [id],
      );

      List<Map<String, dynamic>> mutableTableValues = List.from(tableValues);
      mutableTableValues.removeWhere((element) => element[cartItemId] == id);

      setState(() {
        tableValues = mutableTableValues;
      });
    } catch (e) {
      print('$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        backgroundColor: MyColors.mainScaffoldWhiteColor,
        elevation: 0,
        leading: returnArrow(
          context: context,
          onTap: () {
            try {
              BlocProvider.of<HomeLayoutCubit>(context).returnIndex(context);
            } catch (e) {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              } else {
                Navigator.pushNamed(context, homeLayout);
              }
            }
          },
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              itemBuilder: (context, index) => CartItemWidget(
                itemUiModel: ItemUiModel(
                  id: tableValues[index][cartItemId] as int,
                  name: tableValues[index][cartItemName] as String,
                  enName: tableValues[index][cartItemEnName] as String,
                  enDesc: tableValues[index][cartItemEnDesc] as String,
                  description: tableValues[index][cartItemDesc] as String,
                  thumbnailImage:
                      tableValues[index][cartItemImageUrl] as String,
                  price: tableValues[index][cartItemPrice] as double,
                  quantity: tableValues[index][cartItemQty] as int,
                  discount: tableValues[index][cartItemDiscount] as double,
                ),
                onDelete: deleteItem,
              ),
              itemCount: tableValues.length,
            ),
            SizedBox(
              height: 293.h,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const FloatingButtonWidget(),
    );
  }
}
