// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Global`
  String get btnBottomNav_global {
    return Intl.message(
      'Global',
      name: 'btnBottomNav_global',
      desc: '',
      args: [],
    );
  }

  /// `Local`
  String get btnBottomNav_local {
    return Intl.message(
      'Local',
      name: 'btnBottomNav_local',
      desc: '',
      args: [],
    );
  }

  /// `Favorites`
  String get btnBottomNav_favourite {
    return Intl.message(
      'Favorites',
      name: 'btnBottomNav_favourite',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get btnBottomNav_settings {
    return Intl.message(
      'Settings',
      name: 'btnBottomNav_settings',
      desc: '',
      args: [],
    );
  }

  /// `Latest news`
  String get aboutApp_lastNews {
    return Intl.message(
      'Latest news',
      name: 'aboutApp_lastNews',
      desc: '',
      args: [],
    );
  }

  /// `The language changes only for local news`
  String get aboutApp_showWarning {
    return Intl.message(
      'The language changes only for local news',
      name: 'aboutApp_showWarning',
      desc: '',
      args: [],
    );
  }

  /// `The list is empty`
  String get favorite_listEmpty {
    return Intl.message(
      'The list is empty',
      name: 'favorite_listEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Delete a news item`
  String get favourite_removeNewsTitle {
    return Intl.message(
      'Delete a news item',
      name: 'favourite_removeNewsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this news?`
  String get favourite_removeNewsDescription {
    return Intl.message(
      'Are you sure you want to delete this news?',
      name: 'favourite_removeNewsDescription',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to delete all the news`
  String get favourite_removeAllNewsTitle {
    return Intl.message(
      'Do you want to delete all the news',
      name: 'favourite_removeAllNewsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete all the news?`
  String get favourite_removeAllNewsDescription {
    return Intl.message(
      'Are you sure you want to delete all the news?',
      name: 'favourite_removeAllNewsDescription',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Remove`
  String get remove {
    return Intl.message(
      'Remove',
      name: 'remove',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
      Locale.fromSubtags(languageCode: 'uz'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
