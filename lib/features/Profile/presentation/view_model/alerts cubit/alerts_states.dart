import 'package:negmt_heliopolis/features/Profile/data/model/notification.dart';

abstract class FetchAlertsState {
  const FetchAlertsState();
  List<Object> get props => [];
}

class FetchAlertsInitial extends FetchAlertsState {}

class FetchAlertsLoading extends FetchAlertsState {}

class FetchAlertsSuccess extends FetchAlertsState {
  final List<Alerts> alerts;
  final bool hasMore;
  final bool isPaginationLoading;
  const FetchAlertsSuccess({
    required this.alerts,
    this.hasMore = true,
    this.isPaginationLoading = false,
  });

  FetchAlertsSuccess copyWith({
    List<Alerts>? alerts,
    bool? hasMore,
    bool? isPaginationLoading,
  }) {
    return FetchAlertsSuccess(
      alerts: alerts ?? this.alerts,
      hasMore: hasMore ?? this.hasMore,
      isPaginationLoading: isPaginationLoading ?? this.isPaginationLoading,
    );
  }
}

class FetchAlertsFailure extends FetchAlertsState {
  final String msg;
  const FetchAlertsFailure(this.msg);
}
