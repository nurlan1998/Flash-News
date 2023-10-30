import 'dart:io';

import 'package:uuid/uuid.dart';
import 'package:xml/xml.dart';

class AppHelper {
  AppHelper._();

  static Future<bool> hasNetwork() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  static XmlElement? findElementOrNull(XmlElement element, String name,
      {String? namespace}) {
    try {
      return element.findAllElements(name, namespace: namespace).first;
    } on StateError {
      return null;
    }
  }

  static String getRandomUuid({int length = 9}) {
    const uuid = Uuid();
    return uuid.v1().replaceAll('-', '').substring(0, length);
  }
}