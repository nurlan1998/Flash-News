import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:news_app_flutter/core/data/app_helper.dart';
import 'package:news_app_flutter/feature-list/domain/entities/rss_feed_item_entity.dart';
import 'package:xml/xml.dart';

import 'rss_feed_category_dto.dart';
import 'rss_feed_enclosure_dto.dart';

part 'rss_feed_item_dto.g.dart';

@HiveType(typeId: 2)
class RssFeedItemDto extends Equatable {
  @HiveField(0)
  final String? title;
  @HiveField(1)
  final String? description;
  @HiveField(2)
  final String? link;
  @HiveField(3)
  final List<RssFeedCategoryDto>? categories;
  @HiveField(4)
  final String? guid;
  @HiveField(5)
  final String? pubDate;
  @HiveField(6)
  final String? author;
  @HiveField(7)
  final String? comments;
  @HiveField(9)
  final RssFeedEnclosureDto? enclosure;
  @HiveField(10)
  final String? id;

  const RssFeedItemDto({
    this.title,
    this.description,
    this.link,
    this.categories = const <RssFeedCategoryDto>[],
    this.guid,
    this.pubDate,
    this.author,
    this.comments,
    this.enclosure,
    this.id,
  });

  factory RssFeedItemDto.parse(XmlElement element) {
    return RssFeedItemDto(
      title: AppHelper.findElementOrNull(element, 'title')?.innerText,
      description:
          AppHelper.findElementOrNull(element, 'description')?.innerText,
      link: AppHelper.findElementOrNull(element, 'link')?.innerText,
      categories: element
          .findElements('category')
          .map((element) => RssFeedCategoryDto.parse(element))
          .toList(),
      guid: AppHelper.findElementOrNull(element, 'guid')?.innerText,
      pubDate: AppHelper.findElementOrNull(element, 'pubDate')?.innerText,
      author: AppHelper.findElementOrNull(element, 'author')?.innerText,
      comments: AppHelper.findElementOrNull(element, 'comments')?.innerText,
      enclosure: RssFeedEnclosureDto.parse(
          AppHelper.findElementOrNull(element, 'enclosure')),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': AppHelper.getRandomUuid(),
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (link != null) 'link': link,
      if (enclosure?.url != null) 'url': enclosure?.url,
      if (pubDate != null) 'pubDate': pubDate,
      if (comments != null) 'comments': comments,
      if (enclosure != null) 'enclosures': enclosure?.toMap(),
    };
  }

  @override
  List<Object?> get props => [title,description,link,enclosure,pubDate];
}

extension RssItemMapper on RssFeedItemDto {
  RssFeedItemEntity toEntity() {
    return RssFeedItemEntity(
      id: id,
      title: title,
      description: description,
      url: enclosure?.url,
      pubDate: pubDate,
      rssEnclosures: enclosure?.toEntity(),
      link: link,
    );
  }
}
