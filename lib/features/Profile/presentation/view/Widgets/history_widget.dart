import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/widgets/problem_page.dart';
import 'package:negmt_heliopolis/features/Profile/data/repo/order%20history%20repo/order_history_repo_imp.dart';
import 'package:negmt_heliopolis/features/Profile/presentation/view/Widgets/history_shimmer_loading.dart';
import 'package:negmt_heliopolis/features/Profile/presentation/view/Widgets/orders_list_view.dart';
import 'package:negmt_heliopolis/features/Profile/presentation/view_model/history%20cubit/history_cubit.dart';
import 'package:negmt_heliopolis/features/Profile/presentation/view_model/history%20cubit/history_states.dart';
import 'package:negmt_heliopolis/generated/locale_keys.g.dart';

class HistoryWidget extends StatefulWidget {
  final String status;
  final bool isActive;
  final bool includeCancelled;
  const HistoryWidget({
    super.key,
    this.status = "",
    required this.isActive,
    required this.includeCancelled,
  });

  @override
  State<HistoryWidget> createState() => _HistoryWidgetState();
}

class _HistoryWidgetState extends State<HistoryWidget> {
  late ScrollController _scrollController;
  late HistoryCubit _historyCubit;

  @override
  void initState() {
    super.initState();
    _scrollController = .new();

    _historyCubit = HistoryCubit(OrderHistoryRepoImp(api: Get.find()));
    _historyCubit.fetchHistory(
      widget.status,
      widget.isActive,
      widget.includeCancelled,
    );

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _historyCubit.fetchHistory(
          widget.status,
          widget.isActive,
          widget.includeCancelled,
        );
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _historyCubit,
      child: BlocBuilder<HistoryCubit, HistoryState>(
        builder: (context, state) {
          return state.maybeWhen(
            success: (history) {
              if (_historyCubit.orderHistoryList.isNotEmpty) {
                return OrdersListView(
                  scrollController: _scrollController,
                  orderHistoryList: _historyCubit.orderHistoryList,
                  isFetching: _historyCubit.isFetching,
                );
              } else {
                return Center(
                  child: Text(LocaleKeys.history_screen_no_orders_found.tr()),
                );
              }
            },
            loadingMore: (history) {
              return OrdersListView(
                scrollController: _scrollController,
                orderHistoryList: _historyCubit.orderHistoryList,
                isFetching: _historyCubit.isFetchingMore,
              );
            },
            loading: () => historyShimmerLoading(),
            failure: (msg) {
              if (msg == "Unauthorized, please login again") {
                return Center(
                  child: InfoMessageWidget(
                    buttonText: LocaleKeys
                        .comleted_order_screen_completed_order_screen_no_profile_information,
                    imagePath: "assets/Icons_logos/Social 03.png",
                    title: LocaleKeys
                        .comleted_order_screen_completed_order_screen_no_profile_information,
                    description: LocaleKeys
                        .comleted_order_screen_completed_order_screen_no_profile_information,
                    onPressed: () {
                      Navigator.pushNamed(context, signInScreen);
                    },
                  ),
                );
              }
              return Center(child: Text(msg.toString()));
            },
            orElse: () => Center(
              child: Text(
                LocaleKeys.order_details_screen_something_went_wrong.tr(),
              ),
            ),
          );
        },
      ),
    );
  }
}
