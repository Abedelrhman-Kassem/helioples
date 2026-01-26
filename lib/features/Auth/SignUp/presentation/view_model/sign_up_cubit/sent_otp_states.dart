import 'package:equatable/equatable.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_response.dart';
import 'package:negmt_heliopolis/features/Auth/Verfication_and_register/data/model/register_model.dart';

sealed class SentOtpState extends Equatable {
  const SentOtpState();

  @override
  List<Object> get props => [];
}

final class SentOtpInitial extends SentOtpState {}

final class SentOtpLoading extends SentOtpState {}

final class FailedUserExist extends SentOtpState {
  final String errorMessage;

  const FailedUserExist(this.errorMessage);
}

final class UserExist extends SentOtpState {
  final ApiResponse apiResponse;

  const UserExist(this.apiResponse);
}

final class SentOtpSuccess extends SentOtpState {
  final OtpModel otpModel;

  const SentOtpSuccess(this.otpModel);
}

final class SentOtpFailure extends SentOtpState {
  final String errorMessage;

  const SentOtpFailure(this.errorMessage);
}

final class OtpModel extends SentOtpState {
  final RegisterModel registerModel;
  String verificationId;

  OtpModel(this.registerModel, this.verificationId);
}
