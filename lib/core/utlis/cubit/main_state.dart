part of 'main_cubit.dart';

sealed class MainState extends Equatable {
  const MainState();

  @override
  List<Object> get props => [];
}

final class MainInitial extends MainState {}

final class LoadingAddresses extends MainState {}

final class GetAddressesSuccessfully extends MainState {
  final AddressModel addressModel;
  const GetAddressesSuccessfully(this.addressModel);
}

final class GetAddressesFailed extends MainState {
  final String error;
  const GetAddressesFailed(this.error);
}
