import 'package:negmt_heliopolis/features/Profile/data/model/notification.dart';

abstract class FetchAlertsState
{
  const FetchAlertsState();
  List<Object> get props => [];
}

class FetchAlertsInitial extends FetchAlertsState {}
class FetchAlertsLoading extends FetchAlertsState{}
class FetchAlertsSuccess extends FetchAlertsState {
  final List<Alerts> alerts ; 
  const FetchAlertsSuccess(this.alerts);
}
class FetchAlertsFailure extends FetchAlertsState
{
  final String msg ; 
  const FetchAlertsFailure(this.msg);

}