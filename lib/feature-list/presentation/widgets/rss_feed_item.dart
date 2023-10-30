import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:news_app_flutter/core/data/app/application.dart';
import 'package:news_app_flutter/core/data/cache.dart';
import 'package:news_app_flutter/di/service_locator.dart';
import 'package:news_app_flutter/feature-list/domain/entities/rss_feed_enclosure_entity.dart';
import 'package:news_app_flutter/feature-list/domain/entities/rss_feed_item_entity.dart';
import 'package:intl/intl.dart';

class RssFeedItem extends StatelessWidget {
  final RssFeedItemEntity rssItemEntity;
  final RssFeedEnclosureEntity? rssEnclosureEntity;
  final Function()? onTapFavourite;
  final bool isFavorite;

  const RssFeedItem({
    Key? key,
    required this.rssItemEntity,
    required this.rssEnclosureEntity,
    this.onTapFavourite,
    this.isFavorite = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white.withOpacity(0.15),
              Colors.white.withOpacity(0.05),
            ]
          ),
          image: rssEnclosureEntity?.url != null
              ? DecorationImage(
                  image: CachedNetworkImageProvider(rssEnclosureEntity!.url!),
                  fit: BoxFit.fill,
                )
              : null),
      height: rssEnclosureEntity?.url != null ? 200 : 70,
      child: Stack(
        children: [
          // Align(
          //   alignment: Alignment.topRight,
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Image.network('https://lenta.ru/images/small_logo.png',width: 50,height: 50,),
          //   ),
          // ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 60,
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: rssEnclosureEntity?.url != null
                          ? Colors.grey.withOpacity(0.75)
                          : Colors.transparent,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Text(
                              rssItemEntity.title ?? '',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: rssEnclosureEntity?.url != null
                                      ? Colors.white
                                      : null),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Text(
                            rssItemEntity.pubDate ?? '',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: rssEnclosureEntity?.url != null
                                    ? Colors.white
                                    : null),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: onTapFavourite,
                      icon: isFavorite
                          ? const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            )
                          : Icon(
                              Icons.favorite_border,
                              color: rssEnclosureEntity?.url != null
                                  ? Colors.white
                                  : null,
                            ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
