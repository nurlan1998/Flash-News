import 'package:bloc/bloc.dart';
import 'package:news_app_flutter/feature-list/domain/usecases/get_rss_news_usecase.dart';
import 'package:news_app_flutter/feature-list/presentation/bloc/rss/rss_event.dart';
import 'package:news_app_flutter/feature-list/presentation/bloc/rss/rss_state.dart';

class RssBloc extends Bloc<RssEvent, RssState> {
  final GetRssUseCase getRssUseCase;

  RssBloc({
    required GetRssUseCase rssUseCase,
  })  : getRssUseCase = rssUseCase,
        super(RssLoading());

  @override
  Stream<RssState> mapEventToState(RssEvent event) async* {
    if (event is GetRss) {
      yield RssLoading();
      try {
        final response = await getRssUseCase.call(Params(url: event.url));
        yield RssSuccess(rss: response.rssItem ?? []);
      } on Exception catch (e) {
        yield RssError(exception: e);
      }
    }
  }
}
