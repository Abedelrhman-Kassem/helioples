import 'package:negmt_heliopolis/features/Profile/data/model/customer_model.dart';

abstract class UpdateProfileState {
  const UpdateProfileState();
}

class UpdateProfileInitial extends UpdateProfileState {}

class UpdateProfileLoading extends UpdateProfileState {}

class UpdateProfileSuccess extends UpdateProfileState {
  final String message;
  const UpdateProfileSuccess(this.message);
}

class UpdateProfileFailure extends UpdateProfileState {
  final String errorMessage;
  const UpdateProfileFailure(this.errorMessage);
}

class FetchProfileLoading extends UpdateProfileState {}

class FetchProfileSuccess extends UpdateProfileState {
  final CustomerModel customer;
  const FetchProfileSuccess(this.customer);
}

class FetchProfileFailure extends UpdateProfileState {
  final String errorMessage;
  const FetchProfileFailure(this.errorMessage);
}
