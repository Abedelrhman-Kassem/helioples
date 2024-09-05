import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:negmt_heliopolis/core/widgets/cart_container.dart';
import 'package:negmt_heliopolis/core/widgets/cart_counter.dart';
import 'package:negmt_heliopolis/core/widgets/item_widget_grid.dart';
import 'package:negmt_heliopolis/core/widgets/svgAsset.dart';
import 'package:negmt_heliopolis/features/Home_layout/presentation/view_model/cubit/home_layout_cubit.dart';

class LikedScreen extends StatelessWidget {
  const LikedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeLayoutCubit homeLayoutCubit = BlocProvider.of<HomeLayoutCubit>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: svgIcon(
            path: 'assets/svg_icons/arrow-left.svg',
            width: 29,
            height: 29,
            color: const Color.fromRGBO(41, 45, 50, 1),
          ),
          onPressed: () {
            homeLayoutCubit.returnIndex();
          },
        ),
        title: const Text('Likes'),
        actions: [
          cartCounter(
            context: context,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: itemWidgetGridView(isFavorite: true),
      ),
      floatingActionButton: const CartContainer(
        svgIconPath: "assets/svg_icons/favorite-Cart.svg",
        buttonText: "Go To Cart",
        productsCount: "3",
        totalAmount: "310",
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
