import 'package:news_app_flutter/core/data/http/api_client.dart';
import 'package:news_app_flutter/core/data/http/rss_client.dart';
import 'package:news_app_flutter/di/service_locator.dart';

abstract class BaseRepository {
  late ApiClient client;
  late RssClient rssClient;

  BaseRepository() {
    client = ServiceLocator.get<ApiClient>();
    rssClient = ServiceLocator.get<RssClient>();
  }
}