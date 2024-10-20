import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/db_helper.dart';
import 'package:negmt_heliopolis/core/utlis/theming/boxshadow.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/return_arrow.dart';
import 'package:negmt_heliopolis/features/Cart/presentation/view/widgets/cart_item_widget.dart';
import 'package:negmt_heliopolis/core/widgets/svg_asset.dart';
import 'package:negmt_heliopolis/features/Cart/presentation/view/widgets/modal_bottom_sheet.dart';
import 'package:negmt_heliopolis/features/Home_layout/presentation/view_model/cubit/home_layout_cubit.dart';
import 'package:negmt_heliopolis/features/Product/data/model/product_model.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
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
    print('hello from $id');
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
      floatingActionButton: Wrap(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
            width: double.infinity,
            decoration: BoxDecoration(
              color: MyColors.mainColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.r),
                topRight: Radius.circular(30.r),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Sub Total (4 Items)',
                      style: Styles.styles14w400NormalWhite,
                    ),
                    Text(
                      '300.00 EGP',
                      style: Styles.styles15w600NormalWhite,
                    ),
                  ],
                ),
                SizedBox(height: 15.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Promocode Discount',
                      style: Styles.styles14w400NormalWhite,
                    ),
                    Text(
                      '120.00 EGP',
                      style: Styles.styles15w600NormalWhite,
                    ),
                  ],
                ),
                SizedBox(height: 15.h),
                Container(
                  height: 1.h,
                  color: const Color.fromRGBO(255, 255, 255, 1),
                ),
                SizedBox(height: 15.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Price',
                      style: Styles.styles14w400NormalWhite,
                    ),
                    Text(
                      '420.00 EGP',
                      style: Styles.styles18w800NormalWhite,
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                InkWell(
                  onTap: () async {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return const ModalBottomSheet();
                      },
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(255, 255, 255, 1),
                      borderRadius: BorderRadius.circular(36.77.r),
                      boxShadow: [
                        MyBoxShadows.checkOutBoxShadow,
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        svgIcon(
                          path: 'assets/svg_icons/wallet-check.svg',
                          width: 26.84.w,
                          height: 26.84.h,
                          color: MyColors.mainColor,
                        ),
                        SizedBox(width: 10.w),
                        RichText(
                          text: TextSpan(
                            text: 'Checkout ',
                            style: Styles.styles17w700MainColor,
                            children: [
                              TextSpan(
                                text: '420 EGP',
                                style: Styles.styles17w700MainColor,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
