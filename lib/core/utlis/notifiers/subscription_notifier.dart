import 'package:flutter/material.dart';

class SubscriptionNotifier with ChangeNotifier {
  SubscriptionNotifier._privateConstructor();

  static final SubscriptionNotifier _instance =
      SubscriptionNotifier._privateConstructor();

  factory SubscriptionNotifier() => _instance;

  String _productId = '';
  bool _isSubscribed = false;

  String get productId => _productId;
  bool get isSubscribed => _isSubscribed;

  void triggerNotification(String id, bool status) {
    _productId = id;
    _isSubscribed = status;
    notifyListeners();
  }
}
