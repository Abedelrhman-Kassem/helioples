import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:negmt_heliopolis/features/Profile/data/model/order_history.dart';
import 'package:negmt_heliopolis/features/Profile/data/repo/order%20history%20repo/order_history_repo_imp.dart';
import 'package:negmt_heliopolis/features/Profile/presentation/view_model/history%20cubit/history_states.dart';

class HistoryCubit extends Cubit<FetchHistoryState> {
  final OrderHistoryRepoImp repo;
  List<OrderHistory> orderHistoryList = [];
  int currentPage = 1;
  bool isFetching = false;

  HistoryCubit(this.repo) : super(FetchHistoryInitial());

  Future<void> fetchHistory(String status) async {
    print("inside cubit");
    if (isFetching) return;
    isFetching = true;
    emit(FetchHistoryLoading());
    var result = await repo.getOrdersHistory(currentPage, status);
    result.fold((failure) {
      emit(FetchHistoryFailure(failure.errorMessage));
      isFetching = false;
    }, (history) {
      if (history.isNotEmpty) {
        orderHistoryList.addAll(history);
        currentPage++;
        emit(FetchHistorySuccess(orderHistoryList));
      }
      isFetching = false;
    });
  }
}
