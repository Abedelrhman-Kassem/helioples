import 'package:negmt_heliopolis/features/Product/data/model/product_model.dart';

class LikedModel {
  LikedModel({
    required this.success,
    required this.message,
    required this.data,
    required this.statusCode,
    required this.errors,
  });

  final bool? success;
  final String? message;
  final Data? data;
  final int? statusCode;
  final dynamic errors;

  factory LikedModel.fromJson(Map<String, dynamic> json) {
    return LikedModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
      statusCode: json["statusCode"],
      errors: json["errors"],
    );
  }
}

class Data {
  Data({
    required this.page,
    required this.pageSize,
    required this.totalCount,
    required this.totalPages,
    required this.items,
  });

  final int? page;
  final int? pageSize;
  final int? totalCount;
  final int? totalPages;
  final List<Products> items;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      page: json["page"],
      pageSize: json["pageSize"],
      totalCount: json["totalCount"],
      totalPages: json["totalPages"],
      items: json["items"] == null
          ? []
          : List<Products>.from(
              json["items"]!.map((x) => Products.fromJson(x)),
            ),
    );
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
