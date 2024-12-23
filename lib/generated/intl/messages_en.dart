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

  static String m0(unit) => "Data (${unit})";

  static String m1(temp) => "Feels like ${temp}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addComplexItem":
            MessageLookupByLibrary.simpleMessage("Add Complex Item"),
        "addItemHeadline": MessageLookupByLibrary.simpleMessage("Add Item"),
        "addRoomHeadline": MessageLookupByLibrary.simpleMessage("Add Room"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "clock": MessageLookupByLibrary.simpleMessage("Clock"),
        "close": MessageLookupByLibrary.simpleMessage("Close"),
        "complex_player_add_item_error":
            MessageLookupByLibrary.simpleMessage("Player Item not found"),
        "confirm": MessageLookupByLibrary.simpleMessage("Confirm"),
        "confirmTriggerRuleAlertText1": MessageLookupByLibrary.simpleMessage(
            "Do you want to trigger the rule"),
        "confirmTriggerRuleAlertText2":
            MessageLookupByLibrary.simpleMessage("now ?"),
        "customLabel": MessageLookupByLibrary.simpleMessage("Custom Label"),
        "customLabelHelp": MessageLookupByLibrary.simpleMessage(
            "Add a custom label for this item otherwise the label from OpenHAB will be used"),
        "data": MessageLookupByLibrary.simpleMessage("Data"),
        "dataWithUnit": m0,
        "date": MessageLookupByLibrary.simpleMessage("Date"),
        "deleteItemDialogHeadline":
            MessageLookupByLibrary.simpleMessage("Delete item?"),
        "deleteItemDialogText": MessageLookupByLibrary.simpleMessage(
            "Do you really want to delete item"),
        "disableWakelockTooltip":
            MessageLookupByLibrary.simpleMessage("Disable Wakelock"),
        "done": MessageLookupByLibrary.simpleMessage("Done"),
        "editItem": MessageLookupByLibrary.simpleMessage("Edit Item"),
        "enableWakelockTooltip":
            MessageLookupByLibrary.simpleMessage("Enable Wakelock"),
        "errorButtonHome": MessageLookupByLibrary.simpleMessage("Go to Home"),
        "errorHeadline":
            MessageLookupByLibrary.simpleMessage("An error occurred"),
        "feelsLike": m1,
        "finish": MessageLookupByLibrary.simpleMessage("Finish"),
        "icon": MessageLookupByLibrary.simpleMessage("Icon"),
        "iconPickerNoResultsText":
            MessageLookupByLibrary.simpleMessage("No results for:"),
        "iconPickerTitle": MessageLookupByLibrary.simpleMessage("Pick an icon"),
        "itemType": MessageLookupByLibrary.simpleMessage("Item Type"),
        "itemTypeAirPressure":
            MessageLookupByLibrary.simpleMessage("Air Pressure"),
        "itemTypeAirQuality":
            MessageLookupByLibrary.simpleMessage("Air Quality"),
        "itemTypeButton": MessageLookupByLibrary.simpleMessage("Switch"),
        "itemTypeCall": MessageLookupByLibrary.simpleMessage("Call"),
        "itemTypeColor": MessageLookupByLibrary.simpleMessage("Color"),
        "itemTypeComplexPlayer":
            MessageLookupByLibrary.simpleMessage("Advanced Player"),
        "itemTypeDateTime":
            MessageLookupByLibrary.simpleMessage("Date and Time"),
        "itemTypeDimmer": MessageLookupByLibrary.simpleMessage("Dimmer"),
        "itemTypeDoorContact":
            MessageLookupByLibrary.simpleMessage("Door Contact"),
        "itemTypeEnergy": MessageLookupByLibrary.simpleMessage("Energy"),
        "itemTypeFan": MessageLookupByLibrary.simpleMessage("Fan"),
        "itemTypeHeater": MessageLookupByLibrary.simpleMessage("Heater"),
        "itemTypeHelp":
            MessageLookupByLibrary.simpleMessage("The type of the item"),
        "itemTypeHumidity": MessageLookupByLibrary.simpleMessage("Humidity"),
        "itemTypeImage": MessageLookupByLibrary.simpleMessage("Image"),
        "itemTypeLight": MessageLookupByLibrary.simpleMessage("Light"),
        "itemTypeLocation": MessageLookupByLibrary.simpleMessage("Location"),
        "itemTypeMotionDetector":
            MessageLookupByLibrary.simpleMessage("Motion Detector"),
        "itemTypeNumber": MessageLookupByLibrary.simpleMessage("Number"),
        "itemTypePlayer": MessageLookupByLibrary.simpleMessage("Player"),
        "itemTypePowerOutlet":
            MessageLookupByLibrary.simpleMessage("Power Outlet"),
        "itemTypePresence": MessageLookupByLibrary.simpleMessage("Presence"),
        "itemTypeRollerShutter":
            MessageLookupByLibrary.simpleMessage("Roller Shutter"),
        "itemTypeSmokeDetector":
            MessageLookupByLibrary.simpleMessage("Smoke Detector"),
        "itemTypeTemperature":
            MessageLookupByLibrary.simpleMessage("Temperature"),
        "itemTypeText": MessageLookupByLibrary.simpleMessage("Text"),
        "itemTypeThermostat":
            MessageLookupByLibrary.simpleMessage("Thermostat"),
        "itemTypeUnknown": MessageLookupByLibrary.simpleMessage("Unknown"),
        "itemTypeWaterDetector":
            MessageLookupByLibrary.simpleMessage("Water Detector"),
        "itemTypeWindowContact":
            MessageLookupByLibrary.simpleMessage("Window Contact"),
        "login": MessageLookupByLibrary.simpleMessage("Login"),
        "loginFailedMessage":
            MessageLookupByLibrary.simpleMessage("Please try again"),
        "loginFailedTitle":
            MessageLookupByLibrary.simpleMessage("Login failed"),
        "loginInfo": MessageLookupByLibrary.simpleMessage(
            "Enter your credentials from myOpenHAB.org"),
        "logout": MessageLookupByLibrary.simpleMessage("Logout"),
        "navigationAutomation":
            MessageLookupByLibrary.simpleMessage("Automation"),
        "navigationFavorites":
            MessageLookupByLibrary.simpleMessage("Favorites"),
        "navigationInbox": MessageLookupByLibrary.simpleMessage("Inbox"),
        "navigationRooms": MessageLookupByLibrary.simpleMessage("Rooms"),
        "navigationSettings": MessageLookupByLibrary.simpleMessage("Settings"),
        "never": MessageLookupByLibrary.simpleMessage("Never"),
        "next": MessageLookupByLibrary.simpleMessage("Next"),
        "password": MessageLookupByLibrary.simpleMessage("Password"),
        "room": MessageLookupByLibrary.simpleMessage("Room"),
        "roomColorLabel": MessageLookupByLibrary.simpleMessage("Color"),
        "roomDescriptionHelp": MessageLookupByLibrary.simpleMessage(
            "Further description of the room"),
        "roomDescriptionLabel":
            MessageLookupByLibrary.simpleMessage("Description"),
        "roomHelp": MessageLookupByLibrary.simpleMessage(
            "The room where the item is located"),
        "roomLevelLabel": MessageLookupByLibrary.simpleMessage("Level"),
        "roomNameHelp":
            MessageLookupByLibrary.simpleMessage("Name of the room"),
        "roomNameHint": MessageLookupByLibrary.simpleMessage("Living Room"),
        "roomNameLabel": MessageLookupByLibrary.simpleMessage("Name"),
        "save": MessageLookupByLibrary.simpleMessage("Save"),
        "search": MessageLookupByLibrary.simpleMessage("Search"),
        "select": MessageLookupByLibrary.simpleMessage("Select"),
        "serverConnectionStateCloud":
            MessageLookupByLibrary.simpleMessage("Cloud"),
        "serverConnectionStateLocal":
            MessageLookupByLibrary.simpleMessage("Local"),
        "serverConnectionStateOffline":
            MessageLookupByLibrary.simpleMessage("Offline"),
        "serverConnectionStateRemote":
            MessageLookupByLibrary.simpleMessage("Remote"),
        "settingsAddApiAccess":
            MessageLookupByLibrary.simpleMessage("Add api access"),
        "settingsAddCloudAccess":
            MessageLookupByLibrary.simpleMessage("Add cloud access"),
        "settingsAddRemoteAccess":
            MessageLookupByLibrary.simpleMessage("Add remote access"),
        "settings_app": MessageLookupByLibrary.simpleMessage("App"),
        "settings_connection":
            MessageLookupByLibrary.simpleMessage("Connection"),
        "settings_connection_start_description":
            MessageLookupByLibrary.simpleMessage(
                "Date and time of the last connection start"),
        "settings_connection_start_title":
            MessageLookupByLibrary.simpleMessage("Start"),
        "settings_connection_status_description":
            MessageLookupByLibrary.simpleMessage(
                "State of the connection to the openHAB server"),
        "settings_connection_status_title":
            MessageLookupByLibrary.simpleMessage("Status"),
        "settings_connection_update_description":
            MessageLookupByLibrary.simpleMessage(
                "Date and time of the last recieved state change"),
        "settings_connection_update_title":
            MessageLookupByLibrary.simpleMessage("Last Update"),
        "settings_theme": MessageLookupByLibrary.simpleMessage("Theme"),
        "settings_wakelock": MessageLookupByLibrary.simpleMessage("Wakelock"),
        "settings_wakelock_description": MessageLookupByLibrary.simpleMessage(
            "Automatically enable wakelock"),
        "themeDark": MessageLookupByLibrary.simpleMessage("Dark"),
        "themeLight": MessageLookupByLibrary.simpleMessage("Light"),
        "themeSystem": MessageLookupByLibrary.simpleMessage("System"),
        "time": MessageLookupByLibrary.simpleMessage("Time"),
        "timeFormat": MessageLookupByLibrary.simpleMessage("Time format"),
        "updateFailedError": MessageLookupByLibrary.simpleMessage(
            "Update failed. Please try again."),
        "username": MessageLookupByLibrary.simpleMessage("Username"),
        "wakelockDisabledSnackbar":
            MessageLookupByLibrary.simpleMessage("Wakelock disabled"),
        "wakelockEnabledSnackbar":
            MessageLookupByLibrary.simpleMessage("Wakelock enabled"),
        "weather": MessageLookupByLibrary.simpleMessage("Weather"),
        "weatherForecast":
            MessageLookupByLibrary.simpleMessage("Weather Forecast")
      };
}
