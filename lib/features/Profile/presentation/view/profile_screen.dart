import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/language/cubit/locale_cubit.dart';

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
        return Scaffold(
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
