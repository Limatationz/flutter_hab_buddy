import 'package:rxdart/rxdart.dart';
import 'package:stacked/stacked.dart';

import '../../../core/database/app_database.dart';
import '../../../locator.dart';

class RoomsViewModel extends BaseViewModel {
  final _roomsStore = locator<AppDatabase>().roomsStore;
  final _itemsStore = locator<AppDatabase>().itemsStore;
  final _inboxStore = locator<AppDatabase>().inboxStore;

  Stream<int> get countInboxStream => _inboxStore.count();

  Stream<List<Room>> get roomsStream => _roomsStore.all().watch();

  Stream<bool> get hasRoomsStream =>
      _roomsStore.all().watch().map((event) => event.isNotEmpty);
  final BehaviorSubject<int?> _currentRoomIdSubject =
      BehaviorSubject.seeded(null);

  Stream<int?> get currentRoomIdStream => _currentRoomIdSubject.stream;

  final BehaviorSubject<List<Item>> _itemsOfCurrentRoomSubject =
      BehaviorSubject.seeded([]);

  Stream<List<Item>> get itemsOfCurrentRoomStream =>
      _itemsOfCurrentRoomSubject.stream;

  RoomsViewModel() {
    // init _currentRoomIdSubject with first room
    _roomsStore.all().watch().listen((value) {
      if (value.isNotEmpty && _currentRoomIdSubject.valueOrNull == null) {
        _currentRoomIdSubject.add(value.first.id);
      }
    });

    _currentRoomIdSubject.listen((value) {
      if (value == null) {
        _itemsOfCurrentRoomSubject.add([]);
      } else {
        // add items of selected room to _itemsOfCurrentRoomSubject
        _itemsStore
            .byRoomId(value)
            .watch()
            .listen(_itemsOfCurrentRoomSubject.add);
      }
    });
  }

  void onRoomChange(Room? room) {
    _currentRoomIdSubject.add(room?.id);
  }

  Future<void> toNextRoom() async {
    final currentRoomId = _currentRoomIdSubject.valueOrNull;
    if (currentRoomId == null) {
      return;
    }
    final rooms = await _roomsStore.all().get();
    final index = rooms.indexWhere((element) => element.id == currentRoomId);
    if (index == -1) {
      return;
    }
    final nextIndex = index + 1;
    if (nextIndex >= rooms.length) {
      _currentRoomIdSubject.add(rooms.first.id);
    } else {
      _currentRoomIdSubject.add(rooms[nextIndex].id);
    }
  }

  Future<void> toPreviousRoom() async {
    final currentRoomId = _currentRoomIdSubject.valueOrNull;
    if (currentRoomId == null) {
      return;
    }
    final rooms = await _roomsStore.all().get();
    final index = rooms.indexWhere((element) => element.id == currentRoomId);
    if (index == -1) {
      return;
    }
    final previousIndex = index - 1;
    if (previousIndex < 0) {
      _currentRoomIdSubject.add(rooms.last.id);
    } else {
      _currentRoomIdSubject.add(rooms[previousIndex].id);
    }
  }
}
