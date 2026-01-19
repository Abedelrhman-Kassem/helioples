import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:negmt_heliopolis/controller/Binding/initialbinding.dart';
import 'package:negmt_heliopolis/core/bloc_observer.dart';
import 'package:negmt_heliopolis/core/utlis/cubit/main_cubit.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/app_scroll_behavior.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/cache_helper.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/db_helper.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/language_helper.dart';
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
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // FirebaseApi firebaseApi = FirebaseApi();
  // await firebaseApi.initNotification();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  await NotifcationService.initializeNotifications();
  await EasyLocalization.ensureInitialized();
  await ScreenUtil.ensureScreenSize();

  CacheHelper.init();
  // await DBHelper.deleteDB();
  DBHelper.init();
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
  // ServicesHelper.saveLocal(
  //   'token',
  //   'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6ImQ5ZDk4OGMyLTZkNmItNGMxNC1hZTIyLTQ3NTQ0NWEwMWQ2ZiIsImZpcnN0TmFtZSI6ImFobWVkIiwibGFzdE5hbWUiOiJtb25laW0iLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9kYXRlb2ZiaXJ0aCI6IjAxLzA2LzIwMjYgMTI6MTA6NDMiLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9tb2JpbGVwaG9uZSI6IjAxMjAxODU1NDg1IiwiaW1hZ2UiOiJzdHJpbmciLCJleHAiOjE3OTk3ODg2MjUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6NTE0NSIsImF1ZCI6Imh0dHA6Ly9sb2NhbGhvc3Q6NTE0NSJ9.04g8DqBAKC-ldW_OWUOMDn-Jk22CVaMVpHvVzPGwnm0',
  // );
  // check if user is logged in
  final String? token = await ServicesHelper.getLocal('token');
  final bool isLoggedIn = token != null;
  bool serverError = false;
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
