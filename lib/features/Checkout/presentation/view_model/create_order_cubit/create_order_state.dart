part of 'create_order_cubit.dart';

sealed class CreateOrderState {}

final class CreateOrderInitial extends CreateOrderState {}

final class CreateOrderLoading extends CreateOrderState {}

final class CreateOrderSuccess extends CreateOrderState {
  OrderDetailsModel orderDetailsModel;
  CreateOrderSuccess(this.orderDetailsModel);
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

final class CancelOrderLoading extends CreateOrderState {}

final class CancelOrderSuccess extends CreateOrderState {
  CancelOrderModel cancelOrderModel;
  CancelOrderSuccess(this.cancelOrderModel);
}

final class CancelOrderFailed extends CreateOrderState {
  String error;
  CancelOrderFailed(this.error);
}

final class BranchesLoading extends CreateOrderState {}

final class BranchesSuccess extends CreateOrderState {
  BranchesModel branchesModel;
  BranchesSuccess(this.branchesModel);
}

final class BranchesFailed extends CreateOrderState {
  String error;
  BranchesFailed(this.error);
}

final class LoadingDeliveryTime extends CreateOrderState {}

final class GetDeliveryTimeSuccess extends CreateOrderState {
  DeliveryTimeModel deliveryTimeModel;
  GetDeliveryTimeSuccess(this.deliveryTimeModel);
}

final class GetDeliveryTimeFailed extends CreateOrderState {
  String error;
  GetDeliveryTimeFailed(this.error);
}

final class CalculateFeeLoading extends CreateOrderState {}

final class CalculateFeeSuccess extends CreateOrderState {
  double fee;
  CalculateFeeSuccess(this.fee);
}

final class CalculateFeeFailed extends CreateOrderState {
  String error;
  CalculateFeeFailed(this.error);
}
