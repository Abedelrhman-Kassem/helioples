import 'package:negmt_heliopolis/features/Product/data/model/product_model.dart';

class SearchModel {
  List<Products>? products;

  SearchModel.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
  }
}
