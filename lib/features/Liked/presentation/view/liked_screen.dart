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
import 'package:negmt_heliopolis/generated/locale_keys.g.dart';

class LikedScreen extends StatelessWidget {
  const LikedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeLayoutCubit homeLayoutCubit = context.read<HomeLayoutCubit>();

    return Scaffold(
      appBar: AppBar(
        leading: returnArrow(
          onTap: () {
            homeLayoutCubit.returnIndex(context);
          },
          context: context,
        ),
        title: Text(LocaleKeys.liked_screen_likes.tr()),
        actions: const [CartCounter()],
      ),
      body: BlocProvider(
        create: (context) => LikedCubit()..getLikedProducts(),
        child: BlocBuilder<LikedCubit, LikedState>(
          builder: (context, state) {
            if (state is FetchLikedLoading &&
                context.read<LikedCubit>().products.isEmpty) {
              return gridProductsLoading(9);
            }

            if (state is FetchLikedFailure &&
                context.read<LikedCubit>().products.isEmpty) {
              return bodyFailedWidget(state.message);
            }

            if (state is UnLoggedState) {
              return bodyUnAuthorized(context);
            }

            return BodySuccessWidget(
              productList: context.read<LikedCubit>().products,
            );
          },
        ),
      ),
      floatingActionButton: const CartContainer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
