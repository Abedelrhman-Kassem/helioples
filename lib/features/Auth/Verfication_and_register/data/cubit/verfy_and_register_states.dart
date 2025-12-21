import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_response.dart';

part 'verfy_and_register_states.freezed.dart';

@freezed
class VerfAndRegisterStates with _$VerfAndRegisterStates {
  const factory VerfAndRegisterStates.initial() = VerfAndRegisterInitial;
  const factory VerfAndRegisterStates.verfOtpLoading() = VerfOtpLoading;
  const factory VerfAndRegisterStates.registerLoading() = RegisterLoading;
  const factory VerfAndRegisterStates.verfOtpFailure(Failure errorMessage) =
      VerfOtpFailure;
  const factory VerfAndRegisterStates.registerFailure(String errorMessage) =
      RegisterFailure;
  const factory VerfAndRegisterStates.verfOtpSuccess(bool result) =
      VerfOtpSuccess;
  const factory VerfAndRegisterStates.registerSuccess(ApiResponse result) =
      RegisterSuccess;
  const factory VerfAndRegisterStates.clearText() = ClearText;
}
