import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/bloc_observer.dart';
import 'package:negmt_heliopolis/core/models/language/app_localizations.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/language/cubit/locale_cubit.dart';
import 'package:negmt_heliopolis/core/utlis/routing/routes.dart';
import 'package:negmt_heliopolis/core/utlis/theming/themes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  AppRouter appRouter = AppRouter();
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

  runApp(
    MyApp(appRouter: appRouter),
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
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LocaleCubit()..getSavedLanguage(),
          ),
        ],
        child: BlocBuilder<LocaleCubit, ChangeLocaleState>(
          builder: (context, state) {
            TextDirection textDirection = state.locale.languageCode == 'ar'
                ? TextDirection.rtl
                : TextDirection.ltr;
            return Directionality(
              textDirection: textDirection,
              child: MaterialApp(
                onGenerateRoute: appRouter.generate,
                theme: lightTheme,
                darkTheme: darkTheme,
                themeMode: ThemeMode.light,
                locale: state.locale,
                supportedLocales: const [Locale('en'), Locale('ar')],
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate
                ],
                localeResolutionCallback: (deviceLocale, supportedLocales) {
                  for (var locale in supportedLocales) {
                    if (deviceLocale != null &&
                        deviceLocale.languageCode == locale.languageCode) {
                      return deviceLocale;
                    }
                  }

                  return supportedLocales.first;
                },
                debugShowCheckedModeBanner: false,
              ),
            );
          },
        ),
      ),
    );
  }
}
