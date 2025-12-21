import 'package:flutter/material.dart';

class LikedNotifier with ChangeNotifier {
  LikedNotifier._privateConstructor();

  static final LikedNotifier _instance = LikedNotifier._privateConstructor();

  factory LikedNotifier() => _instance;

  String _productId = '';

  String get productId => _productId;

  set productValue(String newValue) {
    _productId = newValue;
  }

  void triggerNotification() {
    notifyListeners();
  }
}
