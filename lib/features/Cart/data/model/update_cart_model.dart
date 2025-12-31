import 'package:negmt_heliopolis/features/Product/data/model/product_model.dart';

class UpdateCartModel {
  UpdateCartModel({
    required this.success,
    required this.message,
    required this.products,
    required this.statusCode,
  });

  final bool? success;
  final String? message;
  final List<Products> products;
  final int? statusCode;

  factory UpdateCartModel.fromJson(Map<String, dynamic> json) {
    return UpdateCartModel(
      success: json["success"],
      message: json["message"],
      products: json["data"] == null
          ? []
          : List<Products>.from(json["data"]!.map((x) => Products.fromJson(x))),
      statusCode: json["statusCode"],
    );
  }
}
