import 'package:news_app_flutter/feature-list/domain/entities/rss_feed_entity.dart';

abstract class NewsListRepository {
  Future<RssFeedEntity> getNewsFromRss({required String url});
}
