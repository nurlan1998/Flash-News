import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:news_app_flutter/core/data/theme/theme_mode_helper.dart';

class ThemeModeSwitcher extends StatefulWidget {
  const ThemeModeSwitcher({Key? key}) : super(key: key);

  @override
  _ThemeModeSwitcherState createState() => _ThemeModeSwitcherState();
}

class _ThemeModeSwitcherState extends State<ThemeModeSwitcher>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      value: ThemeModeHelper.themeMode == ThemeMode.dark ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 800),
    );

    ThemeModeHelper.notifier.addListener(_onThemeModeChanged);
  }

  @override
  void dispose() {
    ThemeModeHelper.notifier.removeListener(_onThemeModeChanged);
    _controller.dispose();
    super.dispose();
  }

  void _onThemeModeChanged() {
    if (ThemeModeHelper.themeMode == ThemeMode.dark) {
      _controller.forward(from: 0.0);
    } else {
      _controller.reverse(from: 1.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ThemeModeHelper.changeToOpposite,
      child: Lottie.asset(
        'assets/lottie/dark-light-mode.json',
        controller: _controller,
      ),
    );
  }
}