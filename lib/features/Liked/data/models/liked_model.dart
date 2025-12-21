import 'package:negmt_heliopolis/features/Product/data/model/product_model.dart';

class LikedModel {
  List<Products>? products;

  LikedModel.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
  }
}

class PostLikedModel {
  PostLikedModel({
    required this.success,
    required this.message,
    required this.data,
    required this.errors,
  });

  final bool? success;
  final String? message;
  bool? data;
  final dynamic errors;

  factory PostLikedModel.fromJson(Map<String, dynamic> json) {
    return PostLikedModel(
      success: json["success"],
      message: json["message"],
      data: json["data"],
      errors: json["errors"],
    );
  }
}
