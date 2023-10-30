import 'package:flutter/material.dart';
import 'package:news_app_flutter/core/data/logging/log.dart';

class CustomRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  static String currentRoute = '';

  final _ignored = <String>['/push-notification'];

  void _setCurrentRoute(PageRoute<dynamic> route) {
    final screenName = extractRoute(route.settings);
    if (screenName != null && !_ignored.contains(screenName)) {
      Log.i('[CustomRouteObserver] CurrentRoute set to: $screenName');
      currentRoute = screenName;
    }
  }

  String? extractRoute(RouteSettings settings) {
    if (settings == null) {
      return '/unknown';
    }
    return settings.name;
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    if (route is PageRoute) {
      _setCurrentRoute(route);
    }
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute is PageRoute) {
      _setCurrentRoute(newRoute);
    }
  }

  @override
  void didPop(Route<dynamic>? route, Route<dynamic>? previousRoute) {
    super.didPop(route!, previousRoute);
    if (previousRoute is PageRoute && route is PageRoute) {
      _setCurrentRoute(previousRoute);
    }
  }
}
