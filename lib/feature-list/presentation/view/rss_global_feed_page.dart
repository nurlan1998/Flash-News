import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_app_flutter/core/presentation/widgets/page_error.dart';
import 'package:news_app_flutter/core/presentation/widgets/page_loading.dart';
import 'package:news_app_flutter/core/presentation/widgets/theme_mode_switcher.dart';
import 'package:news_app_flutter/core/routing/router.gr.dart';
import 'package:news_app_flutter/feature-list/presentation/bloc/rss/rss_bloc.dart';
import 'package:news_app_flutter/feature-list/presentation/bloc/rss/rss_event.dart';
import 'package:news_app_flutter/feature-list/presentation/bloc/rss/rss_state.dart';
import 'package:news_app_flutter/feature-list/presentation/widgets/rss_feed_item.dart';

import '../../../core/data/cache.dart';
import '../../../di/service_locator.dart';

class RssGlobalFeedPage extends StatefulWidget {
  const RssGlobalFeedPage({Key? key}) : super(key: key);

  @override
  State<RssGlobalFeedPage> createState() => _RssGlobalFeedPageState();
}

class _RssGlobalFeedPageState extends State<RssGlobalFeedPage> {
  TextEditingController searchController = TextEditingController();

  static Box get _favouriteFeedsBox => ServiceLocator.get<Cache>().favourites;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() {
    BlocProvider.of<RssBloc>(context).add(GetRss(url: 'https://lenta.ru/rss'));
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        loadData();
      },
      child: BlocConsumer(
        bloc: BlocProvider.of<RssBloc>(context),
        listener: (context, state) {},
        builder: (BuildContext context, dynamic state) {
          if (state is RssLoading) {
            return const PageLoading();
          }
          if (state is RssError) {
            return PageError(
              onRefresh: () {
                loadData();
              },
              exception: state.exception,
            );
          }
          if (state is RssSuccess) {
            return ValueListenableBuilder(
              valueListenable: _favouriteFeedsBox.listenable(),
              builder: (context, box, child) {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.rss.length,
                    itemBuilder: (BuildContext context, int index) {
                      final isFavorite =
                          _favouriteFeedsBox.containsKey(state.rss[index].link);

                      return GestureDetector(
                        onTap: () {
                          context.router.push(NewsDetailPageRoute(
                            title: state.rss[index].title ?? '',
                              link: state.rss[index].link!));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RssFeedItem(
                            isFavorite: isFavorite,
                            rssItemEntity: state.rss[index],
                            rssEnclosureEntity: state.rss[index].rssEnclosures,
                            onTapFavourite: () async {
                              if (isFavorite) {
                                await _favouriteFeedsBox
                                    .delete(state.rss[index].link);
                              } else {
                                await _favouriteFeedsBox.put(
                                    state.rss[index].link,
                                    state.rss[index].toHiveJson());
                              }
                            },
                          ),
                        ),
                      );
                    });
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
