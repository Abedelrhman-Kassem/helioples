import 'package:dartz/dartz.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/features/Cart/data/model/update_cart_model.dart';

abstract class GetPricesRepo {
  Future<Either<Failure, UpdateCartModel>> getCartProducts(List<int> ids);
}
