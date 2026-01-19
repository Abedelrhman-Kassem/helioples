import 'package:negmt_heliopolis/features/Profile/data/model/faqs.dart';

abstract class FetchFaqsState {
  const FetchFaqsState();
  List<Object> get props => [];
}

class FetchFaqsInitial extends FetchFaqsState {}

class FetchFaqsLoading extends FetchFaqsState {}

class FetchFaqsSuccess extends FetchFaqsState {
  final List<FaqsData> faqs;
  const FetchFaqsSuccess(this.faqs);
}

class FetchFaqsFailure extends FetchFaqsState {
  final String msg;
  const FetchFaqsFailure(this.msg);
}
