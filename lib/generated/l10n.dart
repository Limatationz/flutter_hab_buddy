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
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
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
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `An error occured`
  String get errorHeadline {
    return Intl.message(
      'An error occured',
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
    return Intl.message(
      'Rooms',
      name: 'navigationRooms',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
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
    return Intl.message(
      'Username',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Inbox`
  String get navigationInbox {
    return Intl.message(
      'Inbox',
      name: 'navigationInbox',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
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
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `Icon`
  String get icon {
    return Intl.message(
      'Icon',
      name: 'icon',
      desc: '',
      args: [],
    );
  }

  /// `Select`
  String get select {
    return Intl.message(
      'Select',
      name: 'select',
      desc: '',
      args: [],
    );
  }

  /// `Item Type`
  String get itemType {
    return Intl.message(
      'Item Type',
      name: 'itemType',
      desc: '',
      args: [],
    );
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
    return Intl.message(
      'Room',
      name: 'room',
      desc: '',
      args: [],
    );
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
    return Intl.message(
      'Name',
      name: 'roomNameLabel',
      desc: '',
      args: [],
    );
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
    return Intl.message(
      'Color',
      name: 'roomColorLabel',
      desc: '',
      args: [],
    );
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
    return Intl.message(
      'Level',
      name: 'roomLevelLabel',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
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
    return Intl.message(
      'Number',
      name: 'itemTypeNumber',
      desc: '',
      args: [],
    );
  }

  /// `Text`
  String get itemTypeText {
    return Intl.message(
      'Text',
      name: 'itemTypeText',
      desc: '',
      args: [],
    );
  }

  /// `Dimmer`
  String get itemTypeDimmer {
    return Intl.message(
      'Dimmer',
      name: 'itemTypeDimmer',
      desc: '',
      args: [],
    );
  }

  /// `Switch`
  String get itemTypeButton {
    return Intl.message(
      'Switch',
      name: 'itemTypeButton',
      desc: '',
      args: [],
    );
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
    return Intl.message(
      'Color',
      name: 'itemTypeColor',
      desc: '',
      args: [],
    );
  }

  /// `Player`
  String get itemTypePlayer {
    return Intl.message(
      'Player',
      name: 'itemTypePlayer',
      desc: '',
      args: [],
    );
  }

  /// `Image`
  String get itemTypeImage {
    return Intl.message(
      'Image',
      name: 'itemTypeImage',
      desc: '',
      args: [],
    );
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
    return Intl.message(
      'Call',
      name: 'itemTypeCall',
      desc: '',
      args: [],
    );
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
    return Intl.message(
      'Unknown',
      name: 'itemTypeUnknown',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get itemTypeLight {
    return Intl.message(
      'Light',
      name: 'itemTypeLight',
      desc: '',
      args: [],
    );
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
    return Intl.message(
      'Fan',
      name: 'itemTypeFan',
      desc: '',
      args: [],
    );
  }

  /// `Heater`
  String get itemTypeHeater {
    return Intl.message(
      'Heater',
      name: 'itemTypeHeater',
      desc: '',
      args: [],
    );
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
    return Intl.message(
      'Energy',
      name: 'itemTypeEnergy',
      desc: '',
      args: [],
    );
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
    return Intl.message(
      'Edit Item',
      name: 'editItem',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
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
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get themeLight {
    return Intl.message(
      'Light',
      name: 'themeLight',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get themeDark {
    return Intl.message(
      'Dark',
      name: 'themeDark',
      desc: '',
      args: [],
    );
  }

  /// `System`
  String get themeSystem {
    return Intl.message(
      'System',
      name: 'themeSystem',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
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
