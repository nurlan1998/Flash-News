import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:news_app_flutter/core/data/app_helper.dart';
import 'package:news_app_flutter/core/data/cache.dart';
import 'package:news_app_flutter/feature-list/data/dto/rss_feed_category_dto.dart';
import 'package:news_app_flutter/feature-list/data/dto/rss_feed_image_dto.dart';
import 'package:news_app_flutter/feature-list/data/dto/rss_feed_item_dto.dart';
import 'package:news_app_flutter/feature-list/domain/entities/rss_feed_entity.dart';
import 'package:xml/xml.dart';

part 'rss_feed_dto.g.dart';

@HiveType(typeId: 1)
class RssFeedDto extends Equatable {
  @HiveField(0)
  final String? title;
  @HiveField(1)
  final String? author;
  @HiveField(2)
  final String? description;
  @HiveField(3)
  final String? link;
  @HiveField(4)
  final List<RssFeedItemDto>? items;

  final RssFeedImageDto? image;
  final List<RssFeedCategoryDto> categories;
  final List<String> skipDays;
  final List<int> skipHours;
  final String? lastBuildDate;
  final String? language;
  final String? generator;
  final String? copyright;
  final String? docs;
  final String? managingEditor;
  final String? rating;
  final String? webMaster;
  final int ttl;

  const RssFeedDto({
    this.title,
    this.author,
    this.description,
    this.link,
    this.items = const <RssFeedItemDto>[],
    this.image,
    this.categories = const <RssFeedCategoryDto>[],
    this.skipDays = const <String>[],
    this.skipHours = const <int>[],
    this.lastBuildDate,
    this.language,
    this.generator,
    this.copyright,
    this.docs,
    this.managingEditor,
    this.rating,
    this.webMaster,
    this.ttl = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'items': FieldValue.arrayUnion(items!.map((i) => i.toMap()).toList()),
    };
  }

  factory RssFeedDto.parse(String xmlString) {
    final document = XmlDocument.parse(xmlString);
    XmlElement channelElement;
    try {
      channelElement = document.findAllElements('channel').first;
    } on StateError {
      throw ArgumentError('channel not found');
    }

    return RssFeedDto(
      title: AppHelper.findElementOrNull(channelElement, 'title')?.innerText,
      author: AppHelper.findElementOrNull(channelElement, 'author')?.innerText,
      description:
          AppHelper.findElementOrNull(channelElement, 'description')?.innerText,
      link: AppHelper.findElementOrNull(channelElement, 'link')?.innerText,
      items: channelElement
          .findElements('item')
          .map((element) => RssFeedItemDto.parse(element))
          .toList(),
      image: RssFeedImageDto.parse(
          AppHelper.findElementOrNull(channelElement, 'image')),
      //cloud: RssCloud.parse(AppHelper.findElementOrNull(channelElement, 'cloud')),
      categories: channelElement
          .findElements('category')
          .map((element) => RssFeedCategoryDto.parse(element))
          .toList(),
      skipDays: AppHelper.findElementOrNull(channelElement, 'skipDays')
              ?.findAllElements('day')
              .map((element) => element.innerText)
              .toList() ??
          <String>[],
      skipHours: AppHelper.findElementOrNull(channelElement, 'skipHours')
              ?.findAllElements('hour')
              .map((element) => int.tryParse(element.innerText) ?? 0)
              .toList() ??
          <int>[],
      lastBuildDate:
          AppHelper.findElementOrNull(channelElement, 'lastBuildDate')
              ?.innerText,
      language:
          AppHelper.findElementOrNull(channelElement, 'language')?.innerText,
      generator:
          AppHelper.findElementOrNull(channelElement, 'generator')?.innerText,
      copyright:
          AppHelper.findElementOrNull(channelElement, 'copyright')?.innerText,
      docs: AppHelper.findElementOrNull(channelElement, 'docs')?.innerText,
      managingEditor:
          AppHelper.findElementOrNull(channelElement, 'managingEditor')
              ?.innerText,
      rating: AppHelper.findElementOrNull(channelElement, 'rating')?.innerText,
      webMaster:
          AppHelper.findElementOrNull(channelElement, 'webMaster')?.innerText,
      ttl: int.tryParse(
            AppHelper.findElementOrNull(channelElement, 'ttl')?.innerText ??
                '0',
          ) ??
          0,
    );
  }

  static Box<RssFeedDto> get cacheBox => Cache.box<RssFeedDto>();

  Future<void> remove(cacheBoxKey) async {
    await cacheBox.delete(cacheBoxKey);
  }

  static RssFeedDto? fromCache(cacheBoxKey) {
    return cacheBox.get(cacheBoxKey);
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        title,
        author,
        description,
        link,
        items,
        image,
        categories,
        skipDays,
        skipHours,
        lastBuildDate,
        language,
        generator,
        copyright,
        docs,
        rating,
        webMaster,
        ttl,
      ];
}

extension RssNewsMapper on RssFeedDto {
  RssFeedEntity toEntity() {
    return RssFeedEntity(
      rssItem: items?.map((e) => e.toEntity()).toList(),
    );
  }
}
