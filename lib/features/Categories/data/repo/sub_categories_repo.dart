import 'package:dartz/dartz.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/features/Categories/data/model/sub_categories.dart';
import 'package:negmt_heliopolis/features/Product/data/model/product_model.dart';

abstract class SubCategoriesRepo {
  Future<Either<Failure, List<SubCategories>>> getSubCategories(int id);

  Future<Either<Failure, List<RelatedProductsModel>>> getProductsInSubCategory(
    int subCategoryId,
    int page,
  );

  Future<Either<Failure, List<RelatedProductsModel>>>
      getAllProductsOfSubCategory(
    int subCategoryId,
  );
}
