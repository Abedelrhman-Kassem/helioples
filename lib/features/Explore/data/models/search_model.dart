import 'package:negmt_heliopolis/features/Product/data/model/product_model.dart';

class SearchModel {
  List<RelatedProductsModel>? products;

  SearchModel.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <RelatedProductsModel>[];
      json['products'].forEach((v) {
        products!.add(RelatedProductsModel.fromJson(v));
      });
    }
  }
}
