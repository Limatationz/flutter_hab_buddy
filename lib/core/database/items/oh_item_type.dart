import 'package:flutter/material.dart';

enum OhItemType {
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

  static OhItemType fromString(String? value) {
    switch (value) {
      case "Number":
        return OhItemType.number;
      case "String":
        return OhItemType.string;
      case "Dimmer":
        return OhItemType.dimmer;
      case "Switch":
        return OhItemType.button;
      case "Rollershutter":
        return OhItemType.rollershutter;
      case "DateTime":
        return OhItemType.dateTime;
      case "Group":
        return OhItemType.group;
      case "Color":
        return OhItemType.color;
      case "Contact":
        return OhItemType.contact;
      case "Player":
        return OhItemType.player;
      case "Image":
        return OhItemType.image;
      case "Call":
        return OhItemType.call;
      case "Location":
        return OhItemType.location;
      default:
        if (value?.contains("Number") ?? false) {
          return OhItemType.number;
        }
        print("Unknown OhItemType: $value");
        return OhItemType.unknown;
    }
  }

  IconData? get icon {
    switch (this) {
      case OhItemType.number:
        return Icons.numbers;
      case OhItemType.string:
        return Icons.abc;
      case OhItemType.dimmer:
        return Icons.linear_scale;
      case OhItemType.button:
        return Icons.power_settings_new;
      case OhItemType.rollershutter:
        return Icons.roller_shades;
      case OhItemType.dateTime:
        return Icons.event;
      case OhItemType.group:
        return Icons.workspaces;
      case OhItemType.color:
        return Icons.pallet;
      case OhItemType.player:
        return Icons.play_circle;
      case OhItemType.image:
        return Icons.image;
      case OhItemType.location:
        return Icons.location_on;
      case OhItemType.call:
        return Icons.phone;
      case OhItemType.contact:
        return Icons.sensor_door;
      case OhItemType.unknown:
        return null;
    }
  }
}
