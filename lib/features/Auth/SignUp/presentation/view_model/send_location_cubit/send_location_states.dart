import 'package:equatable/equatable.dart';

sealed class SendLocationState extends Equatable {
  const SendLocationState();

  @override
  List<Object> get props => [];
}

final class SendLocationInitial extends SendLocationState {}

final class SendLocationLoading extends SendLocationState {}

final class SendLocationSuccess extends SendLocationState {
  final String status;

  const SendLocationSuccess(this.status);

  @override
  List<Object> get props => [status];
}

final class SendLocationFailure extends SendLocationState {
  final String errorMessage;

  const SendLocationFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
