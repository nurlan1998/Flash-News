// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ru';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "aboutApp_lastNews":
            MessageLookupByLibrary.simpleMessage("Последние новости"),
        "aboutApp_showWarning": MessageLookupByLibrary.simpleMessage(
            "Язык меняется только для местных новостей"),
        "btnBottomNav_favourite":
            MessageLookupByLibrary.simpleMessage("Избранные"),
        "btnBottomNav_global":
            MessageLookupByLibrary.simpleMessage("Глобальные"),
        "btnBottomNav_local": MessageLookupByLibrary.simpleMessage("Местные"),
        "btnBottomNav_settings":
            MessageLookupByLibrary.simpleMessage("Настройки"),
        "cancel": MessageLookupByLibrary.simpleMessage("Отмена"),
        "favorite_listEmpty":
            MessageLookupByLibrary.simpleMessage("Список пуст"),
        "favourite_removeAllNewsDescription":
            MessageLookupByLibrary.simpleMessage(
                "Вы уверены, что хотите удалить все новости?"),
        "favourite_removeAllNewsTitle": MessageLookupByLibrary.simpleMessage(
            "Вы хотите удалить все новости"),
        "favourite_removeNewsDescription": MessageLookupByLibrary.simpleMessage(
            "Вы уверены, что хотите удалить эту новость?"),
        "favourite_removeNewsTitle":
            MessageLookupByLibrary.simpleMessage("Удалить новость"),
        "remove": MessageLookupByLibrary.simpleMessage("Удалить")
      };
}
