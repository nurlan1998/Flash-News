import 'package:flutter/material.dart';
import 'package:news_app_flutter/di/service_locator.dart';

import '../data/cache.dart';
import 'custom_material_app.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    initialize().then((_) {
      setState(() {
        _initialized = true;
      });
    });
  }

  Future<void> initialize() async {
    await ServiceLocator.setup();
  }

  @override
  void dispose() {
   ServiceLocator.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      return Container();
    }
    return CustomMaterialApp();
  }
}
