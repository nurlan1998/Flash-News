import 'package:get_it/get_it.dart';
import 'package:news_app_flutter/core/data/cache.dart';
import 'package:news_app_flutter/core/data/http/api_client.dart';
import 'package:news_app_flutter/core/routing/router.gr.dart';
import 'package:news_app_flutter/feature-list/data/datasources/news_list_local_data_source.dart';
import 'package:news_app_flutter/feature-list/data/datasources/news_list_remote_data_source.dart';
import 'package:news_app_flutter/feature-list/data/repositories/news_list_repository_impl.dart';
import 'package:news_app_flutter/feature-list/domain/repositories/news_list_repository.dart';
import 'package:news_app_flutter/feature-list/domain/usecases/get_rss_news_usecase.dart';
import 'package:news_app_flutter/feature-list/presentation/bloc/rss/rss_bloc.dart';

final getIt = GetIt.instance;

class ServiceLocator {
  static Future<void> setup() async {
    getIt.registerSingleton<ApiClient>(ApiClient.instance());
    getIt.registerSingleton<Cache>(await Cache.initialize());
    getIt.registerSingleton<AutoRouter>(AutoRouter());

    //Bloc
    getIt.registerFactory(
      () => RssBloc(
        rssUseCase: getIt(),
      ),
    );

    //Use cases
    getIt.registerLazySingleton(() => GetRssUseCase(getIt()));

    //Repository
    getIt.registerLazySingleton<NewsListRepository>(
      () => NewsListRepositoryImpl(
        remoteDataSource: getIt(),
        localeDataSource: get(),
      ),
    );

    // Data sources
    getIt.registerLazySingleton<NewsListRemoteDataSource>(
      () => NewsListRemoteDataSourceImpl(),
    );
    getIt.registerLazySingleton<NewsListLocalDataSource>(
      () => NewsListLocalDataSourceImpl(),
    );
    //getIt.registerSingleton<Cache>(await Cache.instance());
  }

  static void dispose() {
    //ServiceLocator.get<Cache>().dispose();
  }

  static bool isRegistered<T extends Object>() {
    return getIt.isRegistered<T>();
  }

  static void unregister<T extends Object>() {
    if (getIt.isRegistered<T>()) {
      getIt.unregister<T>();
    }
  }

  static void registerSingleton<T extends Object>(T service) {
    if (!isRegistered<T>()) getIt.registerSingleton<T>(service);
  }

  static T get<T extends Object>() {
    return getIt<T>();
  }
}
