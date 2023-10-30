import 'package:equatable/equatable.dart';
import 'package:news_app_flutter/feature-list/domain/entities/rss_feed_item_entity.dart';

class RssFeedEntity extends Equatable {
  final List<RssFeedItemEntity>? rssItem;

  const RssFeedEntity({
    this.rssItem,
  });

  @override
  List<Object?> get props => [rssItem];
}