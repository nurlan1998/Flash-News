import 'package:equatable/equatable.dart';
import 'package:news_app_flutter/feature-list/domain/entities/rss_feed_enclosure_entity.dart';

class RssFeedItemEntity extends Equatable {
  final String? id;
  final String? title;
  final String? description;
  final String? url;
  final String? link;
  final String? pubDate;
  final RssFeedEnclosureEntity? rssEnclosures;

  const RssFeedItemEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.url,
    required this.link,
    required this.pubDate,
    required this.rssEnclosures,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        url,
        link,
        pubDate,
        rssEnclosures,
      ];

  Map<String, dynamic> toHiveJson() {
    return {
      'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (link != null) 'link': link,
      if (pubDate != null) 'pubDate': pubDate,
      'enclosure': rssEnclosures?.url,
    };
  }
}
