import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:negmt_heliopolis/features/Profile/data/model/order_history.dart';
import 'package:negmt_heliopolis/features/Profile/data/repo/order%20history%20repo/order_history_repo_imp.dart';
import 'package:negmt_heliopolis/features/Profile/presentation/view_model/history%20cubit/history_states.dart';

class HistoryCubit extends Cubit<HistoryState> {
  final OrderHistoryRepoImp repo;
  List<ItemHistory> orderHistoryList = [];
  int currentPage = 1;
  int pageSize = 15;
  bool isFetching = false;
  bool isFetchingMore = false;

  HistoryCubit(this.repo) : super(const HistoryState.initial());

  Future<void> fetchHistory(
    String status,
    bool isActive,
    bool includeCanceled,
  ) async {
    if (isFetching || isFetchingMore) {
      return;
    }
    if (orderHistoryList.isNotEmpty) {
      isFetchingMore = true;
    }

    isFetching = true;

    if (orderHistoryList.isEmpty) {
      emit(const HistoryState.loading());
    } else {
      emit(HistoryState.loadingMore(List.from(orderHistoryList)));
    }
    var result = await repo.getOrdersHistory(
      currentPage,
      status,
      isActive,
      includeCanceled,
      pageSize,
    );
    result.fold(
      (failure) {
        isFetching = false;
        if (!isClosed) {
          emit(HistoryState.failure(failure.errorMessage));
        }
      },
      (history) {
        isFetching = false;
        if (history.isNotEmpty) {
          orderHistoryList.addAll(history);
          currentPage++;
          if (!isClosed) {
            emit(HistoryState.success(List.from(orderHistoryList)));
          }
        } else {
          if (!isClosed) {
            emit(HistoryState.success(List.from(orderHistoryList)));
          }
        }
      },
    );
    isFetchingMore = false;
  }
}

class OrderDetailsCubit extends Cubit<OrderDetailsState> {
  final OrderHistoryRepoImp repo;
  OrderDetailsCubit(this.repo) : super(const OrderDetailsState.initial());

  Future<void> getOrderDetails(String id) async {
    emit(const OrderDetailsState.loading());
    var result = await repo.getOrderDetails(id);
    result.fold(
      (failure) {
        if (!isClosed) {
          emit(OrderDetailsState.failure(failure.errorMessage));
        }
      },
      (orderDetails) {
        if (!isClosed) {
          emit(OrderDetailsState.success(orderDetails));
        }
      },
    );
  }
}
