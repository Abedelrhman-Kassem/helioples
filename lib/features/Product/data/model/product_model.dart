class ProductModel {
  Product? product;
  String? msg;

  ProductModel.fromJson(Map<String, dynamic> json) {
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
  }
}

class Product {
  int? id;
  String? name;
  String? thumbnailImage;
  String? description;
  String? searchDescription;
  int? availabelPieces;
  double? price;
  double? afterDiscount;
  UnitOfMeasure? unitOfMeasure;
  String? state;
  String? createdAt;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    thumbnailImage = json['thumbnailImage'];
    description = json['description'];
    searchDescription = json['searchDescription'];
    availabelPieces = json['availabelPieces'];
    price = json['price'];
    afterDiscount = json['afterDiscount'];
    unitOfMeasure = json['unitOfMeasure'] != null
        ? UnitOfMeasure.fromJson(json['unitOfMeasure'])
        : null;
    state = json['state'];
    createdAt = json['createdAt'];
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
