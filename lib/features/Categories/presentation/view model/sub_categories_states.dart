import 'package:equatable/equatable.dart';
import 'package:negmt_heliopolis/features/Categories/data/model/sub_categories.dart';

abstract class FetchCategoriesState extends Equatable {
  const FetchCategoriesState();
  
  @override
  List<Object> get props => [];
}

// Subcategories states
class SubCategoriesInitial extends FetchCategoriesState {}

class SubCategoriesLoading extends FetchCategoriesState {}

class SubCategoriesSuccess extends FetchCategoriesState {
  final List<SubCategories> subCategories;
  const SubCategoriesSuccess(this.subCategories);

  @override
  List<Object> get props => [subCategories];
}

class SubCategoriesFailure extends FetchCategoriesState {
  final String message;
  const SubCategoriesFailure(this.message);

  @override
  List<Object> get props => [message];
}

// Products states (for a specific subcategory)
class ProductsLoading extends FetchCategoriesState {}

class ProductsSuccess extends FetchCategoriesState {
  final List<Products> products;
  const ProductsSuccess(this.products);

  @override
  List<Object> get props => [products];
}

class ProductsFailure extends FetchCategoriesState {
  final String message;
  const ProductsFailure(this.message);

  @override
  List<Object> get props => [message];
}

class ProductsPaginationLoading extends FetchCategoriesState {
  final List<Products> products;
  const ProductsPaginationLoading(this.products);

  @override
  List<Object> get props => [products];
}
