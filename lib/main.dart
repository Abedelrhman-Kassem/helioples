import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:negmt_heliopolis/controller/Binding/initialbinding.dart';
import 'package:negmt_heliopolis/controller/getx_service/check_mainte_nance.dart';
import 'package:negmt_heliopolis/core/bloc_observer.dart';
import 'package:negmt_heliopolis/core/utlis/cubit/main_cubit.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/app_scroll_behavior.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/cache_helper.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/db_helper.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/language_helper.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_service.dart';
import 'package:negmt_heliopolis/core/utlis/routing/routes.dart';
import 'package:negmt_heliopolis/core/utlis/services/notifcation_service.dart';
import 'package:negmt_heliopolis/core/utlis/services/services_helper.dart';
import 'package:negmt_heliopolis/core/utlis/theming/themes.dart';
import 'package:negmt_heliopolis/firebase_options.dart';
import 'package:negmt_heliopolis/generated/codegen_loader.g.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/keys_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  // await NotifcationService.initializeNotifications();
  await EasyLocalization.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  const bool isPreReleaseTesting = true;

  await FirebaseAppCheck.instance.activate(
    providerAndroid: (kDebugMode || isPreReleaseTesting)
        ? const AndroidDebugProvider()
        : const AndroidPlayIntegrityProvider(),
    providerApple: const AppleDeviceCheckProvider(),
  );
  CacheHelper.init();
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

  // ============ DEBUG: Check terminated notification ============

  // ==============================================================

  // ServicesHelper.saveLocal(
  //   'token',
  //   'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6IjZlOGFmYzZiLTVhMWMtNDNkNi1iYzQ3LTZlOTg1ZjQyYjlhNyIsImZpcnN0TmFtZSI6IkgiLCJsYXN0TmFtZSI6IkgiLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9kYXRlb2ZiaXJ0aCI6IjEyLzcvMjAyNSAxMjo0MDoxNlx1MjAyRlBNIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvbW9iaWxlcGhvbmUiOiIwMTIwMTU1NTQ4NSIsImV4cCI6MTgwMDU4MzA0NCwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo1MTQ1IiwiYXVkIjoiaHR0cDovL2xvY2FsaG9zdDo1MTQ1In0.8Xa2fSF0glNHtZ49vQ9iDDUESyEqTKimt18ZOi7_JYo',
  // );
  // check if user is logged in
  MaintenanceModel checkMaintenance = await Get.put(
    CheckMaintenance(api: Get.find<ApiService>()),
  ).checkMaintenance();
  // checkMaintenance = MaintenanceModel(avilbal: false, massege: 'Maintenance');
  final String? token = await ServicesHelper.getLocal('token');
  final bool isLoggedIn = token != null;
  bool serverError = checkMaintenance.avilbal!;
  final appRouter = AppRouter(isLoggedIn: isLoggedIn, serverError: serverError);
  // ----------------------------------------------------------------------

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

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  const MyApp({super.key, required this.appRouter});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return BlocProvider(
          lazy: false,
          create: (context) => MainCubit(),
          child: GetMaterialApp(
            scrollBehavior: AppScrollBehavior(),
            initialBinding: Initialbinding(),
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            onGenerateRoute: appRouter.generate,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.light,
            locale: Locale(getLocale(context)),
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,
          ),
        );
      },
    );
  }
}
