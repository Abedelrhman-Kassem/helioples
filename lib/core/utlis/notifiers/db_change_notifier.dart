import 'package:flutter/material.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/db_helper.dart';

class DbChangeNotifier with ChangeNotifier {
  static final DbChangeNotifier _instance = DbChangeNotifier._internal();

  factory DbChangeNotifier() => _instance;

  DbChangeNotifier._internal() {
    fetchItemCount();
  }

  DbChangeNotifierModel _dbChangeNotifierModel =
      DbChangeNotifierModel(count: 0, totalPrice: 0);

  DbChangeNotifierModel get dbData => _dbChangeNotifierModel;

  Future<void> fetchItemCount() async {
    _dbChangeNotifierModel = await DBHelper.getDbData();
    notifyListeners();
  }
}

class DbChangeNotifierModel {
  late double totalPrice;
  late int count;

  DbChangeNotifierModel({
    required this.totalPrice,
    required this.count,
  });
}
