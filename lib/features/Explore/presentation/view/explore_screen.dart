import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:negmt_heliopolis/core/widgets/svgAsset.dart';
import 'package:negmt_heliopolis/features/Home_layout/presentation/view_model/cubit/home_layout_cubit.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

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
        title: const Text('Explore'),
        actions: const [
          // to pull Cart Component
        ],
      ),
      body: Text('hello from explore screen'),
    );
  }
}
