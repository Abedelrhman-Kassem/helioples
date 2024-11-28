class OrderDetails {
  int? id;
  int? userId;
  Null arriveTime;
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
  Null promoCodeId;
  Null reason;
  String? clientOrderState;
  String? adminOrderState;
  int? addressId;
  String? deliverMethod;
  String? updatedAt;
  String? createdAt;
  Null branchId;
  Null promoCode;
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
        json['address'] != null ? Address.fromJson(json['address']) : null;
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['arriveTime'] = arriveTime;
    data['tips'] = tips;
    data['alternativeProduct'] = alternativeProduct;
    data['subTotal'] = subTotal;
    data['vat'] = vat;
    data['deliveryFees'] = deliveryFees;
    data['promoCodeDiscount'] = promoCodeDiscount;
    data['total'] = total;
    data['paymentMethod'] = paymentMethod;
    data['paid'] = paid;
    data['chooseForMe'] = chooseForMe;
    data['promoCodeId'] = promoCodeId;
    data['reason'] = reason;
    data['clientOrderState'] = clientOrderState;
    data['adminOrderState'] = adminOrderState;
    data['addressId'] = addressId;
    data['deliverMethod'] = deliverMethod;
    data['updatedAt'] = updatedAt;
    data['createdAt'] = createdAt;
    data['branchId'] = branchId;
    data['promoCode'] = promoCode;
    if (address != null) {
      data['address'] = address!.toJson();
    }
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['locationStr'] = locationStr;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['userId'] = userId;
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
        json['product'] != null ? Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['priceWhenOrdered'] = priceWhenOrdered;
    data['number'] = number;
    data['orderId'] = orderId;
    data['productId'] = productId;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    return data;
  }
}

class Product {
  int? id;
  String? barCodeId;
  String? name;
  String? enName;
  Null thumbnailImage;
  String? enDescription;
  String? description;
  String? searchDescription;
  int? availabelPieces;
  int? totalOrders;
  double? price;
  String? state;
  int? views;
  bool? active;
  Null discountId;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['barCodeId'] = barCodeId;
    data['name'] = name;
    data['enName'] = enName;
    data['thumbnailImage'] = thumbnailImage;
    data['enDescription'] = enDescription;
    data['description'] = description;
    data['searchDescription'] = searchDescription;
    data['availabelPieces'] = availabelPieces;
    data['totalOrders'] = totalOrders;
    data['price'] = price;
    data['state'] = state;
    data['views'] = views;
    data['active'] = active;
    data['discountId'] = discountId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['unitOfMeasureId'] = unitOfMeasureId;
    return data;
  }
}