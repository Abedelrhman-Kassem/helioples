import 'package:flutter/material.dart';
import 'package:negmt_heliopolis/features/Product/data/model/product_model.dart';

class SubCategoriesNotifier with ChangeNotifier {
  SubCategoriesNotifier._privateConstructor();

  static final SubCategoriesNotifier _instance =
      SubCategoriesNotifier._privateConstructor();

  factory SubCategoriesNotifier() => _instance;

  int activeSection = 0;

  bool allowFetch = true;

  Map<int, bool> isFetching = {};
  Map<int, bool> endFetching = {};
  Map<int, List<RelatedProductsModel>> subCategoriesProducts = {};
  Map<int, List<int>> subCategoriesIds = {};

  void triggerNotification() {
    notifyListeners();
  }
}
