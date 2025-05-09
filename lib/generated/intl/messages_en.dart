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

  static String m0(itemName) => "Automations with ${itemName}";

  static String m1(minute) => "at minute ${minute}";

  static String m2(minutesRange, minutesLast) =>
      "at minutes ${minutesRange} and ${minutesLast}";

  static String m3(month) => "at month ${month}";

  static String m4(monthsRange, monthsLast) =>
      "at months ${monthsRange} and ${monthsLast}";

  static String m5(seconds) => "at second ${seconds}";

  static String m6(secondsRange, secondsLast) =>
      "at seconds ${secondsRange} and \$${secondsLast}";

  static String m7(betweenStartYear, betweenEndYear) =>
      "between ${betweenStartYear} and ${betweenEndYear}";

  static String m8(everyDay) => "every ${everyDay} days";

  static String m9(everyDay, startDay) =>
      "every ${everyDay} days starting on the ${startDay}";

  static String m10(everyDay, startDay) =>
      "every ${everyDay} days starting on the ${startDay}";

  static String m11(everyMinute, startMinute) =>
      "every ${everyMinute} minutes starting at ${startMinute}";

  static String m12(everyMonth, startMonth) =>
      "every ${everyMonth} months starting at ${startMonth}";

  static String m13(everySecond, startSecond) =>
      "every ${everySecond} seconds starting at ${startSecond}";

  static String m14(everyYear, startYear) =>
      "every ${everyYear} years starting in ${startYear}";

  static String m15(betweenStartMinute, betweenEndMinute) =>
      "every minute between ${betweenStartMinute} and ${betweenEndMinute}";

  static String m16(everyMinute) => "every ${everyMinute} minutes";

  static String m17(betweenStartMonth, betweenEndMonth) =>
      "every month between ${betweenStartMonth} and ${betweenEndMonth}";

  static String m18(everyMonth) => "every ${everyMonth} months";

  static String m19(betweenStartSecond, betweenEndSecond) =>
      "every second between ${betweenStartSecond} and ${betweenEndSecond}";

  static String m20(everySecond) => "every ${everySecond} seconds";

  static String m21(year) => "in ${year}";

  static String m22(yearsRange, yearsLast) =>
      "in ${yearsRange} and ${yearsLast}";

  static String m23(day) => "on the ${day} day";

  static String m24(dayBefore) =>
      "${dayBefore} days before the end of the month";

  static String m25(daysRange, lastDay) =>
      "on the ${daysRange} and ${lastDay} day";

  static String m26(lastDay) => "on the ${lastDay} day of the month";

  static String m27(lastDay) => "the last ${lastDay} of the month";

  static String m28(nearestWeekday) =>
      "on the nearest weekday to the ${nearestWeekday} of the month";

  static String m29(weekday) => "on the ${weekday}";

  static String m30(weekdaysRange, lastWeekday) =>
      "on the ${weekdaysRange} and ${lastWeekday}";

  static String m31(xthWeek, weekday) =>
      "on the ${xthWeek} ${weekday} of the month";

  static String m32(startYear) => "starting in ${startYear}";

  static String m33(unit) => "Data (${unit})";

  static String m34(temp) => "Feels like ${temp}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "actions": MessageLookupByLibrary.simpleMessage("Actions"),
    "addAnItemFirst": MessageLookupByLibrary.simpleMessage("Add an item first"),
    "addAutomation": MessageLookupByLibrary.simpleMessage("Add Automation"),
    "addComplexItem": MessageLookupByLibrary.simpleMessage("Add Complex Item"),
    "addItem": MessageLookupByLibrary.simpleMessage("Add Item"),
    "addItemAction": MessageLookupByLibrary.simpleMessage("Add Item Action"),
    "addItemHeadline": MessageLookupByLibrary.simpleMessage("Add Item"),
    "addRoomHeadline": MessageLookupByLibrary.simpleMessage("Add Room"),
    "addTrigger": MessageLookupByLibrary.simpleMessage("Add Trigger"),
    "and": MessageLookupByLibrary.simpleMessage("And"),
    "automations": MessageLookupByLibrary.simpleMessage("Automations"),
    "automationsWith": m0,
    "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "clock": MessageLookupByLibrary.simpleMessage("Clock"),
    "close": MessageLookupByLibrary.simpleMessage("Close"),
    "color": MessageLookupByLibrary.simpleMessage("Color"),
    "complex_player_add_item_error": MessageLookupByLibrary.simpleMessage(
      "Player Item not found",
    ),
    "confirm": MessageLookupByLibrary.simpleMessage("Confirm"),
    "confirmDeleteRuleAlertText": MessageLookupByLibrary.simpleMessage(
      "Do you really want to delete the rule",
    ),
    "confirmTriggerRuleAlertText1": MessageLookupByLibrary.simpleMessage(
      "Do you want to trigger the rule",
    ),
    "confirmTriggerRuleAlertText2": MessageLookupByLibrary.simpleMessage(
      "now ?",
    ),
    "couldNotAddTrigger": MessageLookupByLibrary.simpleMessage(
      "Could not add trigger",
    ),
    "cronAtMinute": m1,
    "cronAtMinutesAnd": m2,
    "cronAtMonth": m3,
    "cronAtMonthsAnd": m4,
    "cronAtSecond": m5,
    "cronAtSecondsAnd": m6,
    "cronBetweenYears": m7,
    "cronEveryDay": m8,
    "cronEveryDayInWeekStartingOn": m9,
    "cronEveryDayStartingOn": m10,
    "cronEveryEveryMinutesStartingAt": m11,
    "cronEveryEveryMonthsStartingAt": m12,
    "cronEveryEverySecondsStartingAt": m13,
    "cronEveryEveryYearsStartingAt": m14,
    "cronEveryMinute": MessageLookupByLibrary.simpleMessage("every minute"),
    "cronEveryMinuteBetweenAnd": m15,
    "cronEveryMinutes": m16,
    "cronEveryMonth": MessageLookupByLibrary.simpleMessage("every month"),
    "cronEveryMonthBetweenAnd": m17,
    "cronEveryMonths": m18,
    "cronEverySecond": MessageLookupByLibrary.simpleMessage("every second"),
    "cronEverySecondBetweenAnd": m19,
    "cronEverySeconds": m20,
    "cronEveryWeek": MessageLookupByLibrary.simpleMessage("every week"),
    "cronEveryYear": MessageLookupByLibrary.simpleMessage("every year"),
    "cronFifthWeek": MessageLookupByLibrary.simpleMessage("FIFTH"),
    "cronFirstWeek": MessageLookupByLibrary.simpleMessage("FIRST"),
    "cronFourthWeek": MessageLookupByLibrary.simpleMessage("FOURTH"),
    "cronInYear": m21,
    "cronInYearsAnd": m22,
    "cronOnDay": m23,
    "cronOnDayBeforeEndOfMonth": m24,
    "cronOnDaysAnd": m25,
    "cronOnLastDayOfMonth": m26,
    "cronOnLastWeekdayOfMonth": MessageLookupByLibrary.simpleMessage(
      "on the last weekday of the month",
    ),
    "cronOnLastXDayOfMonth": m27,
    "cronOnNearestWeekdayOfMonth": m28,
    "cronOnWeekday": m29,
    "cronOnWeekdaysAnd": m30,
    "cronOnXthWeekdayOfMonth": m31,
    "cronSecondWeek": MessageLookupByLibrary.simpleMessage("SECOND"),
    "cronStartingInYear": m32,
    "cronThirdWeek": MessageLookupByLibrary.simpleMessage("THIRD"),
    "customLabel": MessageLookupByLibrary.simpleMessage("Custom Label"),
    "customLabelHelp": MessageLookupByLibrary.simpleMessage(
      "Add a custom label for this item otherwise the label from OpenHAB will be used",
    ),
    "data": MessageLookupByLibrary.simpleMessage("Data"),
    "dataWithUnit": m33,
    "date": MessageLookupByLibrary.simpleMessage("Date"),
    "delete": MessageLookupByLibrary.simpleMessage("Delete"),
    "deleteItemDialogHeadline": MessageLookupByLibrary.simpleMessage(
      "Delete item?",
    ),
    "deleteItemDialogText": MessageLookupByLibrary.simpleMessage(
      "Do you really want to delete item",
    ),
    "deletedRuleFailure": MessageLookupByLibrary.simpleMessage(
      "Failed to delete the rule",
    ),
    "deletedRuleSuccess": MessageLookupByLibrary.simpleMessage(
      "Successfully deleted the rule",
    ),
    "disableWallMoundModeTooltip": MessageLookupByLibrary.simpleMessage(
      "Disable Wall Mount Mode",
    ),
    "done": MessageLookupByLibrary.simpleMessage("Done"),
    "down": MessageLookupByLibrary.simpleMessage("Down"),
    "editItem": MessageLookupByLibrary.simpleMessage("Edit Item"),
    "editRule": MessageLookupByLibrary.simpleMessage("Edit Rule"),
    "enableWallMountModeTooltip": MessageLookupByLibrary.simpleMessage(
      "Enable Wall Mount Mode",
    ),
    "errorButtonHome": MessageLookupByLibrary.simpleMessage("Go to Home"),
    "errorHeadline": MessageLookupByLibrary.simpleMessage("An error occurred"),
    "feelsLike": m34,
    "finish": MessageLookupByLibrary.simpleMessage("Finish"),
    "icon": MessageLookupByLibrary.simpleMessage("Icon"),
    "iconPickerNoResultsText": MessageLookupByLibrary.simpleMessage(
      "No results for:",
    ),
    "iconPickerTitle": MessageLookupByLibrary.simpleMessage("Pick an icon"),
    "itemAction": MessageLookupByLibrary.simpleMessage("Item Action"),
    "itemType": MessageLookupByLibrary.simpleMessage("Item Type"),
    "itemTypeAirPressure": MessageLookupByLibrary.simpleMessage("Air Pressure"),
    "itemTypeAirQuality": MessageLookupByLibrary.simpleMessage("Air Quality"),
    "itemTypeButton": MessageLookupByLibrary.simpleMessage("Switch"),
    "itemTypeCall": MessageLookupByLibrary.simpleMessage("Call"),
    "itemTypeColor": MessageLookupByLibrary.simpleMessage("Color"),
    "itemTypeComplexPlayer": MessageLookupByLibrary.simpleMessage(
      "Advanced Player",
    ),
    "itemTypeDateTime": MessageLookupByLibrary.simpleMessage("Date and Time"),
    "itemTypeDimmer": MessageLookupByLibrary.simpleMessage("Dimmer"),
    "itemTypeDoorContact": MessageLookupByLibrary.simpleMessage("Door Contact"),
    "itemTypeEnergy": MessageLookupByLibrary.simpleMessage("Energy"),
    "itemTypeFan": MessageLookupByLibrary.simpleMessage("Fan"),
    "itemTypeHeater": MessageLookupByLibrary.simpleMessage("Heater"),
    "itemTypeHelp": MessageLookupByLibrary.simpleMessage(
      "The type of the item",
    ),
    "itemTypeHumidity": MessageLookupByLibrary.simpleMessage("Humidity"),
    "itemTypeImage": MessageLookupByLibrary.simpleMessage("Image"),
    "itemTypeLight": MessageLookupByLibrary.simpleMessage("Light"),
    "itemTypeLocation": MessageLookupByLibrary.simpleMessage("Location"),
    "itemTypeMotionDetector": MessageLookupByLibrary.simpleMessage(
      "Motion Detector",
    ),
    "itemTypeNumber": MessageLookupByLibrary.simpleMessage("Number"),
    "itemTypePlayer": MessageLookupByLibrary.simpleMessage("Player"),
    "itemTypePowerOutlet": MessageLookupByLibrary.simpleMessage("Power Outlet"),
    "itemTypePresence": MessageLookupByLibrary.simpleMessage("Presence"),
    "itemTypeRollerShutter": MessageLookupByLibrary.simpleMessage(
      "Roller Shutter",
    ),
    "itemTypeSmokeDetector": MessageLookupByLibrary.simpleMessage(
      "Smoke Detector",
    ),
    "itemTypeTemperature": MessageLookupByLibrary.simpleMessage("Temperature"),
    "itemTypeText": MessageLookupByLibrary.simpleMessage("Text"),
    "itemTypeThermostat": MessageLookupByLibrary.simpleMessage("Thermostat"),
    "itemTypeUnknown": MessageLookupByLibrary.simpleMessage("Unknown"),
    "itemTypeWaterDetector": MessageLookupByLibrary.simpleMessage(
      "Water Detector",
    ),
    "itemTypeWindowContact": MessageLookupByLibrary.simpleMessage(
      "Window Contact",
    ),
    "licences": MessageLookupByLibrary.simpleMessage("Licences"),
    "localeName": MessageLookupByLibrary.simpleMessage("en"),
    "login": MessageLookupByLibrary.simpleMessage("Login"),
    "loginFailedMessage": MessageLookupByLibrary.simpleMessage(
      "Please try again",
    ),
    "loginFailedTitle": MessageLookupByLibrary.simpleMessage("Login failed"),
    "loginInfo": MessageLookupByLibrary.simpleMessage(
      "Enter your credentials from myOpenHAB.org",
    ),
    "logout": MessageLookupByLibrary.simpleMessage("Logout"),
    "navigationAutomation": MessageLookupByLibrary.simpleMessage("Automation"),
    "navigationFavorites": MessageLookupByLibrary.simpleMessage("Favorites"),
    "navigationInbox": MessageLookupByLibrary.simpleMessage("Inbox"),
    "navigationRooms": MessageLookupByLibrary.simpleMessage("Rooms"),
    "navigationSettings": MessageLookupByLibrary.simpleMessage("Settings"),
    "never": MessageLookupByLibrary.simpleMessage("Never"),
    "newRule": MessageLookupByLibrary.simpleMessage("New Rule"),
    "next": MessageLookupByLibrary.simpleMessage("Next"),
    "noRulesFound": MessageLookupByLibrary.simpleMessage("No rules found"),
    "off": MessageLookupByLibrary.simpleMessage("Off"),
    "on": MessageLookupByLibrary.simpleMessage("On"),
    "options": MessageLookupByLibrary.simpleMessage("Options"),
    "or": MessageLookupByLibrary.simpleMessage("Or"),
    "password": MessageLookupByLibrary.simpleMessage("Password"),
    "postUpdateCommandLabel": MessageLookupByLibrary.simpleMessage(
      "Post Update",
    ),
    "recentColors": MessageLookupByLibrary.simpleMessage("Recent Colors"),
    "room": MessageLookupByLibrary.simpleMessage("Room"),
    "roomColorLabel": MessageLookupByLibrary.simpleMessage("Color"),
    "roomDescriptionHelp": MessageLookupByLibrary.simpleMessage(
      "Further description of the room",
    ),
    "roomDescriptionLabel": MessageLookupByLibrary.simpleMessage("Description"),
    "roomHelp": MessageLookupByLibrary.simpleMessage(
      "The room where the item is located",
    ),
    "roomLevelLabel": MessageLookupByLibrary.simpleMessage("Level"),
    "roomNameHelp": MessageLookupByLibrary.simpleMessage("Name of the room"),
    "roomNameHint": MessageLookupByLibrary.simpleMessage("Living Room"),
    "roomNameLabel": MessageLookupByLibrary.simpleMessage("Name"),
    "ruleAutoDeleteHint": MessageLookupByLibrary.simpleMessage(
      "Automatically delete the rule after it is triggered. Requires that all triggers are time based and refer to a concrete date.",
    ),
    "ruleAutoDeleteTitle": MessageLookupByLibrary.simpleMessage("Auto delete"),
    "ruleName": MessageLookupByLibrary.simpleMessage("Rule name"),
    "ruleTypeRepeating": MessageLookupByLibrary.simpleMessage("Repeating"),
    "ruleTypeScheduled": MessageLookupByLibrary.simpleMessage("Scheduled"),
    "run": MessageLookupByLibrary.simpleMessage("Run"),
    "save": MessageLookupByLibrary.simpleMessage("Save"),
    "script": MessageLookupByLibrary.simpleMessage("Script"),
    "search": MessageLookupByLibrary.simpleMessage("Search"),
    "select": MessageLookupByLibrary.simpleMessage("Select"),
    "selectActionType": MessageLookupByLibrary.simpleMessage(
      "Select Action Type",
    ),
    "selectItem": MessageLookupByLibrary.simpleMessage("Select Item"),
    "sendCommandCommandLabel": MessageLookupByLibrary.simpleMessage(
      "Send Command",
    ),
    "serverConnectionStateCloud": MessageLookupByLibrary.simpleMessage("Cloud"),
    "serverConnectionStateLocal": MessageLookupByLibrary.simpleMessage("Local"),
    "serverConnectionStateOffline": MessageLookupByLibrary.simpleMessage(
      "Offline",
    ),
    "serverConnectionStateRemote": MessageLookupByLibrary.simpleMessage(
      "Remote",
    ),
    "settingsAddApiAccess": MessageLookupByLibrary.simpleMessage(
      "Add api access",
    ),
    "settingsAddCloudAccess": MessageLookupByLibrary.simpleMessage(
      "Add cloud access",
    ),
    "settingsAddRemoteAccess": MessageLookupByLibrary.simpleMessage(
      "Add remote access",
    ),
    "settings_app": MessageLookupByLibrary.simpleMessage("App"),
    "settings_connection": MessageLookupByLibrary.simpleMessage("Connection"),
    "settings_connection_start_description":
        MessageLookupByLibrary.simpleMessage(
          "Date and time of the last connection start",
        ),
    "settings_connection_start_title": MessageLookupByLibrary.simpleMessage(
      "Start",
    ),
    "settings_connection_status_description":
        MessageLookupByLibrary.simpleMessage(
          "State of the connection to the openHAB server",
        ),
    "settings_connection_status_title": MessageLookupByLibrary.simpleMessage(
      "Status",
    ),
    "settings_connection_update_description":
        MessageLookupByLibrary.simpleMessage(
          "Date and time of the last recieved state change",
        ),
    "settings_connection_update_title": MessageLookupByLibrary.simpleMessage(
      "Last Update",
    ),
    "settings_theme": MessageLookupByLibrary.simpleMessage("Theme"),
    "settings_wall_mount_mode": MessageLookupByLibrary.simpleMessage(
      "Wall Mount Mode",
    ),
    "settings_wall_mount_mode_description": MessageLookupByLibrary.simpleMessage(
      "Automatically enable wall mount mode. App bars and navigation bars will be hidden and the screen is kept on.",
    ),
    "sliderCurrentHint": MessageLookupByLibrary.simpleMessage("current"),
    "sliderMaxHint": MessageLookupByLibrary.simpleMessage("max"),
    "sliderMinHint": MessageLookupByLibrary.simpleMessage("min"),
    "stop": MessageLookupByLibrary.simpleMessage("Stop"),
    "systemStartTrigger100": MessageLookupByLibrary.simpleMessage(
      "100 - Startup complete",
    ),
    "systemStartTrigger40": MessageLookupByLibrary.simpleMessage(
      "40 - Rules loaded",
    ),
    "systemStartTrigger50": MessageLookupByLibrary.simpleMessage(
      "50 - Rule engine started",
    ),
    "systemStartTrigger70": MessageLookupByLibrary.simpleMessage(
      "70 - User interfaces started",
    ),
    "systemStartTrigger80": MessageLookupByLibrary.simpleMessage(
      "80 - Things initialized",
    ),
    "themeDark": MessageLookupByLibrary.simpleMessage("Dark"),
    "themeLight": MessageLookupByLibrary.simpleMessage("Light"),
    "themeSystem": MessageLookupByLibrary.simpleMessage("System"),
    "time": MessageLookupByLibrary.simpleMessage("Time"),
    "timeFormat": MessageLookupByLibrary.simpleMessage("Time format"),
    "timeTriggerIn10Min": MessageLookupByLibrary.simpleMessage("in 10 min"),
    "timeTriggerIn12H": MessageLookupByLibrary.simpleMessage("in 12 h"),
    "timeTriggerIn1Day": MessageLookupByLibrary.simpleMessage("in 1 day"),
    "timeTriggerIn1H": MessageLookupByLibrary.simpleMessage("in 1 h"),
    "timeTriggerIn1Min": MessageLookupByLibrary.simpleMessage("in 1 min"),
    "timeTriggerIn2Days": MessageLookupByLibrary.simpleMessage("in 2 days"),
    "timeTriggerIn2H": MessageLookupByLibrary.simpleMessage("in 2 h"),
    "timeTriggerIn30Min": MessageLookupByLibrary.simpleMessage("in 30 min"),
    "timeTriggerIn5Min": MessageLookupByLibrary.simpleMessage("in 5 min"),
    "triggered_rule_failure": MessageLookupByLibrary.simpleMessage(
      "Failed to trigger the rule",
    ),
    "triggered_rule_success": MessageLookupByLibrary.simpleMessage(
      "Successfully triggered the rule",
    ),
    "triggers": MessageLookupByLibrary.simpleMessage("Triggers"),
    "up": MessageLookupByLibrary.simpleMessage("Up"),
    "updateFailedError": MessageLookupByLibrary.simpleMessage(
      "Update failed. Please try again.",
    ),
    "username": MessageLookupByLibrary.simpleMessage("Username"),
    "viewRule": MessageLookupByLibrary.simpleMessage("View Rule"),
    "wallMountModeDisabledSnackbar": MessageLookupByLibrary.simpleMessage(
      "Wall Mount Mode disabled",
    ),
    "wallMountModeEnabledSnackbar": MessageLookupByLibrary.simpleMessage(
      "Wall Mount Mode enabled",
    ),
    "weather": MessageLookupByLibrary.simpleMessage("Weather"),
    "weatherForecast": MessageLookupByLibrary.simpleMessage("Weather Forecast"),
  };
}
