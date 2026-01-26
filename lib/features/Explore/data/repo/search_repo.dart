import 'package:dartz/dartz.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/features/Product/data/model/product_model.dart';

abstract class SearchRepo {
  Future<Either<Failure, List<Products>>> search({
    required String query,
    required int page,
    required int pageSize,
  });
}
