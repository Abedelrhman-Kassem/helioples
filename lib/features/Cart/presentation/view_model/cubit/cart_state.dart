part of 'cart_cubit.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

final class CartInitial extends CartState {}

final class CartLoadingState extends CartState {}

final class CartSuccessState extends CartState {
  final UpdateCartModel updateCartModel;

  const CartSuccessState({required this.updateCartModel});
}

final class CartFailedState extends CartState {
  final String error;

  const CartFailedState({required this.error});
}

final class CartDeletingState extends CartState {}
