import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_service.dart';
import 'package:negmt_heliopolis/core/utlis/network/app_urls.dart';
import 'package:negmt_heliopolis/features/Checkout/data/model/branches_model.dart';
import 'package:negmt_heliopolis/features/Checkout/data/model/cancel_order_model.dart';
import 'package:negmt_heliopolis/features/Checkout/data/model/create_order_model.dart';
import 'package:negmt_heliopolis/features/Checkout/data/model/delivery_time_model.dart';
import 'package:negmt_heliopolis/features/Checkout/data/model/order_details_model.dart';
import 'package:negmt_heliopolis/features/Checkout/data/model/promocode_model.dart';
import 'package:negmt_heliopolis/features/Checkout/data/repo/create_repo.dart';

class CreateOrderImp extends CreateOrder {
  final ApiService apiService;

  CreateOrderImp({required this.apiService});

  @override
  Future<Either<Failure, OrderDetailsModel>> createOrder(
    CreateOrderModel data,
  ) async {
    OrderDetailsModel orderDetailsModel;
    log(
      data.isDelivery
          ? data.toDeliveryJson().toString()
          : data.toPickUpJson().toString(),
    );

    try {
      var response = await apiService.post(
        endPoints: AppUrls.createOrderUrl,
        data: data.isDelivery ? data.toDeliveryJson() : data.toPickUpJson(),
      );

      orderDetailsModel = OrderDetailsModel.fromJson(response.data);

      return right(orderDetailsModel);
    } catch (e) {
      if (e is DioException) {
        log(e.response?.data.toString() ?? '');
        return left(ServerFailure.fromDioError(e));
      }
      log("e $e");
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, PromoCodeModel>> checkPromoCode(
    String code,
    double originalAmount,
  ) async {
    PromoCodeModel promoCodeModel;

    try {
      var response = await apiService.post(
        endPoints: AppUrls.promoCodeUrl(),
        data: {'code': code, 'original_amount': originalAmount},
      );

      promoCodeModel = PromoCodeModel.fromJson(response.data);

      return right(promoCodeModel);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }

      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CancelOrderModel>> cancelOrder(
    String id,
    String reason,
  ) async {
    CancelOrderModel cancelOrderModel;

    try {
      var response = await apiService.post(
        endPoints: AppUrls.cancelOrderUrl(id),
        data: {"cancelReason": reason},
      );
      log(response.data.toString());
      cancelOrderModel = CancelOrderModel.fromJson(response.data);

      return right(cancelOrderModel);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }

      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, BranchesModel>> getAllBranches() async {
    BranchesModel branchesModel;

    try {
      var response = await apiService.get(endpoint: AppUrls.branchesUrl());
      branchesModel = BranchesModel.fromJson(response);

      return right(branchesModel);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }

      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, DeliveryTimeModel>> getDeliveryTime() async {
    DeliveryTimeModel deliveryTimeModel;

    try {
      var response = await apiService.get(endpoint: AppUrls.deliveryTimeUrl());

      deliveryTimeModel = DeliveryTimeModel.fromJson(response);

      return right(deliveryTimeModel);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }

      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, DeliveryTimeModel>> getPickupTime() async {
    DeliveryTimeModel deliveryTimeModel;

    try {
      var response = await apiService.get(endpoint: AppUrls.pickupTimeUrl());

      deliveryTimeModel = DeliveryTimeModel.fromJson(response);

      return right(deliveryTimeModel);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }

      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, double>> calculateDeliveryFee({
    String? addressId,
    double? lat,
    double? long,
  }) async {
    try {
      final Map<String, dynamic> data = {};
      if (addressId != null) {
        data['addressId'] = addressId;
      } else if (lat != null && long != null) {
        data['latitude'] = lat;
        data['longitude'] = long;
      }

      var response = await apiService.post(
        endPoints: AppUrls.calculateFeeUrl,
        data: data,
      );

      return right((response.data['data'] as num).toDouble());
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
