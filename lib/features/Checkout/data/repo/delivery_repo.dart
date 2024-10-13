import 'package:dartz/dartz.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/features/Checkout/data/model/order_details_model.dart';

abstract class CreateOrder {
  Future<Either<Failure, OrderDetailsModel>> createOrder(
    Map<String, dynamic> data,
  );
}
