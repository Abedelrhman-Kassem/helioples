import 'package:flutter/material.dart';

class LikedNotifier with ChangeNotifier {
  LikedNotifier._privateConstructor();

  static final LikedNotifier _instance = LikedNotifier._privateConstructor();

  factory LikedNotifier() => _instance;

  String _productId = '';
  bool _isLiked = false;

  String get productId => _productId;
  bool get isLikedStatus => _isLiked;

  set productValue(String newValue) {
    _productId = newValue;
  }

  void triggerNotification(String id, bool status) {
    _productId = id;
    _isLiked = status;
    notifyListeners();
  }
}
