import 'package:equatable/equatable.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_response.dart';

sealed class VerfAndRegisterStates extends Equatable {
  const VerfAndRegisterStates();

  @override
  List<Object> get props => [];
}

final class VerfAndRegisterInitial extends VerfAndRegisterStates {}

final class VerfOtpLoading extends VerfAndRegisterStates {}

final class RegisterLoading extends VerfAndRegisterStates {}

final class VerfOtpFailure extends VerfAndRegisterStates {
  final String errorMessage;

  const VerfOtpFailure(this.errorMessage);
}

final class RegisterFailure extends VerfAndRegisterStates {
  final String errorMessage;

  const RegisterFailure(this.errorMessage);
}

final class VerfOtpSuccess extends VerfAndRegisterStates {
  final bool result;

  const VerfOtpSuccess(this.result);
}

final class RegisterSuccess extends VerfAndRegisterStates {
  final ApiResponse result;

  const RegisterSuccess(this.result);
}

final class ClearText extends VerfAndRegisterStates {}
