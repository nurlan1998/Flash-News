import 'package:news_app_flutter/core/data/app_helper.dart';
import 'package:xml/xml.dart';

class RssFeedImageDto {
  final String? title;
  final String? logoUrl;

  const RssFeedImageDto(this.title, this.logoUrl);

  static RssFeedImageDto? parse(XmlElement? element) {
    if (element == null) {
      return null;
    }
    final title = AppHelper.findElementOrNull(element, 'title')?.innerText;
    final logoUrl = AppHelper.findElementOrNull(element, 'url')?.innerText;

    return RssFeedImageDto(title, logoUrl);
  }
}
