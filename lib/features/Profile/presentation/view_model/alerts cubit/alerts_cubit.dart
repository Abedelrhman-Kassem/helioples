import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:negmt_heliopolis/features/Notification/data/repo/notification_repo.dart';
import 'package:negmt_heliopolis/features/Profile/presentation/view_model/alerts%20cubit/alerts_states.dart';
import 'package:negmt_heliopolis/features/Profile/data/model/notification.dart';

class AlertsCubit extends Cubit<FetchAlertsState> {
  final NotificationRepo repo;
  AlertsCubit(this.repo) : super(FetchAlertsInitial());

  int _currentPage = 1;
  final int _pageSize = 15;

  Future<void> getAlerts() async {
    _currentPage = 1;
    emit(FetchAlertsLoading());
    var result = await repo.getNotifications(
      page: _currentPage,
      pageSize: _pageSize,
    );

    result.fold((failure) => emit(FetchAlertsFailure(failure.errorMessage)), (
      response,
    ) {
      List<Alerts> alerts = [];
      final items = response['data']['items'] as List;
      for (var item in items) {
        alerts.add(Alerts.fromJson(item));
      }
      final totalCount = response['data']['totalCount'] ?? 0;
      emit(
        FetchAlertsSuccess(alerts: alerts, hasMore: alerts.length < totalCount),
      );
    });
  }

  Future<void> loadMore() async {
    if (state is! FetchAlertsSuccess) return;
    final currentState = state as FetchAlertsSuccess;
    if (currentState.isPaginationLoading || !currentState.hasMore) return;

    emit(currentState.copyWith(isPaginationLoading: true));
    _currentPage++;

    var result = await repo.getNotifications(
      page: _currentPage,
      pageSize: _pageSize,
    );

    result.fold(
      (failure) {
        _currentPage--;
        emit(currentState.copyWith(isPaginationLoading: false));
      },
      (response) {
        List<Alerts> newAlerts = [];
        final items = response['data']['items'] as List;
        for (var item in items) {
          newAlerts.add(Alerts.fromJson(item));
        }
        final totalCount = response['data']['totalCount'] ?? 0;
        final allAlerts = currentState.alerts + newAlerts;

        emit(
          FetchAlertsSuccess(
            alerts: allAlerts,
            hasMore: allAlerts.length < totalCount,
            isPaginationLoading: false,
          ),
        );
      },
    );
  }

  Future<void> markNotificationAsRead(String id) async {
    var result = await repo.markAsRead(id);
    result.fold((failure) => null, (success) {
      if (state is FetchAlertsSuccess) {
        final currentState = state as FetchAlertsSuccess;
        final updatedAlerts = currentState.alerts.map((alert) {
          if (alert.id == id) {
            return Alerts.fromJson(alert.toJson()..['isRead'] = true);
          }
          return alert;
        }).toList();
        emit(currentState.copyWith(alerts: updatedAlerts));
      }
    });
  }
}
