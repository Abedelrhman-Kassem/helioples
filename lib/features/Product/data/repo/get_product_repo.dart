import 'package:dartz/dartz.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/features/Product/data/model/product_model.dart';

abstract class GetProduct {
  Future<Either<Failure, ProductDetailsModel>> getProductDetails(
      String productId, int page, int pageSize);
}
