part of 'delivery_cubit.dart';

sealed class DeliveryState {}

final class CheckoutInitial extends DeliveryState {}

final class CreateOrderLoading extends DeliveryState {}

final class CreateOrderSuccess extends DeliveryState {
  OrderModel order;
  CreateOrderSuccess(this.order);
}

final class CreateOrderFailed extends DeliveryState {
  String error;
  CreateOrderFailed(this.error);
}
