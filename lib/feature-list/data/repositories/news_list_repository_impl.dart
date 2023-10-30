import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:news_app_flutter/core/data/app_helper.dart';
import 'package:news_app_flutter/feature-list/data/datasources/news_list_local_data_source.dart';
import 'package:news_app_flutter/feature-list/data/datasources/news_list_remote_data_source.dart';
import 'package:news_app_flutter/feature-list/domain/entities/rss_feed_entity.dart';
import 'package:news_app_flutter/feature-list/domain/repositories/news_list_repository.dart';

import '../dto/rss_feed_dto.dart';

class NewsListRepositoryImpl implements NewsListRepository {
  final NewsListRemoteDataSource remoteDataSource;
  final NewsListLocalDataSource localeDataSource;

  const NewsListRepositoryImpl({
    required this.remoteDataSource,
    required this.localeDataSource,
  });

  @override
  Future<RssFeedEntity> getNewsFromRss({required String url}) async {
    final isOnline = await AppHelper.hasNetwork();
    final String domain = Uri.parse(url).host.split('.').last;
    RssFeedDto response;
    if (!isOnline && RssFeedDto.fromCache(domain) != null) {
      response = localeDataSource.getLastRssData(domain) as RssFeedDto;
    } else {
      response = await remoteDataSource.getNewsFromRss(url: url);
      //final rssFeedCollection = FirebaseFirestore.instance.collection('feeds');
      try {
        //TODO слишком долгий запрос если хранить новости в firebase и доставать их оттуда
        /*final docRef = rssFeedCollection.doc(domain);
        await docRef.set(response.toMap(), SetOptions(merge: true));

        await rssFeedCollection.doc(domain).get().then<dynamic>((DocumentSnapshot snapshot) async {
          Map<String, dynamic> data = jsonDecode(jsonEncode(snapshot.data()));
          response = RssFeedDto.fromJson(data);
        });*/

        localeDataSource.cacheDataFromRss(
          rssDataToCache: response,
          cacheBoxKey: domain,
        );
      } catch (e) {
        print(e);
      }
    }
    return response.toEntity();
  }
}
