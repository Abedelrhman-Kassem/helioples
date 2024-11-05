class SubCategories {
  int? id;
  bool? isFeatured;
  String? name;
  String? description;
  Null? bannerImage;
  int? categoryId;
  int? currentProducts;
  bool? active;
  String? createdAt;
  String? updatedAt;
  List<Products>? products;

  SubCategories(
      {this.id,
      this.isFeatured,
      this.name,
      this.description,
      this.bannerImage,
      this.categoryId,
      this.currentProducts,
      this.active,
      this.createdAt,
      this.updatedAt,
      this.products});

  SubCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isFeatured = json['isFeatured'];
    name = json['name'];
    description = json['description'];
    bannerImage = json['bannerImage'];
    categoryId = json['categoryId'];
    currentProducts = json['currentProducts'];
    active = json['active'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['isFeatured'] = this.isFeatured;
    data['name'] = this.name;
    data['description'] = this.description;
    data['bannerImage'] = this.bannerImage;
    data['categoryId'] = this.categoryId;
    data['currentProducts'] = this.currentProducts;
    data['active'] = this.active;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  int? id;
  String? name;
  String? enDescription;
  String? enName;
  Null? thumbnailImage;
  String? searchDescription;
  double? price;
  Null? afterDiscount;
  String? state;
  String? createdAt;
  Null? discount;

  Products(
      {this.id,
      this.name,
      this.enDescription,
      this.enName,
      this.thumbnailImage,
      this.searchDescription,
      this.price,
      this.afterDiscount,
      this.state,
      this.createdAt,
      this.discount});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    enDescription = json['enDescription'];
    enName = json['enName'];
    thumbnailImage = json['thumbnailImage'];
    searchDescription = json['searchDescription'];
    price = json['price'] != null ? (json['price'] as num).toDouble() : null;
    afterDiscount = json['afterDiscount'];
    state = json['state'];
    createdAt = json['createdAt'];
    discount = json['discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['enDescription'] = this.enDescription;
    data['enName'] = this.enName;
    data['thumbnailImage'] = this.thumbnailImage;
    data['searchDescription'] = this.searchDescription;
    data['price'] = this.price;
    data['afterDiscount'] = this.afterDiscount;
    data['state'] = this.state;
    data['createdAt'] = this.createdAt;
    data['discount'] = this.discount;
    return data;
  }
}
