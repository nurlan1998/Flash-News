import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_app_flutter/core/data/http/api_exception.dart';
import 'package:news_app_flutter/feature-list/domain/entities/rss_feed_entity.dart';
import 'package:news_app_flutter/feature-list/domain/usecases/get_rss_news_usecase.dart';
import 'package:news_app_flutter/feature-list/presentation/bloc/rss/rss_bloc.dart';
import 'package:news_app_flutter/feature-list/presentation/bloc/rss/rss_event.dart';
import 'package:news_app_flutter/feature-list/presentation/bloc/rss/rss_state.dart';
import 'package:bloc_test/bloc_test.dart';

class MockRssUseCase extends Mock implements GetRssUseCase {}

class MockRssEntity extends Mock implements RssFeedEntity {}

class MockException extends Mock implements ApiException {}

void main() {
  late RssBloc rssBloc;
  late GetRssUseCase rssUseCase;
  late RssFeedEntity rssEntity;
  late Exception exception = MockException();

  setUp(() {
    rssUseCase = MockRssUseCase();
    rssBloc = RssBloc(rssUseCase: rssUseCase);
    rssEntity = MockRssEntity();
    exception = MockException();
  });

  group('RssBloc', () {
    test('initial state is GetRssState', () {
      expect(rssBloc.state, RssLoading());
    });

    group('Load data', () {
      blocTest<RssBloc, RssState>('load data success',
          setUp: () {
            when(() => rssUseCase.call(const Params(url: 'url')))
                .thenAnswer((_) async => rssEntity);
          },
          build: () => RssBloc(rssUseCase: rssUseCase),
          act: (bloc) {
            bloc.add(const GetRss(url: 'url'));
          },
          wait: const Duration(milliseconds: 100),
          expect: () => <RssState>[
                RssLoading(),
                RssSuccess(rss: rssEntity.rssItem ?? []),
              ],
          verify: (RssBloc bloc) =>
              verify(() => rssUseCase.call(const Params(url: 'url'))));

      blocTest<RssBloc, RssState>('Load data error',
          setUp: () {
            when(() => rssUseCase.call(const Params(url: 'url')))
                .thenThrow(exception);
          },
          build: () => RssBloc(rssUseCase: rssUseCase),
          act: (bloc) {
            bloc.add(const GetRss(url: 'url'));
          },
          wait: const Duration(milliseconds: 100),
          expect: () => <RssState>[
                RssLoading(),
                RssError(exception: exception),
              ],
          verify: (_) => verify(() => rssUseCase.call(const Params(url: 'url'))));
    });
  });
}
