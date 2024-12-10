import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/widgets.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/main.dart';


class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    // Request user permission for notifications
    await _firebaseMessaging.requestPermission();

    // Fetch and log the FCM Token
    final fCMToken = await _firebaseMessaging.getToken();
    log("Token: $fCMToken");

    // Initialize push notification handlers
    await initPushNotifications();
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) {
      log("No message received in handleMessage.");
      return;
    }
    log("Handling message: ${message.data}");

    WidgetsBinding.instance.addPostFrameCallback((_) {
    
      log("Navigator Key State: ${navigatorKey.currentState}");
      

      navigatorKey.currentState?.pushNamed(homeLayout);
    });
  }

  Future<void> initPushNotifications() async {
    // Handle interaction when the app is terminated
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    log("inside notifications ");

    // Attach event listeners for notification interactions
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }
}
