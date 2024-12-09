import 'package:dartz/dartz.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/features/Checkout/data/model/branches_model.dart';
import 'package:negmt_heliopolis/features/Checkout/data/model/cancel_order_model.dart';
import 'package:negmt_heliopolis/features/Checkout/data/model/create_order_model.dart';
import 'package:negmt_heliopolis/features/Checkout/data/model/order_details_model.dart';
import 'package:negmt_heliopolis/features/Checkout/data/model/promocode_model.dart';

abstract class CreateOrder {
  Future<Either<Failure, OrderDetailsModel>> createOrder(
    CreateOrderModel data,
  );
  Future<Either<Failure, PromoCodeModel>> checkPromoCode(String code);

  Future<Either<Failure, CancelOrderModel>> cancelOrder(int id, String reason);

  Future<Either<Failure, BranchesModel>> getAllBranches();
}
