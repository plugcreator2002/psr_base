// ignore_for_file: implementation_imports

import "dart:async";

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';
import "package:intl/src/intl_helpers.dart";

import "messages_de.dart" as messages_de;
import "messages_en.dart" as messages_en;
import "messages_es.dart" as messages_es;
import "messages_fa.dart" as messages_fa;
import "messages_fr.dart" as messages_fr;
import "messages_it.dart" as messages_it;
import "messages_ja.dart" as messages_ja;
import "messages_messages.dart" as messages_messages;
import "messages_pl.dart" as messages_pl;
import "messages_pt.dart" as messages_pt;
import "messages_sk.dart" as messages_sk;
import "messages_ar.dart" as messages_ar;

typedef LibraryLoader = Future<dynamic> Function();
Map<String, LibraryLoader> _deferredLibraries = {
  "de": () => Future.value(null),
  "en": () => Future.value(null),
  "es": () => Future.value(null),
  "fa": () => Future.value(null),
  "fr": () => Future.value(null),
  "it": () => Future.value(null),
  "ja": () => Future.value(null),
  "messages": () => Future.value(null),
  "pt": () => Future.value(null),
  "sk": () => Future.value(null),
  "pl": () => Future.value(null),
  "ar": () => Future.value(null),
};

MessageLookupByLibrary? _findExact(String localeName) {
  switch (localeName) {
    case "de":
      return messages_de.messages;
    case "en":
      return messages_en.messages;
    case "es":
      return messages_es.messages;
    case "fa":
      return messages_fa.messages;
    case "fr":
      return messages_fr.messages;
    case "it":
      return messages_it.messages;
    case "ja":
      return messages_ja.messages;
    case "messages":
      return messages_messages.messages;
    case "pt":
      return messages_pt.messages;
    case "sk":
      return messages_sk.messages;
    case "pl":
      return messages_pl.messages;
    case "ar":
      return messages_ar.messages;
    default:
      return null;
  }
}

Future<bool> initializeMessages(String localeName) async {
  final availableLocale = Intl.verifiedLocale(
    localeName,
    (locale) => _deferredLibraries[locale] != null,
    onFailure: (_) => null,
  );
  if (availableLocale == null) {
    return Future.value(false);
  }
  final lib = _deferredLibraries[availableLocale];
  await (lib == null ? Future.value(false) : lib());
  initializeInternalMessageLookup(() => CompositeMessageLookup());
  messageLookup.addLocale(availableLocale, _findGeneratedMessagesFor);
  return Future.value(true);
}

bool _messagesExistFor(String locale) {
  try {
    return _findExact(locale) != null;
  } catch (e) {
    return false;
  }
}

MessageLookupByLibrary? _findGeneratedMessagesFor(String locale) {
  var actualLocale = Intl.verifiedLocale(
    locale,
    _messagesExistFor,
    onFailure: (_) => null,
  );
  if (actualLocale == null) return null;
  return _findExact(actualLocale);
}
