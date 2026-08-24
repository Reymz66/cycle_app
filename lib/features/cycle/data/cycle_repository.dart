import 'package:hive_flutter/hive_flutter.dart';

import 'cycle_entry_model.dart';

class CycleRepository {
  CycleRepository(this._box);

  static const boxName = 'cycle_entries';

  final Box<CycleEntry> _box;

  static Future<CycleRepository> open() async {
    final box = await Hive.openBox<CycleEntry>(boxName);
    return CycleRepository(box);
  }

  List<CycleEntry> getAllSortedByStartDate() {
    final entries = _box.values.toList();
    entries.sort((a, b) => a.startDate.compareTo(b.startDate));
    return entries;
  }

  Future<void> upsert(CycleEntry entry) => _box.put(entry.id, entry);

  Future<void> delete(String id) => _box.delete(id);
}
