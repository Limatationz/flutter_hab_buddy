import '../inbox/inbox_table.dart';

enum ItemType {
  text,
  button,
  light,
  rollerShutter,
  fan,
  heater,
  thermostat,
  temperature,
  humidity,
  airPressure,
  airQuality,
  smokeDetector,
  waterDetector,
  motionDetector,
  doorContact,
  windowContact,
  powerOutlet,
  player;

  static List<ItemType> forEntryType(InboxEntryType type) {
    switch (type) {
      case InboxEntryType.button:
        return [ItemType.button, ItemType.light, ItemType.powerOutlet];
      case InboxEntryType.dimmer:
        return [ItemType.light];
      case InboxEntryType.rollershutter:
        return [ItemType.rollerShutter];
      case InboxEntryType.contact:
        return [ItemType.doorContact, ItemType.windowContact];
      case InboxEntryType.number:
        return [
          ItemType.temperature,
          ItemType.humidity,
          ItemType.airPressure,
          ItemType.airQuality,
          ItemType.text,
        ];
      case InboxEntryType.string:
        return [ItemType.text];
      case InboxEntryType.dateTime:
        return [ItemType.text];
      case InboxEntryType.color:
        return [ItemType.light, ItemType.text];
      case InboxEntryType.player:
        return [ItemType.player];
      default:
        return [];
    }
  }
}
