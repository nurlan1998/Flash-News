import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:news_app_flutter/feature-list/domain/entities/rss_feed_enclosure_entity.dart';
import 'package:xml/xml.dart';

part 'rss_feed_enclosure_dto.g.dart';

@HiveType(typeId: 3)
class RssFeedEnclosureDto extends Equatable {
  @HiveField(0)
  final String? url;
  @HiveField(1)
  final String? type;
  @HiveField(2)
  final int? length;

  const RssFeedEnclosureDto({this.url, this.type, this.length});

  factory RssFeedEnclosureDto.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return RssFeedEnclosureDto(
      url: data?['url'],
      type: data?['type'],
      length: data?['length'],
    );
  }

  factory RssFeedEnclosureDto.fromJson(Map<String, dynamic> json) =>
      RssFeedEnclosureDto(
        url: json["url"],
        type: json["type"],
        // length: json["length"],
      );

  static RssFeedEnclosureDto? parse(XmlElement? element) {
    if (element == null) {
      return null;
    }
    final url = element.getAttribute('url');
    final type = element.getAttribute('type');
    final length = int.tryParse(element.getAttribute('length') ?? '0') ?? 0;
    return RssFeedEnclosureDto(url: url, type: type, length: length);
  }

  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'type': type,
    };
  }

  @override
  List<Object?> get props => [url,type,length];
}

extension RssEnclosureMapper on RssFeedEnclosureDto {
  RssFeedEnclosureEntity toEntity() {
    return RssFeedEnclosureEntity(url: url);
  }
}
