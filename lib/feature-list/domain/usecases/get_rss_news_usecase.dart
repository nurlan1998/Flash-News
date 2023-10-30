import 'package:equatable/equatable.dart';
import 'package:news_app_flutter/core/domain/usecase/usecase.dart';
import 'package:news_app_flutter/feature-list/domain/entities/rss_feed_entity.dart';
import 'package:news_app_flutter/feature-list/domain/repositories/news_list_repository.dart';

class GetRssUseCase implements UseCase<RssFeedEntity, Params> {
  final NewsListRepository repository;

  GetRssUseCase(this.repository);

  @override
  Future<RssFeedEntity> call(Params params) async {
    return await repository.getNewsFromRss(url: params.url);
  }
}

class Params extends Equatable {
  final String url;

  const Params({required this.url});

  @override
  List<Object> get props => [url];
}
