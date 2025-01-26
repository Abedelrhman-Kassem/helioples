class ProductModel {
  Product? product;
  List<RelatedProductsModel>? related;

  ProductModel.fromJson(Map<String, dynamic> json) {
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
    if (json['related'] != null) {
      related = [];
      json['related'].forEach((v) {
        related!.add(RelatedProductsModel.fromJson(v));
      });
    }
  }
}

class Product {
  int? id;
  String? name;
  String? enDesc;
  String? enName;
  String? thumbnailImage;
  String? description;
  String? searchDescription;
  int? availabelPieces;
  double? price;
  double? afterDiscount;
  UnitOfMeasure? unitOfMeasure;
  String? state;
  String? createdAt;
  double? discount;
  bool? isLiked;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    enDesc = json['enDescription'];
    enName = json['enName'];
    thumbnailImage = json['thumbnailImage'];
    description = json['description'];
    searchDescription = json['searchDescription'];
    availabelPieces = json['availabelPieces'];
    price = json['price'] * 1.0;
    afterDiscount = json['afterDiscount'];
    unitOfMeasure = json['unitOfMeasure'] != null
        ? UnitOfMeasure.fromJson(json['unitOfMeasure'])
        : null;
    state = json['state'];
    createdAt = json['createdAt'];
    discount = json['discount'];
    isLiked = json['isLiked'];
  }
}

class UnitOfMeasure {
  int? id;
  String? name;

  UnitOfMeasure.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}

class RelatedProductsModel {
  int? id;
  String? barCodeId;
  String? name;
  String? enName;
  String? thumbnailImage;
  String? enDescription;
  String? description;
  String? searchDescription;
  int? availabelPieces;
  int? totalOrders;
  double? price;
  String? state;
  int? views;
  bool? active;
  int? discountId;
  String? createdAt;
  String? updatedAt;
  int? unitOfMeasureId;
  double? currentDiscount;
  double? afterDiscount;
  bool? isLiked;

  RelatedProductsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    barCodeId = json['barCodeId'];
    name = json['name'];
    enName = json['enName'];
    thumbnailImage = json['thumbnailImage'];
    enDescription = json['enDescription'];
    description = json['description'];
    searchDescription = json['searchDescription'];
    availabelPieces = json['availabelPieces'];
    totalOrders = json['totalOrders'];
    price = json['price'] * 1.0;
    state = json['state'];
    views = json['views'];
    active = json['active'];
    discountId = json['discountId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    unitOfMeasureId = json['unitOfMeasureId'];
    currentDiscount = (json['current_discount'] ?? 0) * 1.0;
    afterDiscount = (json['afterDiscount'] ?? price) * 1.0;
    isLiked = json['isLiked'];
  }
}

class ItemUiModel {
  int id;
  String name;
  String enName;
  String enDesc;
  String description;
  String thumbnailImage;
  double price;
  double discount;
  int availablePieces;
  int quantity;

  ItemUiModel({
    required this.id,
    required this.name,
    required this.enName,
    required this.enDesc,
    required this.description,
    required this.thumbnailImage,
    required this.price,
    required this.discount,
    required this.availablePieces,
    this.quantity = 0,
  });
}
