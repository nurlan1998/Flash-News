import 'package:news_app_flutter/core/data/app/base_repository.dart';

import '../dto/rss_feed_dto.dart';

abstract class NewsListRemoteDataSource {
  Future<RssFeedDto> getNewsFromRss({
    required String url,
  });
}

class NewsListRemoteDataSourceImpl extends BaseRepository
    implements NewsListRemoteDataSource {
  @override
  Future<RssFeedDto> getNewsFromRss({
    required String url
  }) async {
    final response = await client.client.getUri(Uri.parse(url));
    final channel = RssFeedDto.parse(response.data);
    return channel;
  }
}

