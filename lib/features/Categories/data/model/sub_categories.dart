// import 'package:negmt_heliopolis/features/Product/data/model/product_model.dart';
import 'package:negmt_heliopolis/features/Product/data/model/product_model.dart';

class SubCatByCatidModel {
  SubCatByCatidModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final List<SubCatByCatidData> data;

  factory SubCatByCatidModel.fromJson(Map<String, dynamic> json) {
    return SubCatByCatidModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null
          ? []
          : List<SubCatByCatidData>.from(
              json["data"]!.map((x) => SubCatByCatidData.fromJson(x))),
    );
  }
}

class SubCatByCatidData {
  SubCatByCatidData({
    required this.id,
    required this.name,
    required this.description,
    required this.enName,
    required this.enDescription,
    required this.iconImage,
    required this.systemName,
    required this.systemDescription,
    required this.code,
    required this.categoryId,
    required this.categoryName,
    required this.active,
    required this.products,
  });

  final String? id;
  final String? name;
  final String? description;
  final String? enName;
  final String? enDescription;
  final String? iconImage;
  final String? systemName;
  final String? systemDescription;
  final String? code;
  final String? categoryId;
  final String? categoryName;
  final bool? active;
  final List<Products> products;

  factory SubCatByCatidData.fromJson(Map<String, dynamic> json) {
    return SubCatByCatidData(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      enName: json["enName"],
      enDescription: json["enDescription"],
      iconImage: json["iconImage"],
      systemName: json["systemName"],
      systemDescription: json["systemDescription"],
      code: json["code"],
      categoryId: json["categoryId"],
      categoryName: json["categoryName"],
      active: json["active"],
      products: json["products"] == null
          ? []
          : List<Products>.from(
              json["products"]!.map((x) => Products.fromJson(x))),
    );
  }
}

class SubCatByCatidProduct {
  SubCatByCatidProduct({
    required this.id,
    required this.name,
    required this.enName,
    required this.thumbnailImage,
    required this.description,
    required this.enDescription,
    required this.price,
    required this.afterDiscount,
    required this.availableQuantity,
    required this.state,
    required this.discount,
    required this.isLiked,
  });

  final String? id;
  final String? name;
  final String? enName;
  final dynamic thumbnailImage;
  final String? description;
  final String? enDescription;
  final double? price;
  final double? afterDiscount;
  final int? availableQuantity;
  final String? state;
  final double? discount;
  final bool? isLiked;

  factory SubCatByCatidProduct.fromJson(Map<String, dynamic> json) {
    return SubCatByCatidProduct(
      id: json["id"],
      name: json["name"],
      enName: json["enName"],
      thumbnailImage: json["thumbnailImage"],
      description: json["description"],
      enDescription: json["enDescription"],
      price: json["price"]?.toDouble(),
      afterDiscount: json["afterDiscount"]?.toDouble(),
      availableQuantity: json["availableQuantity"],
      state: json["state"].toString(),
      isLiked: json["isLiked"],
      discount: json["discount"]?.toDouble(),
    );
  }
}

// class SubCategories {
//   String? id;
//   bool? isFeatured;
//   String? name;
//   String? description;
//   Null bannerImage;
//   int? categoryId;
//   int? currentProducts;
//   bool? active;
//   String? createdAt;
//   String? updatedAt;
//   List<RelatedProductsModel>? products;

//   SubCategories(
//       {this.id,
//       this.isFeatured,
//       this.name,
//       this.description,
//       this.bannerImage,
//       this.categoryId,
//       this.currentProducts,
//       this.active,
//       this.createdAt,
//       this.updatedAt,
//       this.products});

//   SubCategories.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     isFeatured = json['isFeatured'];
//     name = json['name'];
//     description = json['description'];
//     bannerImage = json['bannerImage'];
//     categoryId = json['categoryId'];
//     currentProducts = json['currentProducts'];
//     active = json['active'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     if (json['products'] != null) {
//       products = <RelatedProductsModel>[];
//       json['products'].forEach((v) {
//         products!.add(RelatedProductsModel.fromJson(v));
//       });
//     }
//   }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['isFeatured'] = this.isFeatured;
  //   data['name'] = this.name;
  //   data['description'] = this.description;
  //   data['bannerImage'] = this.bannerImage;
  //   data['categoryId'] = this.categoryId;
  //   data['currentProducts'] = this.currentProducts;
  //   data['active'] = this.active;
  //   data['createdAt'] = this.createdAt;
  //   data['updatedAt'] = this.updatedAt;
  //   if (this.products != null) {
  //     data['products'] = this.products!.map((v) => v.toJson()).toList();
  //   }
  //   return data;
  // }
// }

// class Products {
//   int? id;
//   String? name;
//   String? enDescription;
//   String? enName;
//   Null thumbnailImage;
//   String? searchDescription;
//   double? price;
//   Null afterDiscount;
//   String? state;
//   String? createdAt;
//   Null discount;

//   Products(
//       {this.id,
//       this.name,
//       this.enDescription,
//       this.enName,
//       this.thumbnailImage,
//       this.searchDescription,
//       this.price,
//       this.afterDiscount,
//       this.state,
//       this.createdAt,
//       this.discount});

//   Products.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     enDescription = json['enDescription'];
//     enName = json['enName'];
//     thumbnailImage = json['thumbnailImage'];
//     searchDescription = json['searchDescription'];
//     price = json['price'] != null ? (json['price'] as num).toDouble() : null;
//     afterDiscount = json['afterDiscount'];
//     state = json['state'];
//     createdAt = json['createdAt'];
//     discount = json['discount'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['name'] = name;
//     data['enDescription'] = enDescription;
//     data['enName'] = enName;
//     data['thumbnailImage'] = thumbnailImage;
//     data['searchDescription'] = searchDescription;
//     data['price'] = price;
//     data['afterDiscount'] = afterDiscount;
//     data['state'] = state;
//     data['createdAt'] = createdAt;
//     data['discount'] = discount;
//     return data;
//   }
// }
