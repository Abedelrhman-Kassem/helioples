import 'package:flutter/material.dart';
import 'package:negmt_heliopolis/features/Categories/data/model/sub_categories.dart';
import 'package:negmt_heliopolis/features/Product/data/model/product_model.dart';

class SubCategoriesNotifier with ChangeNotifier {
  SubCategoriesNotifier._privateConstructor();

  static final SubCategoriesNotifier _instance =
      SubCategoriesNotifier._privateConstructor();

  factory SubCategoriesNotifier() => _instance;

  int activeSection = 0;

  bool allowFetch = true;

  Map<String, bool> isFetching = {};
  Map<String, bool> endFetching = {};
  Map<String, List<Products>> subCategoriesProducts = {};
  Map<String, List<String>> subCategoriesIds = {};

  void triggerNotification() {
    notifyListeners();
  }
}
