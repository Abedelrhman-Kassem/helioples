class BranchesModel {
  List<Branches>? branches;

  BranchesModel.fromJson(Map<String, dynamic> json) {
    if (json['branches'] != null) {
      branches = <Branches>[];
      json['branches'].forEach((v) {
        branches!.add(Branches.fromJson(v));
      });
    }
  }
}

class Branches {
  int? id;
  String? name;
  int? longtude;
  int? latitude;
  String? locationStr;

  Branches.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    longtude = json['longtude'];
    latitude = json['latitude'];
    locationStr = json['locationStr'];
  }
}
