part of 'create_order_cubit.dart';

sealed class CreateOrderState {}

final class CheckoutInitial extends CreateOrderState {}

final class CreateOrderLoading extends CreateOrderState {}

final class CreateOrderSuccess extends CreateOrderState {
  OrderModel order;
  CreateOrderSuccess(this.order);
}

final class CreateOrderFailed extends CreateOrderState {
  String error;
  CreateOrderFailed(this.error);
}

final class CheckPromoCodeLoading extends CreateOrderState {}

final class CheckPromoCodeSuccess extends CreateOrderState {
  PromoCodeModel promoCodeModel;
  CheckPromoCodeSuccess(this.promoCodeModel);
}

final class CheckPromoCodeFailed extends CreateOrderState {
  String error;
  CheckPromoCodeFailed(this.error);
}

final class TipsToBottomSheet extends CreateOrderState {
  double tips;
  TipsToBottomSheet(this.tips);
}
