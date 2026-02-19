import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:negmt_heliopolis/controller/getx_service/check_mainte_nance.dart';
import 'package:negmt_heliopolis/core/bloc_observer.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/db_helper.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_service.dart';
import 'package:negmt_heliopolis/core/utlis/routing/routes.dart';
import 'package:negmt_heliopolis/core/utlis/services/awesome/awesome_fcm_service.dart';
import 'package:negmt_heliopolis/core/utlis/services/awesome/awesome_notification_service.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/cache_helper.dart';
import 'package:negmt_heliopolis/firebase_options.dart';
import 'package:negmt_heliopolis/generated/codegen_loader.g.dart';
import 'package:negmt_heliopolis/my_app.dart';

void main() async {
  await _initializeApp();
  // ServicesHelper.instance.saveLocal(
  //   'token',
  //   'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6IjZlOGFmYzZiLTVhMWMtNDNkNi1iYzQ3LTZlOTg1ZjQyYjlhNyIsImZpcnN0TmFtZSI6IkgiLCJsYXN0TmFtZSI6IkgiLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9kYXRlb2ZiaXJ0aCI6IjEyLzcvMjAyNSAxMjo0MDoxNlx1MjAyRlBNIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvbW9iaWxlcGhvbmUiOiIwMTIwMTU1NTQ4NSIsImV4cCI6MTgwMDU4MzA0NCwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo1MTQ1IiwiYXVkIjoiaHR0cDovL2xvY2FsaG9zdDo1MTQ1In0.8Xa2fSF0glNHtZ49vQ9iDDUESyEqTKimt18ZOi7_JYo',
  // );

  MaintenanceModel checkMaintenance = await Get.put(
    CheckMaintenance(api: Get.find<ApiService>()),
  ).checkMaintenance();
  final String? token = await CacheHelper.instance.getLocal('token');
  final bool isLoggedIn = token != null;
  bool serverError = checkMaintenance.avilbal!;
  final appRouter = AppRouter(isLoggedIn: isLoggedIn, serverError: serverError);

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/languages_jsons',
      fallbackLocale: const Locale('ar'),
      assetLoader: const CodegenLoader(),
      child: MyApp(appRouter: appRouter),
    ),
  );
}

Future<void> _initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  //  Initialize Awesome Notifications
  await AwesomeNotificationService.initialize();
  await AwesomeFcmService.initialize();

  // Subscribe to default topics and save token
  await AwesomeFcmService.subscribeToDefaultTopics();
  await AwesomeFcmService.saveTokenToServer();

  //  initialize localization and screen util before running the app
  await EasyLocalization.ensureInitialized();

  //  important to initialize screen util for fix bug in (Release mode) that cause the app to crash because of the screen size
  await ScreenUtil.ensureScreenSize();

  //  APP CHECK FOR PROTECTING THE APP FROM ABUSE AND FRAUD
  await FirebaseAppCheck.instance.activate(
    providerAndroid: kDebugMode
        ? const AndroidDebugProvider()
        : const AndroidPlayIntegrityProvider(),
    providerApple: const AppleDeviceCheckProvider(),
  );
  await CacheHelper.init();
  // await DBHelper.deleteDB();
  await DBHelper.init();
  // AppRouter appRouter = AppRouter();
  Bloc.observer = MyBlocObserver();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
    ),
  );
}
