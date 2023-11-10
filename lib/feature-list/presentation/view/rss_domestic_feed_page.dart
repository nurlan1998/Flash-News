import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_app_flutter/core/data/app/application.dart';
import 'package:news_app_flutter/core/data/cache.dart';
import 'package:news_app_flutter/core/presentation/widgets/page_error.dart';
import 'package:news_app_flutter/core/presentation/widgets/page_loading.dart';
import 'package:news_app_flutter/core/routing/router.gr.dart';
import 'package:news_app_flutter/di/service_locator.dart';
import 'package:news_app_flutter/feature-list/presentation/bloc/rss/rss_bloc.dart';
import 'package:news_app_flutter/feature-list/presentation/bloc/rss/rss_event.dart';
import 'package:news_app_flutter/feature-list/presentation/bloc/rss/rss_state.dart';
import 'package:news_app_flutter/feature-list/presentation/widgets/rss_feed_item.dart';

const String uznewsUrl = 'https://uznews.uz';
const String gazetauzUrl = 'https://www.gazeta.uz';
const String kunuzUrl = 'https://kun.uz';

class RssDomesticFeedPage extends StatefulWidget {
  const RssDomesticFeedPage({Key? key}) : super(key: key);

  @override
  State<RssDomesticFeedPage> createState() => _RssDomesticFeedPageState();
}

class _RssDomesticFeedPageState extends State<RssDomesticFeedPage>
    with SingleTickerProviderStateMixin {
  static Box get _favouriteFeedsBox => ServiceLocator.get<Cache>().favourites;
  late TabController tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    tabController = TabController(
      vsync: this,
      length: 3,
      initialIndex: 0,
    );
    loadData(_selectedIndex);
    super.initState();
  }

  void loadData(tabIndex) {
    String currentLanguage = Application.language ?? 'ru';

    switch (tabIndex) {
      case 0:
        if (Application.language == 'en') {
          currentLanguage = 'ru';
        }
        BlocProvider.of<RssBloc>(context)
            .add(GetRss(url: '$uznewsUrl/$currentLanguage/rss'));
        break;
      case 1:
        BlocProvider.of<RssBloc>(context)
            .add(GetRss(url: '$gazetauzUrl/$currentLanguage/rss'));
        break;
      case 2:
        BlocProvider.of<RssBloc>(context)
            .add(GetRss(url: '$kunuzUrl/$currentLanguage/rss'));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        loadData(_selectedIndex);
      },
      child: Column(
        children: [
          TabBar(
              onTap: (tabIndex) {
                _selectedIndex = tabIndex;
                loadData(tabIndex);
              },
              dividerColor: Colors.transparent,
              padding: const EdgeInsets.all(16.0),
              controller: tabController,
              tabs: [
                Container(
                  width: 90,
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Uznews',
                        style: TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  width: 90,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Gazeta.uz',
                        style: TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                ),
                Container(
                  width: 90,
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Kun.uz',
                        style: TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                ),
              ]),
          BlocBuilder(
              bloc: BlocProvider.of<RssBloc>(context),
              builder: (context, state) {
                if (state is RssLoading) {
                  return const PageLoading();
                }
                if (state is RssError) {
                  return PageError(
                    onRefresh: () => loadData(_selectedIndex),
                    exception: state.exception,
                  );
                }
                if (state is RssSuccess) {
                  return ValueListenableBuilder(
                      valueListenable: _favouriteFeedsBox.listenable(),
                      builder: (context, box, child) {
                        return Expanded(
                          child: ListView.builder(
                              itemCount: state.rss.length,
                              itemBuilder: (context, int index) {
                                final isFavorite = _favouriteFeedsBox
                                    .containsKey(state.rss[index].link);

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
                                      rssEnclosureEntity:
                                          state.rss[index].rssEnclosures,
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
                              }),
                        );
                      });
                }
                return Container();
              }),
        ],
      ),
    );
  }
}
