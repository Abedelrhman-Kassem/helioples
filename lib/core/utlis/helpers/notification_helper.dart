// import 'dart:developer';

// import 'package:another_flushbar/flushbar.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:negmt_heliopolis/core/constants/constants.dart';
// import 'package:negmt_heliopolis/core/utlis/helpers/keys_helper.dart';
// import 'package:negmt_heliopolis/core/utlis/theming/boxshadow.dart';

// import 'package:negmt_heliopolis/main.dart'; // Import the shared navigatorKey

// class NotificationService {
//   static final NotificationService _instance = NotificationService._internal();

//   factory NotificationService() => _instance;

//   NotificationService._internal();

  
//   void initialize() async {
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       if (message.notification != null) {
//         _showFlushbarIfReady(message.notification!.title!, message.notification!.body!);
//       }
//     });

//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message)
//     {
//        Navigator.pushNamed(
//           navigatorKey.currentContext!,
//           homeLayout, // Replace with your desired route
//         );

//     });

    
//   }

// Future<void> getInit() async {
//   try {
//     RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
//     log("Received initial message: ${initialMessage?.messageId}");
    
//     if (initialMessage != null && navigatorKey.currentContext != null) {
//       // Delay navigation to ensure the context is ready
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         Navigator.pushNamed(
//           navigatorKey.currentContext!,
//           homeLayout, // Replace with your desired route
//         );
//       });
//     } else {
//       log("Navigator context is not ready or no initial message.");
//     }
//   } catch (e) {
//     log("Error handling initial message: $e");
//   }
// }



  

  
//   void _showFlushbarIfReady(String title, String body) {
//     if (navigatorKey.currentContext != null) {
//       try {
//         Flushbar(
//           shouldIconPulse: true,
//           icon: Icon(Icons.notifications),
   
//           title: title,
//           message: body,
//           duration: const Duration(seconds: 2),
//           flushbarPosition: FlushbarPosition.TOP,
//           borderRadius: BorderRadius.circular(30.r),
//           margin:  EdgeInsets.all(6.sp),
//           padding:  EdgeInsets.all(12.sp),
//           backgroundColor: const Color.fromARGB(255, 211, 207, 207),
//         ).show(navigatorKey.currentContext!);
//       } catch (e) {
//         print("Flushbar error: $e");
//       }
//     } else {
//       print("navigatorKey.currentContext is null.");
//     }
//   }
// }
