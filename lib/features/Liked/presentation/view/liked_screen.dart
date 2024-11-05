import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:negmt_heliopolis/core/widgets/cart_container.dart';
import 'package:negmt_heliopolis/core/widgets/cart_counter.dart';
import 'package:negmt_heliopolis/core/widgets/return_arrow.dart';
import 'package:negmt_heliopolis/features/Home_layout/presentation/view_model/cubit/home_layout_cubit.dart';
import 'package:negmt_heliopolis/features/Liked/presentation/view/widgets/body_failed_widget.dart';
import 'package:negmt_heliopolis/features/Liked/presentation/view/widgets/body_loading_widget.dart';
import 'package:negmt_heliopolis/features/Liked/presentation/view/widgets/body_success_widget.dart';
import 'package:negmt_heliopolis/features/Liked/presentation/view/widgets/body_unauthorized.dart';
import 'package:negmt_heliopolis/features/Liked/presentation/view_model/cubit/liked_cubit.dart';

class LikedScreen extends StatefulWidget {
  const LikedScreen({super.key});

  @override
  State<LikedScreen> createState() => _LikedScreenState();
}

class _LikedScreenState extends State<LikedScreen> {
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
        title: const Text('Likes'),
        actions: const [
          CartCounter(),
        ],
      ),
      body: BlocProvider(
        create: (context) => LikedCubit()..getAllLikedProducts(),
        child: BlocConsumer<LikedCubit, LikedState>(
          listener: (context, state) {
            if (state is FetchLikedLoading) {
              bodyWidget = bodyLoadingWidget();
            }

            if (state is FetchLikedSuccess) {
              bodyWidget = BodySuccessWidget(state: state);
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
