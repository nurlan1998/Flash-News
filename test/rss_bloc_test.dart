import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_app_flutter/core/data/http/api_exception.dart';
import 'package:news_app_flutter/di/service_locator.dart';
import 'package:news_app_flutter/feature-list/domain/entities/rss_feed_enclosure_entity.dart';
import 'package:news_app_flutter/feature-list/domain/entities/rss_feed_entity.dart';
import 'package:news_app_flutter/feature-list/domain/entities/rss_feed_item_entity.dart';
import 'package:news_app_flutter/feature-list/domain/usecases/get_rss_news_usecase.dart';
import 'package:news_app_flutter/feature-list/presentation/bloc/rss/rss_bloc.dart';
import 'package:news_app_flutter/feature-list/presentation/bloc/rss/rss_event.dart';
import 'package:news_app_flutter/feature-list/presentation/bloc/rss/rss_state.dart';
import 'package:bloc_test/bloc_test.dart';

class MockRssUseCase extends Mock implements GetRssUseCase {}

class MockRssEntity extends Mock implements RssFeedEntity {}

class MockException extends Mock implements Exception {}

void main() {
  RssBloc? rssBloc;
  GetRssUseCase? rssUseCase;
  RssFeedEntity? rssEntity;
  Exception? exception;
  // final rssEntity = RssFeedEntity(rssItem: [
  //   RssFeedItemEntity(
  //     id: '12',
  //     title: 'test',
  //     description: 'description',
  //     url: 'url',
  //     link: 'link',
  //     pubDate: 'pubDate',
  //     rssEnclosures: RssFeedEnclosureEntity(url: 'url'),
  //   )
  // ]);

  setUp(() {
    rssUseCase = MockRssUseCase();
    rssBloc = RssBloc(rssUseCase: rssUseCase!);
    rssEntity = MockRssEntity();
    exception = MockException();
  });

  group('RssBloc', () {
    test('initial state is GetRssState', () {
      expect(rssBloc?.state, RssLoading());
    });

    group('Load data', () {
      blocTest<RssBloc, RssState>('load data success',
          setUp: () {
            when(() => rssUseCase?.call(Params(url: 'url')))
                .thenAnswer((_) async => rssEntity!);
          },
          build: () => RssBloc(rssUseCase: rssUseCase!),
          act: (bloc) {
            bloc.add(GetRss(url: 'url'));
          },
          wait: const Duration(milliseconds: 100),
          expect: () =>
          <RssState>[
            RssLoading(),
            RssSuccess(rss: rssEntity?.rssItem ?? []),
          ],
          verify: (RssBloc bloc) =>
              verify(() => rssUseCase?.call(Params(url: 'url'))));

      blocTest<RssBloc, RssState>('Load data error',
          setUp: () {
            when(() => rssUseCase?.call(Params(url: 'url')))
                .thenThrow(Exception());
          },
          build: () => RssBloc(rssUseCase: rssUseCase!),
          act: (bloc) {
            bloc.add(GetRss(url: 'url'));
          },
          wait: const Duration(milliseconds: 100),
          expect: () =>
          <RssState>[
            RssLoading(),
            RssError(exception: throwsException),
          ],
          verify: (_) => verify(() => rssUseCase?.call(Params(url: 'url'))));
    });
  });
}
