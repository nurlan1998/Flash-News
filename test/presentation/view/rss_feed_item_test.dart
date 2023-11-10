import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news_app_flutter/feature-list/domain/entities/rss_feed_enclosure_entity.dart';
import 'package:news_app_flutter/feature-list/domain/entities/rss_feed_item_entity.dart';
import 'package:news_app_flutter/feature-list/presentation/widgets/rss_feed_item.dart';

void main() {
    testWidgets('rssFeedItemWidgets', (widgetTester) async {
      await widgetTester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: RssFeedItem(
            isFavorite: false,
              rssItemEntity: RssFeedItemEntity(
                id: 'id',
                title: 'title',
                description: 'description',
                url: 'url',
                link: 'url',
                pubDate: 'pubDate',
                rssEnclosures: null,
              ),
              rssEnclosureEntity: RssFeedEnclosureEntity(url: 'url')),
        ),
      ));

      final titleFinder = find.text('title');
      final pubDateFinder = find.text('pubDate');

      expect(titleFinder, findsOneWidget);
      expect(pubDateFinder, findsOneWidget);
    });
}
