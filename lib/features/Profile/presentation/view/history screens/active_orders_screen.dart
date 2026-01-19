import 'package:flutter/material.dart';
import 'package:negmt_heliopolis/features/Profile/presentation/view/Widgets/history_widget.dart';

class ActiveOrdersScreen extends StatelessWidget {
  const ActiveOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const HistoryWidget(isActive: true, includeCancelled: false);
  }
}
