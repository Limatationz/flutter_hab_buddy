import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/database/app_database.dart';
import '../../../../locator.dart';
import '../../../util/constants.dart';

showRoomsSortSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    builder: (context) {
      return const RoomsSortSheet();
    },
  );
}

class RoomsSortSheet extends StatefulWidget {
  final int? currentRoomId;

  const RoomsSortSheet({super.key, this.currentRoomId});

  @override
  _RoomsSortSheetState createState() => _RoomsSortSheetState();
}

class _RoomsSortSheetState extends State<RoomsSortSheet> {
  final _roomsStore = locator<AppDatabase>().roomsStore;

  List<Room>? rooms;

  @override
  void initState() {
    super.initState();
    _loadRooms();
  }

  void _loadRooms() async {
    final allRooms = await _roomsStore.all().get();
    setState(() {
      rooms = allRooms;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        minimum: const EdgeInsets.all(paddingScaffold),
        child: Column(
          children: [
            Text(
              "Sort Rooms",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Gap(marginContainer),
            if (rooms == null)
              const Center(
                  child: SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(),
              ))
            else if (rooms?.isEmpty ?? true)
              const Center(child: Text("No rooms created"))
            else
              Expanded(
                child: ReorderableListView(
                  onReorder: (oldIndex, newIndex) {
                    _roomsStore.updateSortKey(oldIndex, newIndex).then((_) {
                      _loadRooms();
                    });
                  },
                  children: rooms!.map((room) {
                    return ListTile(
                      key: ValueKey(room.sortKey),
                      title: Text(room.name),
                      trailing: const Icon(Icons.drag_handle),
                      contentPadding: const EdgeInsets.all(0),
                    );
                  }).toList(),
                ),
              ),
          ],
        ));
  }
}
