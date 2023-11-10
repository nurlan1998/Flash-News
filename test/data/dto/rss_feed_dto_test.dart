import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_app_flutter/feature-list/data/dto/rss_feed_dto.dart';

import '../../helpers/test_data/test_rss_feed_dto.dart';

class MockRssFeedDto extends Mock implements RssFeedDto {}

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  test('isRssFeedDto', () async {
    expect(testRssFeedDto, isA<RssFeedDto>());
  });

  test('return data from xml', () async {
    final xmlString = await rootBundle.loadString('assets/data.xml');
    final dto = RssFeedDto.parse(xmlString);
    expect(testRssFeedDto, dto);
  });
}
