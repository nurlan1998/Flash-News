import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_app_flutter/feature-list/data/dto/rss_feed_dto.dart';

class MockRssFeedDto extends Mock implements RssFeedDto {}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final rssFeedDtoTest = MockRssFeedDto();
  
  test('description', () async {
    expect(rssFeedDtoTest, isA<RssFeedDto>());
  });

group('fromJson', () {
  test('return data from xml', () async {
    final xmlString = await rootBundle.loadString('assets/data.xml');
    expect(xmlString, rssFeedDtoTest);
  });
});
}
