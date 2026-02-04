import 'dart:developer';
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:negmt_heliopolis/firebase_options.dart';
import 'package:negmt_heliopolis/core/utlis/services/models/notification_payload_model.dart';
import 'package:negmt_heliopolis/core/utlis/services/helpers/local_notification_helper.dart';
import 'package:negmt_heliopolis/core/utlis/services/helpers/topic_manager.dart';

/// Key for storing pending notification data
const String _pendingNotificationKey = 'pending_notification_data';
const String _pendingNotificationTimeKey = 'pending_notification_time';

/// Background message handler - must be top-level function
@pragma('vm:entry-point')
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('BG Handler: Starting...');
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    log('BG Handler: Firebase initialized. Message ID: ${message.messageId}');

    // ALWAYS save the data for terminated state navigation
    // This is needed because getInitialMessage() may return null
    if (message.data.isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_pendingNotificationKey, jsonEncode(message.data));
      await prefs.setInt(
        _pendingNotificationTimeKey,
        DateTime.now().millisecondsSinceEpoch,
      );
      log('BG Handler: Saved pending notification data: ${message.data}');
    }

    // Check if Firebase already showed a notification (has Notification payload)
    // If yes, don't show another one from LocalNotificationHelper
    if (message.notification != null) {
      log(
        'BG Handler: Firebase already showed notification, skipping local notification',
      );
      return;
    }

    // Only show local notification for data-only messages
    final plugin = FlutterLocalNotificationsPlugin();

    // 1. Initialize plugin
    await LocalNotificationHelper.initializeForBackground(plugin);

    // 2. Create Channel (Critical for Android 8+)
    await LocalNotificationHelper.createChannel(plugin);

    // 3. Extract and Show
    final content = LocalNotificationHelper.extractContent(message);
    log('BG Handler: Content extracted - ${content['title']}');

    await LocalNotificationHelper.showNotification(
      plugin: plugin,
      title: content['title']!,
      body: content['body']!,
      imageUrl: content['imageUrl'],
      payload: jsonEncode(message.data),
    );
    log('BG Handler: Notification shown');
  } catch (e, stack) {
    log('BG Handler Error: $e');
    print('BG Handler Stack: $stack');
  }
}

/// Background notification tap handler - must be top-level function
@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse response) {
  log('notification tapped (background): ${response.payload}');
  // Navigation handled when app opens via getInitialNotification or onMessageOpenedApp
}

/// Main notification service class
class NotifcationService {
  static final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;

