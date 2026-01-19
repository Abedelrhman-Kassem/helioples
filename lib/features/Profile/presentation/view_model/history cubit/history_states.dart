import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:negmt_heliopolis/features/Profile/data/model/order_details.dart';
import 'package:negmt_heliopolis/features/Profile/data/model/order_history.dart';

part 'history_states.freezed.dart';

@freezed
class HistoryState with _$HistoryState {
  const factory HistoryState.initial() = HistoryInitial;
  const factory HistoryState.loading() = HistoryLoading;
  const factory HistoryState.loadingMore(List<ItemHistory> history) =
      HistoryLoadingMore;
  const factory HistoryState.success(List<ItemHistory> history) =
      HistorySuccess;
  const factory HistoryState.failure(String msg) = HistoryFailure;
}

@freezed
class OrderDetailsState with _$OrderDetailsState {
  const factory OrderDetailsState.initial() = OrderDetailsInitial;
  const factory OrderDetailsState.loading() = OrderDetailsLoading;
  const factory OrderDetailsState.success(OrderDetails orderDetails) =
      OrderDetailsSuccess;
  const factory OrderDetailsState.failure(String msg) = OrderDetailsFailure;
}
