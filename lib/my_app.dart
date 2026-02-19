import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:negmt_heliopolis/controller/Binding/initialbinding.dart';
import 'package:negmt_heliopolis/core/utlis/cubit/main_cubit.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/app_scroll_behavior.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/keys_helper.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/language_helper.dart';
import 'package:negmt_heliopolis/core/utlis/routing/routes.dart';
import 'package:negmt_heliopolis/core/utlis/services/awesome/awesome_notification_service.dart';
import 'package:negmt_heliopolis/core/utlis/services/awesome/notification_controller.dart';
import 'package:negmt_heliopolis/core/utlis/theming/themes.dart';

class MyApp extends StatefulWidget {
  final AppRouter appRouter;
  const MyApp({super.key, required this.appRouter});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    // Initialize notification listeners
    // This must be called after the widget is created
    NotificationController.initializeListeners();

    // Request notification permission (shows dialog if needed)
    AwesomeNotificationService.requestPermission();

    // Subscribe to default topics
    // _subscribeToTopics();
  }

  @override
  void dispose() {
    NotificationController.dispose();
    super.dispose();
  }

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
            onGenerateRoute: widget.appRouter.generate,
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
