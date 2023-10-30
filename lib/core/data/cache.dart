import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart' as hive;
import 'package:news_app_flutter/feature-list/data/dto/rss_feed_category_dto.dart';
import 'package:news_app_flutter/feature-list/data/dto/rss_feed_dto.dart';
import 'package:news_app_flutter/feature-list/data/dto/rss_feed_enclosure_dto.dart';
import 'package:news_app_flutter/feature-list/data/dto/rss_feed_item_dto.dart';

class Cache {
  static Cache? _instance;

  Cache._({
    required this.favourites,
  });

  Box favourites;

  static Future<Cache> initialize() async {
    if (_instance != null) return _instance!;
    await Hive.initFlutter();

    hive.Hive.registerAdapter(RssFeedDtoAdapter());
    hive.Hive.registerAdapter(RssFeedItemDtoAdapter());
    hive.Hive.registerAdapter(RssFeedEnclosureDtoAdapter());
    hive.Hive.registerAdapter(RssFeedCategoryDtoAdapter());
    await openBox<RssFeedDto>();

    await openBox<List>();
    await openBox<bool>();

    _instance = Cache._(
      favourites: await Hive.openBox('favouritesBox'),
    );
    return _instance!;
  }

  static Future<void> openBox<T>() async {
    await Hive.openBox<T>(T.toString());
  }

  static Box<T> box<T>() {
    return Hive.box<T>(T.toString());
  }
}
