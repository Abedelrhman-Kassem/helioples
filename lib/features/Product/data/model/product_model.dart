class ProductDetailsModel {
  ProductDetailsModel({
    required this.success,
    required this.message,
    required this.data,
    required this.errors,
  });

  final bool? success;
  final String? message;
  final Products? data;
  final dynamic errors;

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailsModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? null : Products.fromJson(json["data"]),
      errors: json["errors"],
    );
  }
}

class RelatedProducts {
  RelatedProducts({
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

  factory RelatedProducts.fromJson(Map<String, dynamic> json) {
    return RelatedProducts(
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

class Products {
  Products({
    required this.id,
    this.name,
    this.enName,
    this.description,
    this.enDescription,
    this.thumbnailImage,
    this.unitOfMeasure,
    this.price,
    this.afterDiscount,
    this.availableQuantity,
    this.state,
    this.discount,
    this.isLiked,
    this.isSubscribed,
    required this.quantity,
    this.relatedProducts,
  });

  final String? id;
  final String? name;
  final String? enName;
  final String? description;
  final String? enDescription;
  final String? thumbnailImage;
  final String? unitOfMeasure;
  final double? price;
  final double? afterDiscount;
  final int? availableQuantity;
  String? state;
  final double? discount;
  bool? isLiked;
  bool? isSubscribed;
  double quantity;
  final RelatedProducts? relatedProducts;

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
      id: json["id"],
      name: json["name"],
      enName: json["enName"],
      description: json["description"],
      enDescription: json["enDescription"],
      thumbnailImage: json["thumbnailImage"],
      unitOfMeasure: json["unitOfMeasure"],
      price: json["price"]?.toDouble(),
      afterDiscount: json["afterDiscount"]?.toDouble(),
      availableQuantity: json["availableQuantity"],
      state: json["state"].toString(),
      discount: json["discount"]?.toDouble(),
      isLiked: json["isLiked"],
      isSubscribed: json["isSubscribed"],
      quantity: (json["quantity"] as num?)?.toDouble() ?? 0.0,
      relatedProducts: json["relatedProducts"] == null
          ? null
          : RelatedProducts.fromJson(json["relatedProducts"]),
    );
  }
}
