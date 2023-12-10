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

  /// `Add a custom label for this item otherwise the label from OpenHAB will be used (optional)`
  String get customLabelHelp {
    return Intl.message(
      'Add a custom label for this item otherwise the label from OpenHAB will be used (optional)',
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

  /// `Further description of the room (optional)`
  String get roomDescriptionHelp {
    return Intl.message(
      'Further description of the room (optional)',
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

  /// `Optional`
  String get optional {
    return Intl.message(
      'Optional',
      name: 'optional',
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