  /// Initialize all notification services
  static Future<void> initializeNotifications() async {
    // await TopicManager.requestPermission();

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    // Handle background message tap
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      _handleMessageOpenedApp(message);
    });

    // Subscribe to default topics
    await TopicManager.subscribeToDefaultTopics();

    // Save FCM token to server
    await TopicManager.saveTokenToServer();

    // Initialize local notifications
    await _initializeLocalNotifications();

    // Check for initial notification (app opened from terminated)
    await _getInitialNotification();
  }

  /// Handle foreground message
  static Future<void> _handleForegroundMessage(RemoteMessage message) async {
    log('Received foreground message: ${message.messageId}');
    log('Message Data: ${jsonEncode(message.data)}');
    final content = LocalNotificationHelper.extractContent(message);
    await LocalNotificationHelper.showNotification(
      plugin: _localNotificationsPlugin,
      title: content['title']!,
      body: content['body']!,
      imageUrl: content['imageUrl'],
      payload: jsonEncode(message.data),
      notificationId: 0,
    );
  }

  /// Handle message opened app (from background)
  static Future<void> _handleMessageOpenedApp(RemoteMessage message) async {
    log('Message opened app from background: ${message.messageId}');
    // Clear pending notification to prevent duplicate navigation
    await clearPendingNotification();
    handleNotificationNavigation(message.data);
  }

  /// Initialize local notifications plugin
  static Future<void> _initializeLocalNotifications() async {
    const androidSettings = AndroidInitializationSettings('ic_luncher');
    const iosSettings = DarwinInitializationSettings();
    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await LocalNotificationHelper.createChannel(_localNotificationsPlugin);

    await _localNotificationsPlugin.initialize(
      settings,
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
      onDidReceiveNotificationResponse: _handleNotificationTap,
    );
  }

  /// Handle notification tap (foreground)
  static void _handleNotificationTap(NotificationResponse response) {
    if (response.payload != null) {
      log('Notification tapped: ${response.payload}');
      try {
        final data = jsonDecode(response.payload!) as Map<String, dynamic>;
        handleNotificationNavigation(data);
      } catch (e) {
        log('Error parsing notification payload: $e');
      }
    }
  }

  /// Handle notification navigation
  static void handleNotificationNavigation(Map<String, dynamic> data) {
    NotificationPayloadModel.fromJson(data).navigate();
  }

  /// Get initial notification (app opened from terminated state)
  static Future<void> _getInitialNotification() async {
    log('_getInitialNotification: Checking for initial message...');

    // First try Firebase's getInitialMessage
    final initialMessage = await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      log(
        '_getInitialNotification: Got message from Firebase: ${initialMessage.data}',
      );
      // Clear any pending data since Firebase handled it
      await clearPendingNotification();
      Future.delayed(const Duration(seconds: 1), () {
        handleNotificationNavigation(initialMessage.data);
      });
      return;
    }

    log(
      '_getInitialNotification: Firebase returned null, checking SharedPreferences...',
    );

    // Fallback: Check SharedPreferences for pending notification
    // Only use if the notification was received recently (within 60 seconds)
    // This prevents navigating to an old notification when user opens app normally
    try {
      final prefs = await SharedPreferences.getInstance();
      final pendingData = prefs.getString(_pendingNotificationKey);
      final pendingTime = prefs.getInt(_pendingNotificationTimeKey) ?? 0;

      // Check if notification is recent (within 60 seconds)
      final now = DateTime.now().millisecondsSinceEpoch;
      final timeDiff = now - pendingTime;
      const maxAge = 60 * 1000; // 60 seconds in milliseconds

      if (pendingData != null &&
          pendingData.isNotEmpty &&
          timeDiff < maxAge &&
          timeDiff > 0) {
        log(
          '_getInitialNotification: Found recent pending data (${timeDiff}ms old): $pendingData',
        );

        // Clear the pending data immediately to prevent duplicate navigation
        await clearPendingNotification();

        final data = jsonDecode(pendingData) as Map<String, dynamic>;
        Future.delayed(const Duration(seconds: 1), () {
          handleNotificationNavigation(data);
        });
      } else if (pendingData != null) {
        log(
          '_getInitialNotification: Found old pending data (${timeDiff}ms old), ignoring',
        );
        await clearPendingNotification();
      } else {
        log('_getInitialNotification: No pending data found');
      }
    } catch (e) {
      log('_getInitialNotification: Error reading pending data: $e');
    }
  }

  /// Clear pending notification data (call when notification is handled elsewhere)
  static Future<void> clearPendingNotification() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_pendingNotificationKey);
    await prefs.remove(_pendingNotificationTimeKey);
  }

  // ==================== Public API ====================

  /// Handle topic switch after login
  static Future<void> handleLoginTopicSwitch() =>
      TopicManager.handleLoginTopicSwitch();

  /// Handle topic switch after logout
  static Future<void> handleLogoutTopicSwitch() =>
      TopicManager.handleLogoutTopicSwitch();

  /// Get FCM token
  static Future<String> getFcmToken() => TopicManager.getFcmToken();

  /// Subscribe to default topics
  static Future<void> subscribeToDefaultTopics() =>
      TopicManager.subscribeToDefaultTopics();

  /// Save token to server
  static Future<void> saveTokenToServer() => TopicManager.saveTokenToServer();
}
