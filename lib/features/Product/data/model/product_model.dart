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
  String? name;
  String? description;
  String? enDescription;
  String? enName;
  String? thumbnailImage;
  String? searchDescription;
  double? price;
  double? afterDiscount;
  String? state;
  String? createdAt;
  double? discount;
  bool? isLiked;

  RelatedProductsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    enDescription = json['enDescription'];
    enName = json['enName'];
    thumbnailImage = json['thumbnailImage'];
    searchDescription = json['searchDescription'];
    price = json['price'] * 1.0;
    afterDiscount = json['afterDiscount'];
    state = json['state'];
    createdAt = json['createdAt'];
    discount = json['discount'];
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
  int quantity;

  ItemUiModel({
    required this.id,
    required this.name,
    required this.enName,
    required this.enDesc,
    required this.description,
    required this.thumbnailImage,
    required this.price,
    this.quantity = 0,
  });
}
