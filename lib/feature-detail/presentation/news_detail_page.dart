import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:news_app_flutter/core/data/app/application.dart';

import '../../core/presentation/helpers/app_colors.dart';
//import 'package:webview_flutter/webview_flutter.dart';

class NewsDetailPage extends StatefulWidget {
  final String link;
  final String title;

  const NewsDetailPage({
    Key? key,
    required this.link,
    required this.title,
  }) : super(key: key);

  @override
  State<NewsDetailPage> createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  late InAppWebViewController controller;
  bool isLoading = false;

  final List<ContentBlocker> contentBlockers = [];
  final adUrlFilters = [
    ".*.doubleclick.net/.*",
    ".*.ads.pubmatic.com/.*",
    ".*.googlesyndication.com/.*",
    ".*.google-analytics.com/.*",
    ".*.adservice.google.*/.*",
    ".*.adbrite.com/.*",
    ".*.exponential.com/.*",
    ".*.quantserve.com/.*",
    ".*.scorecardresearch.com/.*",
    ".*.zedo.com/.*",
    ".*.adsafeprotected.com/.*",
    ".*.teads.tv/.*",
    ".*.outbrain.com/.*",
    ".*.dahotashkent.uz/.*"
  ];

  @override
  Widget build(BuildContext context) {
    for (final adUrlFilter in adUrlFilters) {
      contentBlockers.add(ContentBlocker(
          trigger: ContentBlockerTrigger(
            urlFilter: adUrlFilter,
          ),
          action: ContentBlockerAction(
            type: ContentBlockerActionType.BLOCK,
          )));
    }

    // apply the "display: none" style to some HTML elements
    contentBlockers.add(ContentBlocker(
        trigger: ContentBlockerTrigger(
          urlFilter: ".*",
        ),
        action: ContentBlockerAction(
            type: ContentBlockerActionType.CSS_DISPLAY_NONE,
            selector: ".banner, .banners, .ads, .ad, .advert")));

    return WillPopScope(
      onWillPop: () async {
        if (await controller.canGoBack()) {
          await controller.goBack();
          return Future.value(false);
        } else {
          return Future.value(true);
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text(widget.title),),
        body: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  InAppWebView(
                    initialSettings: InAppWebViewSettings(
                      contentBlockers: contentBlockers,
                      transparentBackground: true,
                    ),
                    initialUrlRequest: URLRequest(
                      url: WebUri(widget.link),
                      headers: {
                        'Accept-Language': Application.language ?? 'ru',
                      },
                    ),
                    onLoadStart: (controller, url) {
                      setState(() {
                        isLoading = true;
                      });
                    },
                    onLoadStop: (controller, url) {
                      setState(() {
                        isLoading = false;
                      });
                    },
                    onWebViewCreated:
                        (InAppWebViewController webViewController) {
                      controller = webViewController;
                    },
                  ),
                  isLoading
                      ? Container(
                          color: Colors.white,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : const Stack(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
