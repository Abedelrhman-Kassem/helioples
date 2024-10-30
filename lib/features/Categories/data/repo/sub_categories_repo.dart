import 'package:dartz/dartz.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/features/Categories/data/model/sub_categories.dart';

abstract class SubCategoriesRepo
{
  Future<Either<Failure,List<SubCategories>>> getSubCategories(int page , int id);

}