import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:negmt_heliopolis/core/widgets/return_arrow.dart';
import 'package:negmt_heliopolis/features/Home_layout/presentation/view_model/cubit/home_layout_cubit.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

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
        title: const Text('Explore'),
        actions: const [
          // to pull Cart Component
        ],
      ),
      body: Text('hello from explore screen'),
    );
  }
}
