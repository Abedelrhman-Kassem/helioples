import 'package:negmt_heliopolis/features/Product/data/model/product_model.dart';

class SpecialOfferItemModel {
  OfferItem? offer;

  SpecialOfferItemModel({this.offer});

  SpecialOfferItemModel.fromJson(Map<String, dynamic> json) {
    offer = json['offer'] != null ? OfferItem.fromJson(json['offer']) : null;
  }
}

class OfferItem {
  int? id;
  String? name;
  String? thumbnailImage;
  String? companyImage;
  int? visits;
  bool? homeScreen;
  String? badge;
  String? expiresAt;
  String? createdAt;
  List<RelatedProductsModel>? products;

  OfferItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    thumbnailImage = json['thumbnailImage'];
    companyImage = json['companyImage'];
    visits = json['visits'];
    homeScreen = json['homeScreen'];
    badge = json['badge'];
    expiresAt = json['expiresAt'];
    createdAt = json['createdAt'];
    if (json['products'] != null) {
      products = <RelatedProductsModel>[];
      json['products'].forEach((v) {
        products!.add(RelatedProductsModel.fromJson(v));
      });
    }
  }
}
