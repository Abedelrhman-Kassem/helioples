import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:negmt_heliopolis/features/Auth/Login/presentation/view_model/models/login_model.dart';

part 'sign_in_states.freezed.dart';

@freezed
class SignInStates with _$SignInStates {
  const factory SignInStates.initial() = SignInInitial;
  const factory SignInStates.loading() = SignInLoading;
  const factory SignInStates.otpLoading() = SignInOtpLoading;
  const factory SignInStates.otpFailure(String errorMessage) = SignInOtpFailure;
  const factory SignInStates.otpSuccess(bool result) = SignInOtpSuccess;
  const factory SignInStates.success(LoginModel result) = SignInSuccess;
  const factory SignInStates.failure(String errorMessage) = SignInFailure;
}
