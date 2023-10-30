import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:news_app_flutter/core/data/app/application.dart';
import 'package:news_app_flutter/core/data/theme/theme_mode_helper.dart';
import 'package:news_app_flutter/core/presentation/helpers/app_colors.dart';
import 'package:news_app_flutter/generated/l10n.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  PackageInfo? packageInfo;

  List<dynamic> languages = [
    {'title': 'Русский', 'code': 'ru'},
    {'title': 'Узбекча', 'code': 'uz'},
    {'title': 'English', 'code': 'en'}
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final packageInfo = await PackageInfo.fromPlatform();
      setState(() {
        this.packageInfo = packageInfo;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: <Widget>[
                const CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.transparent,
                  backgroundImage: ExactAssetImage('assets/flash_on.png'),
                ),
                const SizedBox(height: 8.0),
                const Text(
                  'Flash News',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8.0),
                if (packageInfo != null)
                  Text(
                    '${Platform.isAndroid ? 'Android' : 'iOS'}: ${packageInfo?.version} - ${packageInfo?.buildNumber}',
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                const SizedBox(height: 8.0),
                Text('${S.of(context).aboutApp_lastNews} - RU UZ'),
                const SizedBox(height: 25.0),
                ListTile(
                  tileColor:
                      ThemeModeHelper.isDark ? AppColors.black800 : Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                  leading: const Icon(
                    Icons.language,
                    color: Colors.blue,
                  ),
                  title: Text(
                    languages.firstWhere((element) =>
                            element['code'] ==
                            (Application.language ?? 'ru'))['title'] ??
                        'Язык в приложений',
                  ),
                  trailing: const Icon(Icons.keyboard_arrow_right),
                  onTap: showLanguageSwitcher,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showLanguageSwitcher() {
    showModalBottomSheet(
      context: context,
      backgroundColor:
          ThemeModeHelper.isDark ? AppColors.black800 : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.8,
          child: Column(
            children: [
              ListView(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                primary: false,
                shrinkWrap: true,
                children: languages.map((dynamic language) {
                  return ListTile(
                    title: Text(language['title']),
                    trailing: const Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      setState(() {
                        Application.onAppLanguageChanged
                            ?.call(language['code']);
                      });
                      context.router.pop();
                    },
                  );
                }).toList(),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  S.of(context).aboutApp_showWarning,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
