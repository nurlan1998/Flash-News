import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:news_app_flutter/core/data/cache.dart';
import 'package:news_app_flutter/core/presentation/helpers/app_colors.dart';
import 'package:news_app_flutter/core/presentation/view/settings_page.dart';
import 'package:news_app_flutter/core/presentation/widgets/empty_app_bar.dart';
import 'package:news_app_flutter/core/presentation/widgets/page_wrapper.dart';
import 'package:news_app_flutter/core/presentation/widgets/theme_mode_switcher.dart';
import 'package:news_app_flutter/feature-list/presentation/view/rss_favorite_feed_page.dart';
import 'package:news_app_flutter/feature-list/presentation/view/rss_global_feed_page.dart';
import 'package:news_app_flutter/feature-list/presentation/view/rss_domestic_feed_page.dart';
import 'package:news_app_flutter/generated/l10n.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const PageWrapper(
      title: Row(
        children: <Widget>[
          CircleAvatar(
            radius: 16,
            backgroundColor: Colors.transparent,
            backgroundImage: ExactAssetImage('assets/flash_on.png'),
          ),
          SizedBox(width: 4.0),
          Text('Flash News'),
        ],
      ),
      actions: [ThemeModeSwitcher()],
      child: _InnerPage(),
    );
  }
}

class _InnerPage extends StatefulWidget {
  const _InnerPage({Key? key}) : super(key: key);

  @override
  State<_InnerPage> createState() => __InnerPageState();
}

class __InnerPageState extends State<_InnerPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  final ValueNotifier<int> _activeTab = ValueNotifier(0);

  void changeTab(int index) {
    tabController.animateTo(index);
    _activeTab.value = index;
  }

  @override
  void dispose() {
    tabController.dispose();
    _activeTab.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    tabController = TabController(
      vsync: this,
      length: 4,
      initialIndex: 0,
    );

    tabController.addListener(() {
      if (_activeTab.value != tabController.index) {
        _activeTab.value = tabController.index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const EmptyAppBar(),
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: _activeTab,
        builder: (context, int tab, child) => BottomNavigation(
          currentIndex: tab,
          onTabPressed: changeTab,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 2.0),
        child: TabBarView(
          controller: tabController,
          children: const <Widget>[
            RssGlobalFeedPage(),
            RssDomesticFeedPage(),
            RssFavoriteFeedPage(),
            SettingsPage(),
          ],
        ),
      ),
    );
  }
}

class BottomNavigation extends StatelessWidget {
  final int? currentIndex;
  final Function(int)? onTabPressed;

  const BottomNavigation({
    Key? key,
    this.currentIndex,
    this.onTabPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      useLegacyColorScheme: true,
      type: BottomNavigationBarType.fixed,
      //unselectedItemColor: Colors.grey[600],
      //selectedItemColor: AppColors.primary,
      showUnselectedLabels: true,
      onTap: (int index) {
        onTabPressed!(index);
      },
      currentIndex: currentIndex ?? 0,
      elevation: 8.0,
      items: [
        BottomNavigationBarItem(
          icon: const Icon(FontAwesomeIcons.globe),
          label: S.of(context).btnBottomNav_global,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.local_library_sharp),
          label: S.of(context).btnBottomNav_local,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.favorite),
          label: S.of(context).btnBottomNav_favourite,
        ),
        BottomNavigationBarItem(
          icon: const Icon(
            Icons.settings,
          ),
          label: S.of(context).btnBottomNav_settings,
        ),
      ],
    );
  }
}
