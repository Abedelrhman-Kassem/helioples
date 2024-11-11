import 'package:flutter/material.dart';

class LikedNotifier with ChangeNotifier {
  LikedNotifier._privateConstructor();

  static final LikedNotifier _instance = LikedNotifier._privateConstructor();

  factory LikedNotifier() => _instance;

  int _productId = 0;

  int get productId => _productId;

  set productValue(int newValue) {
    _productId = newValue;
  }

  void triggerNotification() {
    notifyListeners();
  }
}
