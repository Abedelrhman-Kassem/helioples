import 'package:negmt_heliopolis/features/Product/data/model/product_model.dart';

// class SearchModel {
//   List<Products>? products;

//   SearchModel.fromJson(Map<String, dynamic> json) {
//     if (json['products'] != null) {
//       products = <Products>[];
//       json['products'].forEach((v) {
//         products!.add(Products.fromJson(v));
//       });
//     }
//   }
// }

class SearchModel {
  SearchModel({
    required this.success,
    required this.message,
    required this.data,
    required this.statusCode,
    required this.errors,
  });

  final bool? success;
  final dynamic message;
  final SearchData? data;
  final int? statusCode;
  final dynamic errors;

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? null : SearchData.fromJson(json["data"]),
      statusCode: json["statusCode"],
      errors: json["errors"],
    );
  }
}

class SearchData {
  SearchData({
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

  factory SearchData.fromJson(Map<String, dynamic> json) {
    return SearchData(
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
