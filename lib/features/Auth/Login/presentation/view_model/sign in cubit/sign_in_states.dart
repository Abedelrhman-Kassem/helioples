import 'package:equatable/equatable.dart';

sealed class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object> get props => [];
}

final class SignInInitial extends SignInState {}

final class SignInLoading extends SignInState {}

final class SignInOtpLoading extends SignInState {}

final class SignInOtpFailure extends SignInState {
  final String errorMessage;

  const SignInOtpFailure(this.errorMessage);
}

final class SignInOtpSuccess extends SignInState {
  final bool result;

  const SignInOtpSuccess(this.result);
}

final class SignInSuccess extends SignInState {
  final Map<String, dynamic> result;

  const SignInSuccess(this.result);
}

final class SignInFailure extends SignInState {
  final String errorMessage;

  const SignInFailure(this.errorMessage);
}
