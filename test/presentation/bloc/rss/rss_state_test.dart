import 'package:flutter_test/flutter_test.dart';
import 'package:news_app_flutter/feature-list/presentation/bloc/rss/rss_state.dart';

void main() {
  group('RssState', () {
    test('supports value comparisons', () {
      expect(InitialRssState(), InitialRssState());
    });
  });
}
