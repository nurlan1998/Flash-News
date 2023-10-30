import 'package:equatable/equatable.dart';
import 'package:news_app_flutter/feature-list/domain/entities/rss_feed_item_entity.dart';

abstract class RssState extends Equatable {
  const RssState();

  @override
  List<Object> get props => [];
}

class InitialRssState extends RssState {}

class RssLoading extends RssState {}

class RssError extends RssState {
  final dynamic exception;

  const RssError({
    this.exception,
  });

  @override
  List<Object> get props => [exception];
}

class RssSuccess extends RssState {
  //final String? logoUrl;
  final List<RssFeedItemEntity> rss;

  const RssSuccess({
    required this.rss,
    //this.logoUrl,
  });

  @override
  List<Object> get props => [rss];
}
