import 'package:freezed_annotation/freezed_annotation.dart';

part 'verfy_login_states.freezed.dart';

@freezed
class VerfyLoginStates with _$VerfyLoginStates {
  const factory VerfyLoginStates.initial() = VerfyLoginInitial;
  const factory VerfyLoginStates.loading() = VerfyLoginLoading;
  const factory VerfyLoginStates.failure(String errorMessage) =
      VerfyLoginFailure;
  const factory VerfyLoginStates.success(bool result) = VerfyLoginSuccess;
  const factory VerfyLoginStates.clearText() = ClearText;
}
