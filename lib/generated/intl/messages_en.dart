// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "close": MessageLookupByLibrary.simpleMessage("Close"),
        "customLabel": MessageLookupByLibrary.simpleMessage("Custom Label"),
        "customLabelHelp": MessageLookupByLibrary.simpleMessage(
            "Add a custom label for this item otherwise the label from OpenHAB will be used."),
        "errorButtonHome": MessageLookupByLibrary.simpleMessage("Go to Home"),
        "errorHeadline":
            MessageLookupByLibrary.simpleMessage("An error occured"),
        "icon": MessageLookupByLibrary.simpleMessage("Icon"),
        "iconPickerNoResultsText":
            MessageLookupByLibrary.simpleMessage("No results for:"),
        "iconPickerTitle": MessageLookupByLibrary.simpleMessage("Pick an icon"),
        "itemIconHelp": MessageLookupByLibrary.simpleMessage(
            "Add an icon to the item that describes its functionality."),
        "itemType": MessageLookupByLibrary.simpleMessage("Item Type"),
        "itemTypeHelp":
            MessageLookupByLibrary.simpleMessage("The type of the item"),
        "login": MessageLookupByLibrary.simpleMessage("Login"),
        "loginFailedMessage":
            MessageLookupByLibrary.simpleMessage("Please try again"),
        "loginFailedTitle":
            MessageLookupByLibrary.simpleMessage("Login failed"),
        "navigationFavorites":
            MessageLookupByLibrary.simpleMessage("Favorites"),
        "navigationInbox": MessageLookupByLibrary.simpleMessage("Inbox"),
        "navigationRooms": MessageLookupByLibrary.simpleMessage("Rooms"),
        "password": MessageLookupByLibrary.simpleMessage("Password"),
        "room": MessageLookupByLibrary.simpleMessage("Room"),
        "roomHelp": MessageLookupByLibrary.simpleMessage(
            "The room where the item is located"),
        "search": MessageLookupByLibrary.simpleMessage("Search"),
        "select": MessageLookupByLibrary.simpleMessage("Select"),
        "username": MessageLookupByLibrary.simpleMessage("Username")
      };
}
