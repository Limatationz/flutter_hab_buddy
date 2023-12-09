import 'package:drift/drift.dart';
import 'package:flutter/material.dart' show IconData;

import '../../../util/icons/icons.dart';
import '../converter/state_description_converter.dart';
import '../converter/string_list_converter.dart';

@DataClassName("InboxEntry")
class InboxTable extends Table {
  TextColumn get type => textEnum<InboxEntryType>()();

  TextColumn get name => text()();

  TextColumn get label => text()();

  TextColumn get category => text().nullable()();

  TextColumn get tags => text().map(const StringListConverter()).nullable()();

  TextColumn get groups => text().map(const StringListConverter()).nullable()();

  TextColumn get state => text()();

  TextColumn get transformedState => text().nullable()();

  TextColumn get stateDescription =>
      text().map(const StateDescriptionConverter()).nullable()();

  @override
  Set<Column> get primaryKey => {name};
}

enum InboxEntryType {
  number,
  string,
  dimmer,
  button,
  rollershutter,
  dateTime,
  group,
  color,
  contact,
  player,
  image,
  location,
  call,
  unknown;

  static InboxEntryType fromString(String? value) {
    switch (value) {
      case "Number":
        return InboxEntryType.number;
      case "String":
        return InboxEntryType.string;
      case "Dimmer":
        return InboxEntryType.dimmer;
      case "Switch":
        return InboxEntryType.button;
      case "Rollershutter":
        return InboxEntryType.rollershutter;
      case "DateTime":
        return InboxEntryType.dateTime;
      case "Group":
        return InboxEntryType.group;
      case "Color":
        return InboxEntryType.color;
      case "Contact":
        return InboxEntryType.contact;
      case "Player":
        return InboxEntryType.player;
      case "Image":
        return InboxEntryType.image;
      case "Call":
        return InboxEntryType.call;
      default:
        if (value?.contains("Number") ?? false) {
          return InboxEntryType.number;
        }
        print("Unknown InboxEntryType: $value");
        return InboxEntryType.unknown;
    }
  }

  IconData? get icon {
    switch (this) {
      case InboxEntryType.number:
        return LineIcons.hashtag;
      case InboxEntryType.string:
        return LineIcons.text;
      case InboxEntryType.dimmer:
        return LineIcons.light_bulb;
      case InboxEntryType.button:
        return LineIcons.power_switch;
      case InboxEntryType.rollershutter:
        return LineIcons.window;
      case InboxEntryType.dateTime:
        return LineIcons.calendar;
      case InboxEntryType.group:
        return LineIcons.list;
      case InboxEntryType.color:
        return LineIcons.pallet;
      case InboxEntryType.player:
        return LineIcons.video_playback;
      case InboxEntryType.image:
        return LineIcons.image;
      case InboxEntryType.location:
        return LineIcons.image;
      case InboxEntryType.call:
        return LineIcons.phone;
      case InboxEntryType.contact:
        return LineIconsFilled.power_switch;
      case InboxEntryType.unknown:
        return null;
    }
  }
}
