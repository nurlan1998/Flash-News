import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app_flutter/core/data/logging/log.dart';

import 'core/presentation/app.dart';

void main() async {
  Log.initialize();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Color(0xff0a0a0a),
    systemNavigationBarIconBrightness: Brightness.light,
  ));
  runApp(const App());
}
