import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/language/cubit/locale_cubit.dart';
import 'package:negmt_heliopolis/core/widgets/return_arrow.dart';
import 'package:negmt_heliopolis/features/Home_layout/presentation/view_model/cubit/home_layout_cubit.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  bool _isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocaleCubit, ChangeLocaleState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        HomeLayoutCubit homeLayoutCubit =
            BlocProvider.of<HomeLayoutCubit>(context);

        return Scaffold(
          appBar: AppBar(
            leading: returnHomeLayoutArrow(
              onTap: () {
                homeLayoutCubit.returnIndex(context);
              },
              context: context,
            ),
            title: const Text('Likes'),
            actions: const [
              // to pull Cart Component
            ],
          ),
          body: Center(
            child: SwitchListTile(
              title: const Text('Toggle Switch Langauge'),
              value: _isSwitched,
              onChanged: (bool value) {
                if (value == false) {
                  BlocProvider.of<LocaleCubit>(context).changeLanguage('en');
                } else {
                  BlocProvider.of<LocaleCubit>(context).changeLanguage('ar');
                }
                _isSwitched = value;
              },
            ),
          ),
        );
      },
    );
  }
}
