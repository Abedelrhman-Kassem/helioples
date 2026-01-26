import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/utlis/cubit/main_cubit.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_service.dart';
import 'package:negmt_heliopolis/core/utlis/notifiers/db_change_notifier.dart';
import 'package:negmt_heliopolis/features/Checkout/data/model/branches_model.dart';
import 'package:negmt_heliopolis/features/Checkout/data/model/cancel_order_model.dart';
import 'package:negmt_heliopolis/features/Checkout/data/model/create_order_model.dart';
import 'package:negmt_heliopolis/features/Checkout/data/model/delivery_time_model.dart';
import 'package:negmt_heliopolis/features/Checkout/data/model/order_details_model.dart';
import 'package:negmt_heliopolis/features/Checkout/data/model/promocode_model.dart';
import 'package:negmt_heliopolis/features/Checkout/data/repo/create_repo_imp.dart';

part 'create_order_state.dart';

class CreateOrderCubit extends Cubit<CreateOrderState> {
  CreateOrderCubit() : super(CreateOrderInitial());

  CreateOrderImp createOrderImp = CreateOrderImp(apiService: ApiService());

  void createOrder(CreateOrderModel data) async {
    emit(CreateOrderLoading());

    Either<Failure, OrderDetailsModel> res = await createOrderImp.createOrder(
      data,
    );

    res.fold(
      (failure) {
        log(failure.errorMessage);
        emit(CreateOrderFailed(failure.errorMessage));
      },
      (orderDetailsModel) {
        emit(CreateOrderSuccess(orderDetailsModel));
      },
    );
  }

  double calcPromoCode(double totalPrice, double promoCodeValue) {
    return double.parse(
      (totalPrice * (promoCodeValue / 100)).toStringAsFixed(2),
    );
  }

  void checkPromoCode(String code, double originalAmount) async {
    emit(CheckPromoCodeLoading());

    Either<Failure, PromoCodeModel> res = await createOrderImp.checkPromoCode(
      code.trim(),
      originalAmount,
    );

    res.fold(
      (failure) => emit(CheckPromoCodeFailed(failure.errorMessage)),
      (promoCodeModel) => emit(CheckPromoCodeSuccess(promoCodeModel)),
    );
  }

  void tipsToBottomSheet(double tips) {
    emit(TipsToBottomSheet(tips));
  }

  void cancelOrder(String reason, String orderId) async {
    emit(CancelOrderLoading());

    Either<Failure, CancelOrderModel> res = await createOrderImp.cancelOrder(
      orderId,
      reason,
    );

    res.fold(
      (failure) => emit(CancelOrderFailed(failure.errorMessage)),
      (cancelOrderModel) => emit(CancelOrderSuccess(cancelOrderModel)),
    );
  }

  Branches? branch;
  void getBranches() async {
    emit(BranchesLoading());

    Either<Failure, BranchesModel> res = await createOrderImp.getAllBranches();

    res.fold(
      (failure) => emit(BranchesFailed(failure.errorMessage)),
      (branches) => emit(BranchesSuccess(branches)),
    );
  }

  DbChangeNotifierModel getDBChangeNotifierModel(BuildContext context) {
    var items = BlocProvider.of<MainCubit>(context).tableValues;

    double totalPrice = 0;
    double totalDiscount = 0;

    for (var item in items) {
      double qty = (item[cartItemQty] as num).toDouble();
      double price = (item[cartItemPrice] as num).toDouble();
      double discount = (item[cartItemDiscount] as num).toDouble();
      totalPrice += qty * price;
      totalDiscount += qty * discount;
    }

    totalPrice = double.parse(totalPrice.toStringAsFixed(2));
    return DbChangeNotifierModel(
      count: items.length,
      totalPrice: totalPrice,
      totalDiscount: totalDiscount,
    );
  }

  AvailableTime? availableTime;
  double deliveryFee = 0;

  Future<void> calculateFee({
    String? addressId,
    double? lat,
    double? long,
  }) async {
    emit(CalculateFeeLoading());

    Either<Failure, double> res = await createOrderImp.calculateDeliveryFee(
      addressId: addressId,
      lat: lat,
      long: long,
    );

    res.fold(
      (failure) {
        deliveryFee = 0;
        emit(CalculateFeeFailed(failure.errorMessage));
      },
      (fee) {
        deliveryFee = fee;
        emit(CalculateFeeSuccess(fee));
      },
    );
  }

  Future<void> getDeliveryTime() async {
    emit(LoadingDeliveryTime());

    Either<Failure, DeliveryTimeModel> res = await createOrderImp
        .getDeliveryTime();

    res.fold((failure) => emit(GetDeliveryTimeFailed(failure.errorMessage)), (
      deliveryTimeModel,
    ) {
      if (deliveryTimeModel.availableTime.isEmpty) {
        emit(GetDeliveryTimeFailed('No available time'));
        return;
      }
      availableTime = deliveryTimeModel.availableTime.first;
      log("---------------------------");
      log(deliveryTimeModel.availableTime.first.id.toString());
      emit(GetDeliveryTimeSuccess(deliveryTimeModel));
    });
  }

  Future<void> getPickupTime() async {
    emit(LoadingDeliveryTime());

    Either<Failure, DeliveryTimeModel> res = await createOrderImp
        .getPickupTime();

    res.fold((failure) => emit(GetDeliveryTimeFailed(failure.errorMessage)), (
      deliveryTimeModel,
    ) {
      if (deliveryTimeModel.availableTime.isEmpty) {
        emit(GetDeliveryTimeFailed('No available time'));
        return;
      }
      availableTime = deliveryTimeModel.availableTime.first;
      emit(GetDeliveryTimeSuccess(deliveryTimeModel));
    });
  }

  bool isPaymentGatewayAvailable = false;
  void checkPaymentGateway() async {
    emit(PaymentGatewayLoading());

    Either<Failure, bool> res = await createOrderImp.checkPaymentGateway();

    res.fold((failure) => emit(PaymentGatewayFailed(failure.errorMessage)), (
      isAvailable,
    ) {
      isPaymentGatewayAvailable = isAvailable;
      emit(PaymentGatewaySuccess(isAvailable));
    });
  }
}
