import 'package:equatable/equatable.dart';
import 'package:negmt_heliopolis/features/Profile/data/model/order_history.dart';

abstract class FetchHistoryState extends Equatable
{
  const FetchHistoryState() ; 
   @override
  List<Object> get props => [];
}

class FetchHistoryInitial extends FetchHistoryState {}

class FetchHistoryLoading extends FetchHistoryState {}

class FetchHistorySuccess extends FetchHistoryState{
    final List<OrderHistory> history ; 
    const FetchHistorySuccess(this.history);

}

class FetchHistoryFailure extends FetchHistoryState {
  final String msg ; 
  const FetchHistoryFailure(this.msg) ; 

  
}