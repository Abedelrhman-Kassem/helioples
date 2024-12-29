class SpecialOfferModel {
  List<Offer>? offers;

  SpecialOfferModel.fromJson(Map<String, dynamic> json) {
    if (json['offers'] != null) {
      offers = <Offer>[];
      json['offers'].forEach((v) {
        offers!.add(Offer.fromJson(v));
      });
    }
  }
}

class Offer {
  int? id;
  String? name;
  String? thumbnailImage;
  String? companyImage;
  int? visits;
  bool? homeScreen;
  String? badge;
  String? expiresAt;
  String? createdAt;

  Offer({
    required this.id,
    required this.name,
    required this.thumbnailImage,
    required this.companyImage,
    required this.visits,
    required this.homeScreen,
    required this.badge,
    required this.expiresAt,
    required this.createdAt,
  });

  Offer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    thumbnailImage = json['thumbnailImage'];
    companyImage = json['companyImage'];
    visits = json['visits'];
    homeScreen = json['homeScreen'];
    badge = json['badge'];
    expiresAt = json['expiresAt'];
    createdAt = json['createdAt'];
  }
}
