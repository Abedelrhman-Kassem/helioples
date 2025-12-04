import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:negmt_heliopolis/generated/locale_keys.g.dart';

class ActiveOrdersScreen extends StatelessWidget {
  const ActiveOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        LocaleKeys.history_screen_Active.tr(),
      ),
    );
  }
}
