import 'dart:developer';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_service.dart';
import 'package:negmt_heliopolis/core/utlis/services/services_helper.dart';
import 'package:negmt_heliopolis/features/Notification/data/repo/notification_repo_imp.dart';

/// Helper class for managing Firebase topics and token
class TopicManager {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  /// Subscribe to default topics on app startup
  static Future<void> subscribeToDefaultTopics() async {
    final isSubscribed = await ServicesHelper.getLocal(
      'is_subscribed_to_default_topics',
    );
    if (isSubscribed == 'true') {
      log('Already subscribed to default topics.');
      return;
    }

    try {
      await _messaging.subscribeToTopic(customers);
      await _messaging.subscribeToTopic(unsubscribedCustomers);
      await ServicesHelper.saveLocal('is_subscribed_to_default_topics', 'true');
      log('Subscribed to default topics: $customers, $unsubscribedCustomers');
    } catch (e) {
      log('Error subscribing to default topics: $e');
    }
  }

  /// Handle topic switch after login
  static Future<void> handleLoginTopicSwitch() async {
    await _messaging.unsubscribeFromTopic(unsubscribedCustomers);
    await _messaging.subscribeToTopic(subscribedCustomers);
    log(
      'Login topic switch: removed $unsubscribedCustomers, added $subscribedCustomers',
    );
  }

  /// Handle topic switch after logout
  static Future<void> handleLogoutTopicSwitch() async {
    await _messaging.unsubscribeFromTopic(subscribedCustomers);
    await _messaging.subscribeToTopic(unsubscribedCustomers);
    log(
      'Logout topic switch: removed $subscribedCustomers, added $unsubscribedCustomers',
    );
  }

  /// Get FCM token
  static Future<String> getFcmToken() async {
    final token = await _messaging.getToken();
    log('Firebase Messaging Token: $token');
    return token!;
  }

  /// Save FCM token to server
  static Future<void> saveTokenToServer() async {
    Get.put(ApiService(), permanent: true);
    try {
      String? res = await ServicesHelper.getLocal('fcm_token');
      if (res != null) {
        return;
      }
      final token = await getFcmToken();
      final platform = Platform.isAndroid ? 'Android' : 'iOS';
      final repo = NotificationRepoImp(api: Get.find<ApiService>());
      await repo.saveDeviceToken(token: token, platform: platform);
    } catch (e) {
      log('Error saving token to server: $e');
    }
  }

  /// Request notification permissions
  static Future<void> requestPermission() async {
    await _messaging.requestPermission();
  }
}
