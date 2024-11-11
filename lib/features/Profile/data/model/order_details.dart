class OrderDetails {
  int? id;
  int? userId;
  Null? arriveTime;
  int? tips;
  String? alternativeProduct;
  double? subTotal;
  int? vat;
  int? deliveryFees;
  int? promoCodeDiscount;
  double? total;
  String? paymentMethod;
  bool? paid;
  bool? chooseForMe;
  Null? promoCodeId;
  Null? reason;
  String? clientOrderState;
  String? adminOrderState;
  int? addressId;
  String? deliverMethod;
  String? updatedAt;
  String? createdAt;
  Null? branchId;
  Null? promoCode;
  Address? address;
  List<Items>? items;

  OrderDetails(
      {this.id,
      this.userId,
      this.arriveTime,
      this.tips,
      this.alternativeProduct,
      this.subTotal,
      this.vat,
      this.deliveryFees,
      this.promoCodeDiscount,
      this.total,
      this.paymentMethod,
      this.paid,
      this.chooseForMe,
      this.promoCodeId,
      this.reason,
      this.clientOrderState,
      this.adminOrderState,
      this.addressId,
      this.deliverMethod,
      this.updatedAt,
      this.createdAt,
      this.branchId,
      this.promoCode,
      this.address,
      this.items});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    arriveTime = json['arriveTime'];
    tips = json['tips'];
    alternativeProduct = json['alternativeProduct'];
    subTotal = json['subTotal'];
    vat = json['vat'];
    deliveryFees = json['deliveryFees'];
    promoCodeDiscount = json['promoCodeDiscount'];
    total = json['total'];
    paymentMethod = json['paymentMethod'];
    paid = json['paid'];
    chooseForMe = json['chooseForMe'];
    promoCodeId = json['promoCodeId'];
    reason = json['reason'];
    clientOrderState = json['clientOrderState'];
    adminOrderState = json['adminOrderState'];
    addressId = json['addressId'];
    deliverMethod = json['deliverMethod'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
    branchId = json['branchId'];
    promoCode = json['promoCode'];
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['arriveTime'] = this.arriveTime;
    data['tips'] = this.tips;
    data['alternativeProduct'] = this.alternativeProduct;
    data['subTotal'] = this.subTotal;
    data['vat'] = this.vat;
    data['deliveryFees'] = this.deliveryFees;
    data['promoCodeDiscount'] = this.promoCodeDiscount;
    data['total'] = this.total;
    data['paymentMethod'] = this.paymentMethod;
    data['paid'] = this.paid;
    data['chooseForMe'] = this.chooseForMe;
    data['promoCodeId'] = this.promoCodeId;
    data['reason'] = this.reason;
    data['clientOrderState'] = this.clientOrderState;
    data['adminOrderState'] = this.adminOrderState;
    data['addressId'] = this.addressId;
    data['deliverMethod'] = this.deliverMethod;
    data['updatedAt'] = this.updatedAt;
    data['createdAt'] = this.createdAt;
    data['branchId'] = this.branchId;
    data['promoCode'] = this.promoCode;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Address {
  int? id;
  String? locationStr;
  double? latitude;
  double? longitude;
  String? createdAt;
  String? updatedAt;
  int? userId;

  Address(
      {this.id,
      this.locationStr,
      this.latitude,
      this.longitude,
      this.createdAt,
      this.updatedAt,
      this.userId});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    locationStr = json['locationStr'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['locationStr'] = this.locationStr;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['userId'] = this.userId;
    return data;
  }
}

class Items {
  int? id;
  double? priceWhenOrdered;
  int? number;
  int? orderId;
  int? productId;
  Product? product;

  Items(
      {this.id,
      this.priceWhenOrdered,
      this.number,
      this.orderId,
      this.productId,
      this.product});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    priceWhenOrdered = json['priceWhenOrdered'];
    number = json['number'];
    orderId = json['orderId'];
    productId = json['productId'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['priceWhenOrdered'] = this.priceWhenOrdered;
    data['number'] = this.number;
    data['orderId'] = this.orderId;
    data['productId'] = this.productId;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }
}

class Product {
  int? id;
  String? barCodeId;
  String? name;
  String? enName;
  Null? thumbnailImage;
  String? enDescription;
  String? description;
  String? searchDescription;
  int? availabelPieces;
  int? totalOrders;
  double? price;
  String? state;
  int? views;
  bool? active;
  Null? discountId;
  String? createdAt;
  String? updatedAt;
  int? unitOfMeasureId;

  Product(
      {this.id,
      this.barCodeId,
      this.name,
      this.enName,
      this.thumbnailImage,
      this.enDescription,
      this.description,
      this.searchDescription,
      this.availabelPieces,
      this.totalOrders,
      this.price,
      this.state,
      this.views,
      this.active,
      this.discountId,
      this.createdAt,
      this.updatedAt,
      this.unitOfMeasureId});

  Product.fromJson(Map<String, dynamic> json) {
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
    price = json['price'];
    state = json['state'];
    views = json['views'];
    active = json['active'];
    discountId = json['discountId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    unitOfMeasureId = json['unitOfMeasureId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['barCodeId'] = this.barCodeId;
    data['name'] = this.name;
    data['enName'] = this.enName;
    data['thumbnailImage'] = this.thumbnailImage;
    data['enDescription'] = this.enDescription;
    data['description'] = this.description;
    data['searchDescription'] = this.searchDescription;
    data['availabelPieces'] = this.availabelPieces;
    data['totalOrders'] = this.totalOrders;
    data['price'] = this.price;
    data['state'] = this.state;
    data['views'] = this.views;
    data['active'] = this.active;
    data['discountId'] = this.discountId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['unitOfMeasureId'] = this.unitOfMeasureId;
    return data;
  }
}