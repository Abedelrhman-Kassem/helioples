part of 'product_cubit.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class GetProductLoading extends ProductState {}

class GetProductSuccess extends ProductState {
  ProductDetailsModel productModel;
  GetProductSuccess(this.productModel);
}

class GetProductFailure extends ProductState {
  String error;
  GetProductFailure(this.error);
}
