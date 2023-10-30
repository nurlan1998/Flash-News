import 'package:auto_route/auto_route.dart' as autoRoute;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:news_app_flutter/core/data/app/application.dart';
import 'package:news_app_flutter/core/data/app/helpers/shared_preferences_keys.dart';
import 'package:news_app_flutter/core/data/theme/theme_mode_helper.dart';
import 'package:news_app_flutter/core/data/theme/themes.dart';
import 'package:news_app_flutter/core/routing/custom_route_observer.dart';
import 'package:news_app_flutter/core/routing/router.gr.dart';
import 'package:news_app_flutter/di/service_locator.dart';
import 'package:news_app_flutter/feature-list/presentation/bloc/rss/rss_bloc.dart';
import 'package:news_app_flutter/core/data/app/delegates/app_translations_delegate.dart'
    as arb_translations_delegate;

class CustomMaterialApp extends StatefulWidget {
  CustomMaterialApp({Key? key}) : super(key: key) {
    //arb_translations_delegate.AppTranslationsDelegate.addAppCategory();
  }

  @override
  State<CustomMaterialApp> createState() => _CustomMaterialAppState();
}

class _CustomMaterialAppState extends State<CustomMaterialApp>
    with WidgetsBindingObserver {
  bool _initialized = false;

  final _generatedLocalizationsDelegate =
      arb_translations_delegate.AppTranslationsDelegate();

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Application.onAppLanguageChanged = _appLanguageChanged;
    WidgetsBinding.instance.addObserver(this);
    startApplication().then((_) {
      setState(() {
        _initialized = true;
      });
    });
  }

  void _appLanguageChanged(String? language) async {
    Application.language = language ?? 'ru';
    await Application.sharedPreferences
        ?.setString(SharedPreferencesKeys.appLanguage, language ?? 'ru');
    setState(() {});
  }

  Future<void> startApplication() async {
    await Application.setupSharedPreferences();
    await Application.setLanguageFromSharedPrefs();
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      return Container();
    }
    var currentLanguage = Application.language ?? 'ru';
    final router = ServiceLocator.get<AutoRouter>();
    return MultiBlocProvider(
      providers: <BlocProvider>[
        BlocProvider<RssBloc>(
          create: (_) => getIt<RssBloc>(),
        ),
      ],
      child: ValueListenableBuilder(
        valueListenable: ThemeModeHelper.notifier,
        builder: (context, ThemeMode value, _) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routeInformationParser: router.defaultRouteParser(),
            routerDelegate: autoRoute.AutoRouterDelegate(router,
                navigatorObservers: () => [CustomRouteObserver()]),
            title: 'Flash News',

            // i18n Config
            localizationsDelegates: [
              _generatedLocalizationsDelegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              DefaultCupertinoLocalizations.delegate,
            ],
            locale: Locale(currentLanguage, ''),
            supportedLocales: _generatedLocalizationsDelegate.supportedLocales,

            // Theme Settings
            themeMode: value,
            theme: LightTheme.config(),
            darkTheme: DarkTheme.config(),
          );
        },
      ),
    );
  }

  void hideKeyboard(BuildContext context) {
    final currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}
