import 'package:drift/drift.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:stacked/stacked.dart';

import '../../../../core/database/app_database.dart';
import '../../../../locator.dart';

class RoomAddViewModel extends BaseViewModel {
  final _roomsStore = locator<AppDatabase>().roomsStore;

  final fbKey = GlobalKey<FormBuilderState>();

  IconData? roomIcon;

  RoomAddViewModel();

  Future<bool> save() async {
    if (fbKey.currentState?.saveAndValidate() ?? false) {
      final data = fbKey.currentState!.value;

      final name = data["name"] as String;
      final description = data["description"] as String?;
      final level = data["level"] as String?;
      final levelInt = level != null ? int.parse(level) : null;
      final color = data["color"] as String?;

      final room = RoomsTableCompanion.insert(
        name: data["name"],
        description: description != null ? Value(description) : const Value.absent(),
        level: levelInt != null ? Value(levelInt) : const Value.absent(),
        color: color != null ? Value(color) : const Value.absent(),
        icon: roomIcon != null ? Value(roomIcon!) : const Value.absent(),
      );
      await _roomsStore.insertOrUpdateSingle(room);
      return true;
    }
    return false;
  }

  void setIcon(IconData? icon) {
    roomIcon = icon;
    notifyListeners();
  }
}
