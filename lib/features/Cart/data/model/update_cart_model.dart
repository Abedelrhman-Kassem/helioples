import 'package:negmt_heliopolis/features/Product/data/model/product_model.dart';

class UpdateCartModel {
  List<int>? notFoundIds;
  List<RelatedProductsModel>? products;

  UpdateCartModel({this.notFoundIds, this.products});

  UpdateCartModel.fromJson(Map<String, dynamic> json) {
    if (json['notFoundIds'] != null) {
      notFoundIds = <int>[];
      json['notFoundIds'].forEach((v) {
        notFoundIds!.add(v);
      });
    }

    if (json['products'] != null) {
      products = <RelatedProductsModel>[];
      json['products'].forEach((v) {
        products!.add(RelatedProductsModel.fromJson(v));
      });
    }
  }
}
