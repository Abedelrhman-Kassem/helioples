import 'package:equatable/equatable.dart';

sealed class VerfyLoginStates extends Equatable {
  const VerfyLoginStates();

  @override
  List<Object> get props => [];
}

final class VerfyLoginInitial extends VerfyLoginStates {}

final class VerfyLoginLoading extends VerfyLoginStates {}

final class VerfyLoginFailure extends VerfyLoginStates {
  final String errorMessage;

  const VerfyLoginFailure(this.errorMessage);
}

final class VerfyLoginSuccess extends VerfyLoginStates {
  final bool result;

  const VerfyLoginSuccess(this.result);
}

final class ClearText extends VerfyLoginStates {}
