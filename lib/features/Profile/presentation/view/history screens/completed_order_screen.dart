import 'package:flutter/material.dart';
import 'package:negmt_heliopolis/features/Profile/presentation/view/Widgets/history_widget.dart';

class CompletedOrderScreen extends StatelessWidget {
  const CompletedOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const HistoryWidget(
      isActive: false,
      includeCancelled: false,
      status: 'Completed',
    );
  }
}
