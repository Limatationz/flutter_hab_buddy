// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `An error occurred`
  String get errorHeadline {
    return Intl.message(
      'An error occurred',
      name: 'errorHeadline',
      desc: '',
      args: [],
    );
  }

  /// `Go to Home`
  String get errorButtonHome {
    return Intl.message(
      'Go to Home',
      name: 'errorButtonHome',
      desc: '',
      args: [],
    );
  }

  /// `Favorites`
  String get navigationFavorites {
    return Intl.message(
      'Favorites',
      name: 'navigationFavorites',
      desc: '',
      args: [],
    );
  }

  /// `Rooms`
  String get navigationRooms {
    return Intl.message('Rooms', name: 'navigationRooms', desc: '', args: []);
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Login failed`
  String get loginFailedTitle {
    return Intl.message(
      'Login failed',
      name: 'loginFailedTitle',
      desc: '',
      args: [],
    );
  }

  /// `Please try again`
  String get loginFailedMessage {
    return Intl.message(
      'Please try again',
      name: 'loginFailedMessage',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get username {
    return Intl.message('Username', name: 'username', desc: '', args: []);
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Inbox`
  String get navigationInbox {
    return Intl.message('Inbox', name: 'navigationInbox', desc: '', args: []);
  }

  /// `Search`
  String get search {
    return Intl.message('Search', name: 'search', desc: '', args: []);
  }

  /// `No results for:`
  String get iconPickerNoResultsText {
    return Intl.message(
      'No results for:',
      name: 'iconPickerNoResultsText',
      desc: '',
      args: [],
    );
  }

  /// `Pick an icon`
  String get iconPickerTitle {
    return Intl.message(
      'Pick an icon',
      name: 'iconPickerTitle',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message('Close', name: 'close', desc: '', args: []);
  }

  /// `Icon`
  String get icon {
    return Intl.message('Icon', name: 'icon', desc: '', args: []);
  }

  /// `Select`
  String get select {
    return Intl.message('Select', name: 'select', desc: '', args: []);
  }

  /// `Item Type`
  String get itemType {
    return Intl.message('Item Type', name: 'itemType', desc: '', args: []);
  }

  /// `The type of the item`
  String get itemTypeHelp {
    return Intl.message(
      'The type of the item',
      name: 'itemTypeHelp',
      desc: '',
      args: [],
    );
  }

  /// `Room`
  String get room {
    return Intl.message('Room', name: 'room', desc: '', args: []);
  }

  /// `The room where the item is located`
  String get roomHelp {
    return Intl.message(
      'The room where the item is located',
      name: 'roomHelp',
      desc: '',
      args: [],
    );
  }

  /// `Custom Label`
  String get customLabel {
    return Intl.message(
      'Custom Label',
      name: 'customLabel',
      desc: '',
      args: [],
    );
  }

  /// `Add a custom label for this item otherwise the label from OpenHAB will be used`
  String get customLabelHelp {
    return Intl.message(
      'Add a custom label for this item otherwise the label from OpenHAB will be used',
      name: 'customLabelHelp',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get roomNameLabel {
    return Intl.message('Name', name: 'roomNameLabel', desc: '', args: []);
  }

  /// `Description`
  String get roomDescriptionLabel {
    return Intl.message(
      'Description',
      name: 'roomDescriptionLabel',
      desc: '',
      args: [],
    );
  }

  /// `Color`
  String get roomColorLabel {
    return Intl.message('Color', name: 'roomColorLabel', desc: '', args: []);
  }

  /// `Name of the room`
  String get roomNameHelp {
    return Intl.message(
      'Name of the room',
      name: 'roomNameHelp',
      desc: '',
      args: [],
    );
  }

  /// `Further description of the room`
  String get roomDescriptionHelp {
    return Intl.message(
      'Further description of the room',
      name: 'roomDescriptionHelp',
      desc: '',
      args: [],
    );
  }

  /// `Living Room`
  String get roomNameHint {
    return Intl.message(
      'Living Room',
      name: 'roomNameHint',
      desc: '',
      args: [],
    );
  }

  /// `Level`
  String get roomLevelLabel {
    return Intl.message('Level', name: 'roomLevelLabel', desc: '', args: []);
  }

  /// `Save`
  String get save {
    return Intl.message('Save', name: 'save', desc: '', args: []);
  }

  /// `Add Room`
  String get addRoomHeadline {
    return Intl.message(
      'Add Room',
      name: 'addRoomHeadline',
      desc: '',
      args: [],
    );
  }

  /// `Add Item`
  String get addItemHeadline {
    return Intl.message(
      'Add Item',
      name: 'addItemHeadline',
      desc: '',
      args: [],
    );
  }

  /// `Number`
  String get itemTypeNumber {
    return Intl.message('Number', name: 'itemTypeNumber', desc: '', args: []);
  }

  /// `Text`
  String get itemTypeText {
    return Intl.message('Text', name: 'itemTypeText', desc: '', args: []);
  }

  /// `Dimmer`
  String get itemTypeDimmer {
    return Intl.message('Dimmer', name: 'itemTypeDimmer', desc: '', args: []);
  }

  /// `Switch`
  String get itemTypeButton {
    return Intl.message('Switch', name: 'itemTypeButton', desc: '', args: []);
  }

  /// `Roller Shutter`
  String get itemTypeRollerShutter {
    return Intl.message(
      'Roller Shutter',
      name: 'itemTypeRollerShutter',
      desc: '',
      args: [],
    );
  }

  /// `Date and Time`
  String get itemTypeDateTime {
    return Intl.message(
      'Date and Time',
      name: 'itemTypeDateTime',
      desc: '',
      args: [],
    );
  }

  /// `Color`
  String get itemTypeColor {
    return Intl.message('Color', name: 'itemTypeColor', desc: '', args: []);
  }

  /// `Player`
  String get itemTypePlayer {
    return Intl.message('Player', name: 'itemTypePlayer', desc: '', args: []);
  }

  /// `Image`
  String get itemTypeImage {
    return Intl.message('Image', name: 'itemTypeImage', desc: '', args: []);
  }

  /// `Location`
  String get itemTypeLocation {
    return Intl.message(
      'Location',
      name: 'itemTypeLocation',
      desc: '',
      args: [],
    );
  }

  /// `Call`
  String get itemTypeCall {
    return Intl.message('Call', name: 'itemTypeCall', desc: '', args: []);
  }

  /// `Window Contact`
  String get itemTypeWindowContact {
    return Intl.message(
      'Window Contact',
      name: 'itemTypeWindowContact',
      desc: '',
      args: [],
    );
  }

  /// `Door Contact`
  String get itemTypeDoorContact {
    return Intl.message(
      'Door Contact',
      name: 'itemTypeDoorContact',
      desc: '',
      args: [],
    );
  }

  /// `Unknown`
  String get itemTypeUnknown {
    return Intl.message('Unknown', name: 'itemTypeUnknown', desc: '', args: []);
  }

  /// `Light`
  String get itemTypeLight {
    return Intl.message('Light', name: 'itemTypeLight', desc: '', args: []);
  }

  /// `Power Outlet`
  String get itemTypePowerOutlet {
    return Intl.message(
      'Power Outlet',
      name: 'itemTypePowerOutlet',
      desc: '',
      args: [],
    );
  }

  /// `Temperature`
  String get itemTypeTemperature {
    return Intl.message(
      'Temperature',
      name: 'itemTypeTemperature',
      desc: '',
      args: [],
    );
  }

  /// `Humidity`
  String get itemTypeHumidity {
    return Intl.message(
      'Humidity',
      name: 'itemTypeHumidity',
      desc: '',
      args: [],
    );
  }

  /// `Air Pressure`
  String get itemTypeAirPressure {
    return Intl.message(
      'Air Pressure',
      name: 'itemTypeAirPressure',
      desc: '',
      args: [],
    );
  }

  /// `Air Quality`
  String get itemTypeAirQuality {
    return Intl.message(
      'Air Quality',
      name: 'itemTypeAirQuality',
      desc: '',
      args: [],
    );
  }

  /// `Smoke Detector`
  String get itemTypeSmokeDetector {
    return Intl.message(
      'Smoke Detector',
      name: 'itemTypeSmokeDetector',
      desc: '',
      args: [],
    );
  }

  /// `Water Detector`
  String get itemTypeWaterDetector {
    return Intl.message(
      'Water Detector',
      name: 'itemTypeWaterDetector',
      desc: '',
      args: [],
    );
  }

  /// `Motion Detector`
  String get itemTypeMotionDetector {
    return Intl.message(
      'Motion Detector',
      name: 'itemTypeMotionDetector',
      desc: '',
      args: [],
    );
  }

  /// `Fan`
  String get itemTypeFan {
    return Intl.message('Fan', name: 'itemTypeFan', desc: '', args: []);
  }

  /// `Heater`
  String get itemTypeHeater {
    return Intl.message('Heater', name: 'itemTypeHeater', desc: '', args: []);
  }

  /// `Thermostat`
  String get itemTypeThermostat {
    return Intl.message(
      'Thermostat',
      name: 'itemTypeThermostat',
      desc: '',
      args: [],
    );
  }

  /// `Presence`
  String get itemTypePresence {
    return Intl.message(
      'Presence',
      name: 'itemTypePresence',
      desc: '',
      args: [],
    );
  }

  /// `Energy`
  String get itemTypeEnergy {
    return Intl.message('Energy', name: 'itemTypeEnergy', desc: '', args: []);
  }

  /// `Add Complex Item`
  String get addComplexItem {
    return Intl.message(
      'Add Complex Item',
      name: 'addComplexItem',
      desc: '',
      args: [],
    );
  }

  /// `Edit Item`
  String get editItem {
    return Intl.message('Edit Item', name: 'editItem', desc: '', args: []);
  }

  /// `Confirm`
  String get confirm {
    return Intl.message('Confirm', name: 'confirm', desc: '', args: []);
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Delete item?`
  String get deleteItemDialogHeadline {
    return Intl.message(
      'Delete item?',
      name: 'deleteItemDialogHeadline',
      desc: '',
      args: [],
    );
  }

  /// `Do you really want to delete item`
  String get deleteItemDialogText {
    return Intl.message(
      'Do you really want to delete item',
      name: 'deleteItemDialogText',
      desc: '',
      args: [],
    );
  }

  /// `Delete room?`
  String get deleteRoomDialogHeadline {
    return Intl.message(
      'Delete room?',
      name: 'deleteRoomDialogHeadline',
      desc: '',
      args: [],
    );
  }

  /// `Do you really want to delete room`
  String get deleteRoomDialogText {
    return Intl.message(
      'Do you really want to delete room',
      name: 'deleteRoomDialogText',
      desc: '',
      args: [],
    );
  }

  /// `Advanced Player`
  String get itemTypeComplexPlayer {
    return Intl.message(
      'Advanced Player',
      name: 'itemTypeComplexPlayer',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get navigationSettings {
    return Intl.message(
      'Settings',
      name: 'navigationSettings',
      desc: '',
      args: [],
    );
  }

  /// `Player Item not found`
  String get complex_player_add_item_error {
    return Intl.message(
      'Player Item not found',
      name: 'complex_player_add_item_error',
      desc: '',
      args: [],
    );
  }

  /// `Update failed. Please try again.`
  String get updateFailedError {
    return Intl.message(
      'Update failed. Please try again.',
      name: 'updateFailedError',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message('Done', name: 'done', desc: '', args: []);
  }

  /// `Light`
  String get themeLight {
    return Intl.message('Light', name: 'themeLight', desc: '', args: []);
  }

  /// `Dark`
  String get themeDark {
    return Intl.message('Dark', name: 'themeDark', desc: '', args: []);
  }

  /// `System`
  String get themeSystem {
    return Intl.message('System', name: 'themeSystem', desc: '', args: []);
  }

  /// `Enter your credentials from myOpenHAB.org`
  String get loginInfo {
    return Intl.message(
      'Enter your credentials from myOpenHAB.org',
      name: 'loginInfo',
      desc: '',
      args: [],
    );
  }

  /// `Time format`
  String get timeFormat {
    return Intl.message('Time format', name: 'timeFormat', desc: '', args: []);
  }

  /// `Clock`
  String get clock {
    return Intl.message('Clock', name: 'clock', desc: '', args: []);
  }

  /// `Weather`
  String get weather {
    return Intl.message('Weather', name: 'weather', desc: '', args: []);
  }

  /// `Weather Forecast`
  String get weatherForecast {
    return Intl.message(
      'Weather Forecast',
      name: 'weatherForecast',
      desc: '',
      args: [],
    );
  }

  /// `Feels like {temp}`
  String feelsLike(Object temp) {
    return Intl.message(
      'Feels like $temp',
      name: 'feelsLike',
      desc: '',
      args: [temp],
    );
  }

  /// `Data`
  String get data {
    return Intl.message('Data', name: 'data', desc: '', args: []);
  }

  /// `Data ({unit})`
  String dataWithUnit(Object unit) {
    return Intl.message(
      'Data ($unit)',
      name: 'dataWithUnit',
      desc: '',
      args: [unit],
    );
  }

  /// `Time`
  String get time {
    return Intl.message('Time', name: 'time', desc: '', args: []);
  }

  /// `Date`
  String get date {
    return Intl.message('Date', name: 'date', desc: '', args: []);
  }

  /// `App`
  String get settings_app {
    return Intl.message('App', name: 'settings_app', desc: '', args: []);
  }

  /// `Connection`
  String get settings_connection {
    return Intl.message(
      'Connection',
      name: 'settings_connection',
      desc: '',
      args: [],
    );
  }

  /// `State of the connection to the openHAB server`
  String get settings_connection_status_description {
    return Intl.message(
      'State of the connection to the openHAB server',
      name: 'settings_connection_status_description',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get settings_connection_status_title {
    return Intl.message(
      'Status',
      name: 'settings_connection_status_title',
      desc: '',
      args: [],
    );
  }

  /// `Start`
  String get settings_connection_start_title {
    return Intl.message(
      'Start',
      name: 'settings_connection_start_title',
      desc: '',
      args: [],
    );
  }

  /// `Date and time of the last connection start`
  String get settings_connection_start_description {
    return Intl.message(
      'Date and time of the last connection start',
      name: 'settings_connection_start_description',
      desc: '',
      args: [],
    );
  }

  /// `Never`
  String get never {
    return Intl.message('Never', name: 'never', desc: '', args: []);
  }

  /// `Last Update`
  String get settings_connection_update_title {
    return Intl.message(
      'Last Update',
      name: 'settings_connection_update_title',
      desc: '',
      args: [],
    );
  }

  /// `Date and time of the last recieved state change`
  String get settings_connection_update_description {
    return Intl.message(
      'Date and time of the last recieved state change',
      name: 'settings_connection_update_description',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }

  /// `Theme`
  String get settings_theme {
    return Intl.message('Theme', name: 'settings_theme', desc: '', args: []);
  }

  /// `Automation`
  String get navigationAutomation {
    return Intl.message(
      'Automation',
      name: 'navigationAutomation',
      desc: '',
      args: [],
    );
  }

  /// `Add remote access`
  String get settingsAddRemoteAccess {
    return Intl.message(
      'Add remote access',
      name: 'settingsAddRemoteAccess',
      desc: '',
      args: [],
    );
  }

  /// `Add cloud access`
  String get settingsAddCloudAccess {
    return Intl.message(
      'Add cloud access',
      name: 'settingsAddCloudAccess',
      desc: '',
      args: [],
    );
  }

  /// `Add api access`
  String get settingsAddApiAccess {
    return Intl.message(
      'Add api access',
      name: 'settingsAddApiAccess',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message('Next', name: 'next', desc: '', args: []);
  }

  /// `Finish`
  String get finish {
    return Intl.message('Finish', name: 'finish', desc: '', args: []);
  }

  /// `Local`
  String get serverConnectionStateLocal {
    return Intl.message(
      'Local',
      name: 'serverConnectionStateLocal',
      desc: '',
      args: [],
    );
  }

  /// `Remote`
  String get serverConnectionStateRemote {
    return Intl.message(
      'Remote',
      name: 'serverConnectionStateRemote',
      desc: '',
      args: [],
    );
  }

  /// `Cloud`
  String get serverConnectionStateCloud {
    return Intl.message(
      'Cloud',
      name: 'serverConnectionStateCloud',
      desc: '',
      args: [],
    );
  }

  /// `Offline`
  String get serverConnectionStateOffline {
    return Intl.message(
      'Offline',
      name: 'serverConnectionStateOffline',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to trigger the rule`
  String get confirmTriggerRuleAlertText1 {
    return Intl.message(
      'Do you want to trigger the rule',
      name: 'confirmTriggerRuleAlertText1',
      desc: '',
      args: [],
    );
  }

  /// `now ?`
  String get confirmTriggerRuleAlertText2 {
    return Intl.message(
      'now ?',
      name: 'confirmTriggerRuleAlertText2',
      desc: '',
      args: [],
    );
  }

  /// `Do you really want to delete the rule`
  String get confirmDeleteRuleAlertText {
    return Intl.message(
      'Do you really want to delete the rule',
      name: 'confirmDeleteRuleAlertText',
      desc: '',
      args: [],
    );
  }

  /// `Recent Colors`
  String get recentColors {
    return Intl.message(
      'Recent Colors',
      name: 'recentColors',
      desc: '',
      args: [],
    );
  }

  /// `Color`
  String get color {
    return Intl.message('Color', name: 'color', desc: '', args: []);
  }

  /// `Successfully triggered the rule`
  String get triggered_rule_success {
    return Intl.message(
      'Successfully triggered the rule',
      name: 'triggered_rule_success',
      desc: '',
      args: [],
    );
  }

  /// `Failed to trigger the rule`
  String get triggered_rule_failure {
    return Intl.message(
      'Failed to trigger the rule',
      name: 'triggered_rule_failure',
      desc: '',
      args: [],
    );
  }

  /// `Successfully deleted the rule`
  String get deletedRuleSuccess {
    return Intl.message(
      'Successfully deleted the rule',
      name: 'deletedRuleSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Failed to delete the rule`
  String get deletedRuleFailure {
    return Intl.message(
      'Failed to delete the rule',
      name: 'deletedRuleFailure',
      desc: '',
      args: [],
    );
  }

  /// `Add Automation`
  String get addAutomation {
    return Intl.message(
      'Add Automation',
      name: 'addAutomation',
      desc: '',
      args: [],
    );
  }

  /// `Automations`
  String get automations {
    return Intl.message('Automations', name: 'automations', desc: '', args: []);
  }

  /// `Automations with {itemName}`
  String automationsWith(Object itemName) {
    return Intl.message(
      'Automations with $itemName',
      name: 'automationsWith',
      desc: '',
      args: [itemName],
    );
  }

  /// `Repeating`
  String get ruleTypeRepeating {
    return Intl.message(
      'Repeating',
      name: 'ruleTypeRepeating',
      desc: '',
      args: [],
    );
  }

  /// `Scheduled`
  String get ruleTypeScheduled {
    return Intl.message(
      'Scheduled',
      name: 'ruleTypeScheduled',
      desc: '',
      args: [],
    );
  }

  /// `No rules found`
  String get noRulesFound {
    return Intl.message(
      'No rules found',
      name: 'noRulesFound',
      desc: '',
      args: [],
    );
  }

  /// `Edit Rule`
  String get editRule {
    return Intl.message('Edit Rule', name: 'editRule', desc: '', args: []);
  }

  /// `New Rule`
  String get newRule {
    return Intl.message('New Rule', name: 'newRule', desc: '', args: []);
  }

  /// `Delete`
  String get delete {
    return Intl.message('Delete', name: 'delete', desc: '', args: []);
  }

  /// `Run`
  String get run {
    return Intl.message('Run', name: 'run', desc: '', args: []);
  }

  /// `every second`
  String get cronEverySecond {
    return Intl.message(
      'every second',
      name: 'cronEverySecond',
      desc: '',
      args: [],
    );
  }

  /// `every {everySecond} seconds starting at {startSecond}`
  String cronEveryEverySecondsStartingAt(
    Object everySecond,
    Object startSecond,
  ) {
    return Intl.message(
      'every $everySecond seconds starting at $startSecond',
      name: 'cronEveryEverySecondsStartingAt',
      desc: '',
      args: [everySecond, startSecond],
    );
  }

  /// `every {everySecond} seconds`
  String cronEverySeconds(Object everySecond) {
    return Intl.message(
      'every $everySecond seconds',
      name: 'cronEverySeconds',
      desc: '',
      args: [everySecond],
    );
  }

  /// `at second {seconds}`
  String cronAtSecond(Object seconds) {
    return Intl.message(
      'at second $seconds',
      name: 'cronAtSecond',
      desc: '',
      args: [seconds],
    );
  }

  /// `at seconds {secondsRange} and ${secondsLast}`
  String cronAtSecondsAnd(Object secondsRange, Object secondsLast) {
    return Intl.message(
      'at seconds $secondsRange and \$$secondsLast',
      name: 'cronAtSecondsAnd',
      desc: '',
      args: [secondsRange, secondsLast],
    );
  }

  /// `every second between {betweenStartSecond} and {betweenEndSecond}`
  String cronEverySecondBetweenAnd(
    Object betweenStartSecond,
    Object betweenEndSecond,
  ) {
    return Intl.message(
      'every second between $betweenStartSecond and $betweenEndSecond',
      name: 'cronEverySecondBetweenAnd',
      desc: '',
      args: [betweenStartSecond, betweenEndSecond],
    );
  }

  /// `every minute`
  String get cronEveryMinute {
    return Intl.message(
      'every minute',
      name: 'cronEveryMinute',
      desc: '',
      args: [],
    );
  }

  /// `every {everyMinute} minutes starting at {startMinute}`
  String cronEveryEveryMinutesStartingAt(
    Object everyMinute,
    Object startMinute,
  ) {
    return Intl.message(
      'every $everyMinute minutes starting at $startMinute',
      name: 'cronEveryEveryMinutesStartingAt',
      desc: '',
      args: [everyMinute, startMinute],
    );
  }

  /// `every {everyMinute} minutes`
  String cronEveryMinutes(Object everyMinute) {
    return Intl.message(
      'every $everyMinute minutes',
      name: 'cronEveryMinutes',
      desc: '',
      args: [everyMinute],
    );
  }

  /// `at minute {minute}`
  String cronAtMinute(Object minute) {
    return Intl.message(
      'at minute $minute',
      name: 'cronAtMinute',
      desc: '',
      args: [minute],
    );
  }

  /// `at minutes {minutesRange} and {minutesLast}`
  String cronAtMinutesAnd(Object minutesRange, Object minutesLast) {
    return Intl.message(
      'at minutes $minutesRange and $minutesLast',
      name: 'cronAtMinutesAnd',
      desc: '',
      args: [minutesRange, minutesLast],
    );
  }

  /// `every minute between {betweenStartMinute} and {betweenEndMinute}`
  String cronEveryMinuteBetweenAnd(
    Object betweenStartMinute,
    Object betweenEndMinute,
  ) {
    return Intl.message(
      'every minute between $betweenStartMinute and $betweenEndMinute',
      name: 'cronEveryMinuteBetweenAnd',
      desc: '',
      args: [betweenStartMinute, betweenEndMinute],
    );
  }

  /// `every month`
  String get cronEveryMonth {
    return Intl.message(
      'every month',
      name: 'cronEveryMonth',
      desc: '',
      args: [],
    );
  }

  /// `every {everyMonth} months starting at {startMonth}`
  String cronEveryEveryMonthsStartingAt(Object everyMonth, Object startMonth) {
    return Intl.message(
      'every $everyMonth months starting at $startMonth',
      name: 'cronEveryEveryMonthsStartingAt',
      desc: '',
      args: [everyMonth, startMonth],
    );
  }

  /// `every {everyMonth} months`
  String cronEveryMonths(Object everyMonth) {
    return Intl.message(
      'every $everyMonth months',
      name: 'cronEveryMonths',
      desc: '',
      args: [everyMonth],
    );
  }

  /// `at month {month}`
  String cronAtMonth(Object month) {
    return Intl.message(
      'at month $month',
      name: 'cronAtMonth',
      desc: '',
      args: [month],
    );
  }

  /// `at months {monthsRange} and {monthsLast}`
  String cronAtMonthsAnd(Object monthsRange, Object monthsLast) {
    return Intl.message(
      'at months $monthsRange and $monthsLast',
      name: 'cronAtMonthsAnd',
      desc: '',
      args: [monthsRange, monthsLast],
    );
  }

  /// `every month between {betweenStartMonth} and {betweenEndMonth}`
  String cronEveryMonthBetweenAnd(
    Object betweenStartMonth,
    Object betweenEndMonth,
  ) {
    return Intl.message(
      'every month between $betweenStartMonth and $betweenEndMonth',
      name: 'cronEveryMonthBetweenAnd',
      desc: '',
      args: [betweenStartMonth, betweenEndMonth],
    );
  }

  /// `every year`
  String get cronEveryYear {
    return Intl.message(
      'every year',
      name: 'cronEveryYear',
      desc: '',
      args: [],
    );
  }

  /// `every {everyYear} years starting in {startYear}`
  String cronEveryEveryYearsStartingAt(Object everyYear, Object startYear) {
    return Intl.message(
      'every $everyYear years starting in $startYear',
      name: 'cronEveryEveryYearsStartingAt',
      desc: '',
      args: [everyYear, startYear],
    );
  }

  /// `starting in {startYear}`
  String cronStartingInYear(Object startYear) {
    return Intl.message(
      'starting in $startYear',
      name: 'cronStartingInYear',
      desc: '',
      args: [startYear],
    );
  }

  /// `in {year}`
  String cronInYear(Object year) {
    return Intl.message('in $year', name: 'cronInYear', desc: '', args: [year]);
  }

  /// `in {yearsRange} and {yearsLast}`
  String cronInYearsAnd(Object yearsRange, Object yearsLast) {
    return Intl.message(
      'in $yearsRange and $yearsLast',
      name: 'cronInYearsAnd',
      desc: '',
      args: [yearsRange, yearsLast],
    );
  }

  /// `between {betweenStartYear} and {betweenEndYear}`
  String cronBetweenYears(Object betweenStartYear, Object betweenEndYear) {
    return Intl.message(
      'between $betweenStartYear and $betweenEndYear',
      name: 'cronBetweenYears',
      desc: '',
      args: [betweenStartYear, betweenEndYear],
    );
  }

  /// `every {everyDay} days starting on the {startDay}`
  String cronEveryDayStartingOn(Object everyDay, Object startDay) {
    return Intl.message(
      'every $everyDay days starting on the $startDay',
      name: 'cronEveryDayStartingOn',
      desc: '',
      args: [everyDay, startDay],
    );
  }

  /// `every {everyDay} days`
  String cronEveryDay(Object everyDay) {
    return Intl.message(
      'every $everyDay days',
      name: 'cronEveryDay',
      desc: '',
      args: [everyDay],
    );
  }

  /// `on the {day} day`
  String cronOnDay(Object day) {
    return Intl.message(
      'on the $day day',
      name: 'cronOnDay',
      desc: '',
      args: [day],
    );
  }

  /// `on the {daysRange} and {lastDay} day`
  String cronOnDaysAnd(Object daysRange, Object lastDay) {
    return Intl.message(
      'on the $daysRange and $lastDay day',
      name: 'cronOnDaysAnd',
      desc: '',
      args: [daysRange, lastDay],
    );
  }

  /// `on the {lastDay} day of the month`
  String cronOnLastDayOfMonth(Object lastDay) {
    return Intl.message(
      'on the $lastDay day of the month',
      name: 'cronOnLastDayOfMonth',
      desc: '',
      args: [lastDay],
    );
  }

  /// `on the last weekday of the month`
  String get cronOnLastWeekdayOfMonth {
    return Intl.message(
      'on the last weekday of the month',
      name: 'cronOnLastWeekdayOfMonth',
      desc: '',
      args: [],
    );
  }

  /// `{dayBefore} days before the end of the month`
  String cronOnDayBeforeEndOfMonth(Object dayBefore) {
    return Intl.message(
      '$dayBefore days before the end of the month',
      name: 'cronOnDayBeforeEndOfMonth',
      desc: '',
      args: [dayBefore],
    );
  }

  /// `on the nearest weekday to the {nearestWeekday} of the month`
  String cronOnNearestWeekdayOfMonth(Object nearestWeekday) {
    return Intl.message(
      'on the nearest weekday to the $nearestWeekday of the month',
      name: 'cronOnNearestWeekdayOfMonth',
      desc: '',
      args: [nearestWeekday],
    );
  }

  /// `every week`
  String get cronEveryWeek {
    return Intl.message(
      'every week',
      name: 'cronEveryWeek',
      desc: '',
      args: [],
    );
  }

  /// `every {everyDay} days starting on the {startDay}`
  String cronEveryDayInWeekStartingOn(Object everyDay, Object startDay) {
    return Intl.message(
      'every $everyDay days starting on the $startDay',
      name: 'cronEveryDayInWeekStartingOn',
      desc: '',
      args: [everyDay, startDay],
    );
  }

  /// `on the {weekday}`
  String cronOnWeekday(Object weekday) {
    return Intl.message(
      'on the $weekday',
      name: 'cronOnWeekday',
      desc: '',
      args: [weekday],
    );
  }

  /// `on the {weekdaysRange} and {lastWeekday}`
  String cronOnWeekdaysAnd(Object weekdaysRange, Object lastWeekday) {
    return Intl.message(
      'on the $weekdaysRange and $lastWeekday',
      name: 'cronOnWeekdaysAnd',
      desc: '',
      args: [weekdaysRange, lastWeekday],
    );
  }

  /// `the last {lastDay} of the month`
  String cronOnLastXDayOfMonth(Object lastDay) {
    return Intl.message(
      'the last $lastDay of the month',
      name: 'cronOnLastXDayOfMonth',
      desc: '',
      args: [lastDay],
    );
  }

  /// `on the {xthWeek} {weekday} of the month`
  String cronOnXthWeekdayOfMonth(Object xthWeek, Object weekday) {
    return Intl.message(
      'on the $xthWeek $weekday of the month',
      name: 'cronOnXthWeekdayOfMonth',
      desc: '',
      args: [xthWeek, weekday],
    );
  }

  /// `FIRST`
  String get cronFirstWeek {
    return Intl.message('FIRST', name: 'cronFirstWeek', desc: '', args: []);
  }

  /// `SECOND`
  String get cronSecondWeek {
    return Intl.message('SECOND', name: 'cronSecondWeek', desc: '', args: []);
  }

  /// `THIRD`
  String get cronThirdWeek {
    return Intl.message('THIRD', name: 'cronThirdWeek', desc: '', args: []);
  }

  /// `FOURTH`
  String get cronFourthWeek {
    return Intl.message('FOURTH', name: 'cronFourthWeek', desc: '', args: []);
  }

  /// `FIFTH`
  String get cronFifthWeek {
    return Intl.message('FIFTH', name: 'cronFifthWeek', desc: '', args: []);
  }

  /// `Could not add trigger`
  String get couldNotAddTrigger {
    return Intl.message(
      'Could not add trigger',
      name: 'couldNotAddTrigger',
      desc: '',
      args: [],
    );
  }

  /// `Add Item`
  String get addItem {
    return Intl.message('Add Item', name: 'addItem', desc: '', args: []);
  }

  /// `Add Trigger`
  String get addTrigger {
    return Intl.message('Add Trigger', name: 'addTrigger', desc: '', args: []);
  }

  /// `Off`
  String get off {
    return Intl.message('Off', name: 'off', desc: '', args: []);
  }

  /// `On`
  String get on {
    return Intl.message('On', name: 'on', desc: '', args: []);
  }

  /// `max`
  String get sliderMaxHint {
    return Intl.message('max', name: 'sliderMaxHint', desc: '', args: []);
  }

  /// `current`
  String get sliderCurrentHint {
    return Intl.message(
      'current',
      name: 'sliderCurrentHint',
      desc: '',
      args: [],
    );
  }

  /// `min`
  String get sliderMinHint {
    return Intl.message('min', name: 'sliderMinHint', desc: '', args: []);
  }

  /// `Up`
  String get up {
    return Intl.message('Up', name: 'up', desc: '', args: []);
  }

  /// `Stop`
  String get stop {
    return Intl.message('Stop', name: 'stop', desc: '', args: []);
  }

  /// `Down`
  String get down {
    return Intl.message('Down', name: 'down', desc: '', args: []);
  }

  /// `in 5 min`
  String get timeTriggerIn5Min {
    return Intl.message(
      'in 5 min',
      name: 'timeTriggerIn5Min',
      desc: '',
      args: [],
    );
  }

  /// `in 10 min`
  String get timeTriggerIn10Min {
    return Intl.message(
      'in 10 min',
      name: 'timeTriggerIn10Min',
      desc: '',
      args: [],
    );
  }

  /// `in 30 min`
  String get timeTriggerIn30Min {
    return Intl.message(
      'in 30 min',
      name: 'timeTriggerIn30Min',
      desc: '',
      args: [],
    );
  }

  /// `in 1 h`
  String get timeTriggerIn1H {
    return Intl.message('in 1 h', name: 'timeTriggerIn1H', desc: '', args: []);
  }

  /// `in 2 h`
  String get timeTriggerIn2H {
    return Intl.message('in 2 h', name: 'timeTriggerIn2H', desc: '', args: []);
  }

  /// `in 12 h`
  String get timeTriggerIn12H {
    return Intl.message(
      'in 12 h',
      name: 'timeTriggerIn12H',
      desc: '',
      args: [],
    );
  }

  /// `in 1 day`
  String get timeTriggerIn1Day {
    return Intl.message(
      'in 1 day',
      name: 'timeTriggerIn1Day',
      desc: '',
      args: [],
    );
  }

  /// `in 2 days`
  String get timeTriggerIn2Days {
    return Intl.message(
      'in 2 days',
      name: 'timeTriggerIn2Days',
      desc: '',
      args: [],
    );
  }

  /// `in 1 min`
  String get timeTriggerIn1Min {
    return Intl.message(
      'in 1 min',
      name: 'timeTriggerIn1Min',
      desc: '',
      args: [],
    );
  }

  /// `40 - Rules loaded`
  String get systemStartTrigger40 {
    return Intl.message(
      '40 - Rules loaded',
      name: 'systemStartTrigger40',
      desc: '',
      args: [],
    );
  }

  /// `50 - Rule engine started`
  String get systemStartTrigger50 {
    return Intl.message(
      '50 - Rule engine started',
      name: 'systemStartTrigger50',
      desc: '',
      args: [],
    );
  }

  /// `70 - User interfaces started`
  String get systemStartTrigger70 {
    return Intl.message(
      '70 - User interfaces started',
      name: 'systemStartTrigger70',
      desc: '',
      args: [],
    );
  }

  /// `80 - Things initialized`
  String get systemStartTrigger80 {
    return Intl.message(
      '80 - Things initialized',
      name: 'systemStartTrigger80',
      desc: '',
      args: [],
    );
  }

  /// `100 - Startup complete`
  String get systemStartTrigger100 {
    return Intl.message(
      '100 - Startup complete',
      name: 'systemStartTrigger100',
      desc: '',
      args: [],
    );
  }

  /// `Auto delete`
  String get ruleAutoDeleteTitle {
    return Intl.message(
      'Auto delete',
      name: 'ruleAutoDeleteTitle',
      desc: '',
      args: [],
    );
  }

  /// `Automatically delete the rule after it is triggered. Requires that all triggers are time based and refer to a concrete date.`
  String get ruleAutoDeleteHint {
    return Intl.message(
      'Automatically delete the rule after it is triggered. Requires that all triggers are time based and refer to a concrete date.',
      name: 'ruleAutoDeleteHint',
      desc: '',
      args: [],
    );
  }

  /// `Rule name`
  String get ruleName {
    return Intl.message('Rule name', name: 'ruleName', desc: '', args: []);
  }

  /// `Triggers`
  String get triggers {
    return Intl.message('Triggers', name: 'triggers', desc: '', args: []);
  }

  /// `Actions`
  String get actions {
    return Intl.message('Actions', name: 'actions', desc: '', args: []);
  }

  /// `Options`
  String get options {
    return Intl.message('Options', name: 'options', desc: '', args: []);
  }

  /// `Add Item Action`
  String get addItemAction {
    return Intl.message(
      'Add Item Action',
      name: 'addItemAction',
      desc: '',
      args: [],
    );
  }

  /// `Add an item first`
  String get addAnItemFirst {
    return Intl.message(
      'Add an item first',
      name: 'addAnItemFirst',
      desc: '',
      args: [],
    );
  }

  /// `Script`
  String get script {
    return Intl.message('Script', name: 'script', desc: '', args: []);
  }

  /// `Item Action`
  String get itemAction {
    return Intl.message('Item Action', name: 'itemAction', desc: '', args: []);
  }

  /// `Select Item`
  String get selectItem {
    return Intl.message('Select Item', name: 'selectItem', desc: '', args: []);
  }

  /// `Select Action Type`
  String get selectActionType {
    return Intl.message(
      'Select Action Type',
      name: 'selectActionType',
      desc: '',
      args: [],
    );
  }

  /// `Post Update`
  String get postUpdateCommandLabel {
    return Intl.message(
      'Post Update',
      name: 'postUpdateCommandLabel',
      desc: '',
      args: [],
    );
  }

  /// `Send Command`
  String get sendCommandCommandLabel {
    return Intl.message(
      'Send Command',
      name: 'sendCommandCommandLabel',
      desc: '',
      args: [],
    );
  }

  /// `Or`
  String get or {
    return Intl.message('Or', name: 'or', desc: '', args: []);
  }

  /// `And`
  String get and {
    return Intl.message('And', name: 'and', desc: '', args: []);
  }

  /// `View Rule`
  String get viewRule {
    return Intl.message('View Rule', name: 'viewRule', desc: '', args: []);
  }

  /// `en`
  String get localeName {
    return Intl.message('en', name: 'localeName', desc: '', args: []);
  }

  /// `Licences`
  String get licences {
    return Intl.message('Licences', name: 'licences', desc: '', args: []);
  }

  /// `Wall Mount Mode`
  String get settings_wall_mount_mode {
    return Intl.message(
      'Wall Mount Mode',
      name: 'settings_wall_mount_mode',
      desc: '',
      args: [],
    );
  }

  /// `Automatically enable wall mount mode. App bars and navigation bars will be hidden and the screen is kept on.`
  String get settings_wall_mount_mode_description {
    return Intl.message(
      'Automatically enable wall mount mode. App bars and navigation bars will be hidden and the screen is kept on.',
      name: 'settings_wall_mount_mode_description',
      desc: '',
      args: [],
    );
  }

  /// `Wall Mount Mode enabled`
  String get wallMountModeEnabledSnackbar {
    return Intl.message(
      'Wall Mount Mode enabled',
      name: 'wallMountModeEnabledSnackbar',
      desc: '',
      args: [],
    );
  }

  /// `Wall Mount Mode disabled`
  String get wallMountModeDisabledSnackbar {
    return Intl.message(
      'Wall Mount Mode disabled',
      name: 'wallMountModeDisabledSnackbar',
      desc: '',
      args: [],
    );
  }

  /// `Disable Wall Mount Mode`
  String get disableWallMoundModeTooltip {
    return Intl.message(
      'Disable Wall Mount Mode',
      name: 'disableWallMoundModeTooltip',
      desc: '',
      args: [],
    );
  }

  /// `Enable Wall Mount Mode`
  String get enableWallMountModeTooltip {
    return Intl.message(
      'Enable Wall Mount Mode',
      name: 'enableWallMountModeTooltip',
      desc: '',
      args: [],
    );
  }

  /// `Edit Room`
  String get editRoomHeadline {
    return Intl.message(
      'Edit Room',
      name: 'editRoomHeadline',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[Locale.fromSubtags(languageCode: 'en')];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
