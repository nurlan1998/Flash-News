import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_app_flutter/core/data/cache.dart';
import 'package:news_app_flutter/core/data/theme/theme_mode_helper.dart';
import 'package:news_app_flutter/core/presentation/helpers/app_colors.dart';
import 'package:news_app_flutter/core/routing/router.gr.dart';
import 'package:news_app_flutter/di/service_locator.dart';
import 'package:news_app_flutter/generated/l10n.dart';

class RssFavoriteFeedPage extends StatefulWidget {
  const RssFavoriteFeedPage({Key? key}) : super(key: key);

  @override
  State<RssFavoriteFeedPage> createState() => _RssFavoriteFeedPageState();
}

class _RssFavoriteFeedPageState extends State<RssFavoriteFeedPage> {
  static Box get _favouriteFeedsBox => ServiceLocator.get<Cache>().favourites;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _favouriteFeedsBox.listenable(),
      builder: (context, box, child) {
        final favourites = _favouriteFeedsBox.values.toList();

        if (favourites.isEmpty) {
          return Center(
            child: Text(
              S.of(context).favorite_listEmpty,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        }

        return Stack(
          children: [
            ListView.builder(
                shrinkWrap: true,
                itemCount: favourites.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        context.router.push(NewsDetailPageRoute(
                            title: favourites[index]['title'] ?? '',
                            link: favourites[index]['link']));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          image: (favourites[index]['enclosure'] != null
                              ? DecorationImage(
                                  image: CachedNetworkImageProvider(
                                      favourites[index]['enclosure']),
                                  fit: BoxFit.fill,
                                )
                              : null),
                        ),
                        height: 200,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    showWarning(
                                        title: S
                                            .of(context)
                                            .favourite_removeNewsTitle,
                                        description: S
                                            .of(context)
                                            .favourite_removeNewsDescription,
                                        onRemove: () {
                                          _favouriteFeedsBox.delete(
                                              favourites[index]['link']);
                                          context.router.pop();
                                        });
                                  },
                                  child: Container(
                                      height: 40,
                                      width: 40,
                                      padding: const EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                          color: AppColors.blue700,
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: const Icon(
                                        Icons.clear,
                                        color: Colors.white,
                                      )),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                height: 60,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(8.0),
                                    bottomRight: Radius.circular(8.0),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.6),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          if (favourites[index]['title'] !=
                                              null)
                                            Expanded(
                                              child: Text(
                                                favourites[index]['title'],
                                                style: const TextStyle(
                                                    color: Colors.white),
                                                textAlign: TextAlign.start,
                                                maxLines: 2,
                                              ),
                                            ),
                                          if (favourites[index]['pubDate'] !=
                                              null)
                                            Text(
                                              favourites[index]['pubDate'] ??
                                                  '',
                                              style: const TextStyle(
                                                  color: Colors.white),
                                              textAlign: TextAlign.start,
                                            ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
            Positioned(
                bottom: 20,
                right: 10,
                child: FloatingActionButton(
                  onPressed: () {
                    showWarning(
                        title: S.of(context).favourite_removeAllNewsTitle,
                        description:
                            S.of(context).favourite_removeAllNewsDescription,
                        onRemove: () {
                          _favouriteFeedsBox.clear();
                          context.router.pop();
                        });
                  },
                  child: const Icon(Icons.playlist_remove_rounded),
                )),
          ],
        );
      },
    );
  }

  void showWarning({
    String? title,
    String? description,
    Function()? onRemove,
  }) {
    showAdaptiveDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title ?? ''),
            content: Text(description ?? ''),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  context.router.pop();
                },
                child: const Text('Отмена'),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.red,
                ),
                onPressed: onRemove,
                child: const Text('Удалить'),
              ),
            ],
          );
        });
  }
}
