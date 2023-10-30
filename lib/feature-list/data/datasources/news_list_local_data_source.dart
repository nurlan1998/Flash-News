import 'package:news_app_flutter/core/data/cache.dart';
import 'package:news_app_flutter/core/data/logging/log.dart';
import 'package:news_app_flutter/feature-list/data/dto/rss_feed_dto.dart';

abstract class NewsListLocalDataSource {
  RssFeedDto? getLastRssData(cacheBoxKey);

  Future<void> cacheDataFromRss({
    required RssFeedDto rssDataToCache,
    required String cacheBoxKey,
  });
}

class NewsListLocalDataSourceImpl implements NewsListLocalDataSource {
  final cacheBox = Cache.box<RssFeedDto>();

  @override
  RssFeedDto? getLastRssData(cacheBoxKey) {
    return RssFeedDto.fromCache(cacheBoxKey);
  }

  @override
  Future<void> cacheDataFromRss({
    required RssFeedDto rssDataToCache,
    required String cacheBoxKey,
  }) async {
    try {
      await cacheBox.put(cacheBoxKey, rssDataToCache);
      Log.i(cacheBox.get(cacheBoxKey));
    } catch (error) {
      Log.e('CACHE ERROR', error);
    }
  }
}
