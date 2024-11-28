import 'package:equatable/equatable.dart';

sealed class SubmitReportState extends Equatable {
  const SubmitReportState();

  @override
  List<Object> get props => [];
}

final class SubmitReportInitial extends SubmitReportState {}

final class SubmitReportLoading extends SubmitReportState {}

final class SubmitReportSuccess extends SubmitReportState {
  final String status;

  const SubmitReportSuccess( this.status);
}

final class SubmitReportFailure extends SubmitReportState {
  final String errorMessage;

  const SubmitReportFailure(this.errorMessage);
}