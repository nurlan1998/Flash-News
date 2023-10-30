import 'package:hive/hive.dart';
import 'package:xml/xml.dart';

part 'rss_feed_category_dto.g.dart';

@HiveType(typeId: 4)
class RssFeedCategoryDto {
  @HiveField(0)
  final String? domain;
  @HiveField(1)
  final String? value;

  const RssFeedCategoryDto({
    this.domain,
    this.value,
  });

  factory RssFeedCategoryDto.fromJson(Map<String, dynamic> json) =>
      RssFeedCategoryDto(
        domain: json["domain"],
        value: json["value"],
      );

  factory RssFeedCategoryDto.parse(XmlElement element) {
    final domain = element.getAttribute('domain');
    final value = element.innerText;
    return RssFeedCategoryDto(domain: domain, value: value);
  }
}
