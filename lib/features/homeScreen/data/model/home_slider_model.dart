class HomeSliderModel {
  Configs? configs;

  HomeSliderModel.fromJson(Map<String, dynamic> json) {
    configs =
        json['configs'] != null ? Configs.fromJson(json['configs']) : null;
  }
}

class Configs {
  int? id;
  List<String>? homeScreenSlider;
  int? vat;

  Configs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    homeScreenSlider = json['homeScreenSlider'].cast<String>();
    vat = json['vat'];
  }
}
