import 'package:news_app_flutter/feature-list/data/dto/rss_feed_category_dto.dart';
import 'package:news_app_flutter/feature-list/data/dto/rss_feed_dto.dart';
import 'package:news_app_flutter/feature-list/data/dto/rss_feed_enclosure_dto.dart';
import 'package:news_app_flutter/feature-list/data/dto/rss_feed_item_dto.dart';

const testRssFeedDto = RssFeedDto(
    title: 'UzNews - Новости Узбекистана',
    author: 'Uznews.uz',
    description: 'Новостной сайт Узбекистана',
    link: 'https://uznews.uz/',
    language: 'ru',
    items: [
      RssFeedItemDto(
        title:
            'Бизнес-тренер, обещавший научить зарабатывать в месяц 10 тыс., объявлен в розыск — видео',
        description:
            '27-летний Ислом Иброхимов получил известность после публикации мотивационных видеороликов на YouTube.',
        link: 'https://uznews.uz/posts/68895/',
        pubDate: 'Thu, 26 Oct 23 10:24:31 +0530',
        author: 'Uznews.uz',
        enclosure: RssFeedEnclosureDto(
          url:
              'https://api.uznews.uz/storage/uploads/posts/images/68895/sYgxqWQ2Sk.jpg',
          type: 'image/jpeg',
          length: 0
        ),
        guid: '68895',
      )
    ]
);
