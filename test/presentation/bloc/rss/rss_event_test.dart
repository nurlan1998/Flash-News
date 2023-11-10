import 'package:flutter_test/flutter_test.dart';
import 'package:news_app_flutter/feature-list/presentation/bloc/rss/rss_event.dart';

void main() {
  const url = 'mock-url';
  group('RssEvent', () {
      test('supports value comparisons', () {
        expect(const GetRss(url: url), const GetRss(url: url));
      });
  });
}
