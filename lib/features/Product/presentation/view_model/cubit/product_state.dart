part of 'product_cubit.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class GetProductLoading extends ProductState {}

class GetProductSuccess extends ProductState {
  Product product;
  GetProductSuccess(this.product);
}

class GetProductFailure extends ProductState {
  String error;
  GetProductFailure(this.error);
}
