import 'package:negmt_heliopolis/features/Product/data/model/product_model.dart';

class SpecialOfferItemModel {
  SpecialOfferItemModel({
    required this.success,
    required this.message,
    required this.offer,
    required this.statusCode,
    required this.errors,
  });

  final bool? success;
  final String? message;
  final Offer? offer;
  final int? statusCode;
  final dynamic errors;

  factory SpecialOfferItemModel.fromJson(Map<String, dynamic> json) {
    return SpecialOfferItemModel(
      success: json["success"],
      message: json["message"],
      offer: json["data"] == null ? null : Offer.fromJson(json["data"]),
      statusCode: json["statusCode"],
      errors: json["errors"],
    );
  }
}

class Offer {
  Offer({
    required this.id,
    required this.name,
    required this.thumbnailImage,
    required this.companyImage,
    required this.visits,
    required this.homeScreen,
    required this.active,
    required this.badge,
    required this.expiresAt,
    required this.pagedProducts,
  });

  final String? id;
  final String? name;
  final String? thumbnailImage;
  final String? companyImage;
  final int? visits;
  final bool? homeScreen;
  final bool? active;
  final String? badge;
  final DateTime? expiresAt;
  final RelatedProducts? pagedProducts;

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      id: json["id"],
      name: json["name"],
      thumbnailImage: json["thumbnailImage"],
      companyImage: json["companyImage"],
      visits: json["visits"],
      homeScreen: json["homeScreen"],
      active: json["active"],
      badge: json["badge"],
      expiresAt: DateTime.tryParse(json["expiresAt"] ?? ""),
      pagedProducts: json["pagedProducts"] == null
          ? null
          : RelatedProducts.fromJson(json["pagedProducts"]),
    );
  }
}

// class PagedProducts {
//     PagedProducts({
//         required this.page,
//         required this.pageSize,
//         required this.totalCount,
//         required this.totalPages,
//         required this.items,
//     });

//     final int? page;
//     final int? pageSize;
//     final int? totalCount;
//     final int? totalPages;
//     final List<Item> items;

//     factory PagedProducts.fromJson(Map<String, dynamic> json){ 
//         return PagedProducts(
//             page: json["page"],
//             pageSize: json["pageSize"],
//             totalCount: json["totalCount"],
//             totalPages: json["totalPages"],
//             items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
//         );
//     }

// }

// class Item {
//     Item({
//         required this.id,
//         required this.name,
//         required this.enName,
//         required this.description,
//         required this.enDescription,
//         required this.thumbnailImage,
//         required this.unitOfMeasure,
//         required this.price,
//         required this.afterDiscount,
//         required this.availableQuantity,
//         required this.state,
//         required this.discount,
//         required this.isLiked,
//         required this.relatedProducts,
//     });

//     final String? id;
//     final String? name;
//     final String? enName;
//     final String? description;
//     final dynamic enDescription;
//     final dynamic thumbnailImage;
//     final String? unitOfMeasure;
//     final int? price;
//     final int? afterDiscount;
//     final int? availableQuantity;
//     final String? state;
//     final int? discount;
//     final bool? isLiked;
//     final dynamic relatedProducts;

//     factory Item.fromJson(Map<String, dynamic> json){ 
//         return Item(
//             id: json["id"],
//             name: json["name"],
//             enName: json["enName"],
//             description: json["description"],
//             enDescription: json["enDescription"],
//             thumbnailImage: json["thumbnailImage"],
//             unitOfMeasure: json["unitOfMeasure"],
//             price: json["price"],
//             afterDiscount: json["afterDiscount"],
//             availableQuantity: json["availableQuantity"],
//             state: json["state"],
//             discount: json["discount"],
//             isLiked: json["isLiked"],
//             relatedProducts: json["relatedProducts"],
//         );
//     }

// }
