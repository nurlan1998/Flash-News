import 'package:news_app_flutter/core/data/http/api_client.dart';
import 'package:news_app_flutter/di/service_locator.dart';

abstract class BaseRepository {
  late ApiClient client;

  BaseRepository() {
    client = ServiceLocator.get<ApiClient>();
  }
}