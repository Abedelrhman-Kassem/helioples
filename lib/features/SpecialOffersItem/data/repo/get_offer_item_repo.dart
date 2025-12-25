import 'package:dartz/dartz.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/features/SpecialOffersItem/data/model/offer_item_model.dart';

abstract class GetOfferItemRepo {
  Future<Either<Failure, SpecialOfferItemModel>> getSpecialOfferItem({
    required String id,
    required int page,
    required int pageSize,
  });
}
