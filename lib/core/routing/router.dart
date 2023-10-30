import 'package:auto_route/annotations.dart';
import 'package:news_app_flutter/core/presentation/view/dashboard_page.dart';
import 'package:news_app_flutter/feature-detail/presentation/news_detail_page.dart';
import 'package:news_app_flutter/feature-list/presentation/view/rss_global_feed_page.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    AdaptiveRoute(
      initial: true,
      page: DashboardPage,
      name: 'dashboardPageRoute',
    ),
    AdaptiveRoute(
      page: RssGlobalFeedPage,
      name: 'newsPageRoute',
    ),
    AdaptiveRoute(
      page: NewsDetailPage,
      name: 'newsDetailPageRoute',
    ),
  ],
)
class $AutoRouter {}
