import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/features/homeScreen/data/model/all_categories_model.dart';
import 'package:dartz/dartz.dart';

abstract class GetCategories {
  Future<Either<Failure, AllCategoriesModel>> getAllCategories();
}
