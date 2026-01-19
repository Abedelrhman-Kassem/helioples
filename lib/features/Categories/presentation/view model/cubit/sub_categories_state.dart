part of 'sub_categories_cubit.dart';

abstract class SubCategoriesState {}

class SubCategoriesStateInitial extends SubCategoriesState {}

class LoadingMainSubCategories extends SubCategoriesState {}

class GetMainSubCategoriesSuccess extends SubCategoriesState {
  final List<SubCatByCatidData> subCategories;
  final List<FeaturData> features;
  final CategoryModel? category;
  GetMainSubCategoriesSuccess(
    this.subCategories, {
    this.features = const [],
    this.category,
  });
}

class GetMainSubCategoriesFailed extends SubCategoriesState {
  final String message;
  GetMainSubCategoriesFailed(this.message);
}
