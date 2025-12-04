import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:negmt_heliopolis/core/widgets/cart_container.dart';
import 'package:negmt_heliopolis/core/widgets/cart_counter.dart';
import 'package:negmt_heliopolis/core/widgets/return_arrow.dart';
import 'package:negmt_heliopolis/features/Home_layout/presentation/view_model/cubit/home_layout_cubit.dart';
import 'package:negmt_heliopolis/features/Liked/presentation/view/widgets/body_failed_widget.dart';
import 'package:negmt_heliopolis/core/widgets/skeletonizer_loading.dart';
import 'package:negmt_heliopolis/features/Liked/presentation/view/widgets/body_success_widget.dart';
import 'package:negmt_heliopolis/features/Liked/presentation/view/widgets/body_unauthorized.dart';
import 'package:negmt_heliopolis/features/Liked/presentation/view_model/cubit/liked_cubit.dart';
import 'package:negmt_heliopolis/features/Product/data/model/product_model.dart';
import 'package:negmt_heliopolis/generated/locale_keys.g.dart';

class LikedScreen extends StatefulWidget {
  const LikedScreen({super.key});

  @override
  State<LikedScreen> createState() => _LikedScreenState();
}

class _LikedScreenState extends State<LikedScreen> {
  late List<RelatedProductsModel> products;
  @override
  void initState() {
    products = [];
    super.initState();
  }

  Widget bodyWidget = const Center(
    child: Text('Initial'),
  );

  @override
  Widget build(BuildContext context) {
    HomeLayoutCubit homeLayoutCubit = BlocProvider.of<HomeLayoutCubit>(context);

    return Scaffold(
      appBar: AppBar(
        leading: returnArrow(
          onTap: () {
            homeLayoutCubit.returnIndex(context);
          },
          context: context,
        ),
        title: Text(LocaleKeys.liked_screen_likes.tr()),
        actions: const [
          CartCounter(),
        ],
      ),
      body: BlocProvider(
        create: (context) => LikedCubit()..getLikedProducts(),
        child: BlocConsumer<LikedCubit, LikedState>(
          listener: (context, state) {
            if (state is FetchLikedLoading && products.isEmpty) {
              bodyWidget = gridProductsLoading(9);
            }

            if (state is FetchLikedSuccess) {
              products.addAll(state.product.products!);
              bodyWidget = BodySuccessWidget(productList: products);
            }

            if (state is FetchLikedFailure) {
              bodyWidget = bodyFailedWidget(state.message);
            }

            if (state is UnLoggedState) {
              bodyWidget = bodyUnAuthorized(context);
            }
          },
          builder: (context, state) {
            return bodyWidget;
          },
        ),
      ),
      floatingActionButton: const CartContainer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
