import 'package:dartz/dartz.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/features/Checkout/data/model/promocode_model.dart';

abstract class PromocodeRepo {
  Future<Either<Failure, PromoCodeModel>> checkPromoCode(String code);
}
