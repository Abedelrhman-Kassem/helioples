import 'package:flutter/material.dart';
import 'package:negmt_heliopolis/features/Profile/presentation/view/Widgets/history_widget.dart';

class CanceldOrderScreen extends StatelessWidget {
  const CanceldOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const HistoryWidget(
      isActive: false,
      includeCancelled: true,
      status: 'Canceled',
    );
  }
}
