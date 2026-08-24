import 'package:hive_flutter/hive_flutter.dart';

import 'symptom_log_model.dart';

class SymptomRepository {
  SymptomRepository(this._box);

  static const boxName = 'symptom_logs';

  final Box<SymptomLog> _box;

  static Future<SymptomRepository> open() async {
    final box = await Hive.openBox<SymptomLog>(boxName);
    return SymptomRepository(box);
  }

  List<SymptomLog> getAll() => _box.values.toList();

  Future<void> upsert(SymptomLog log) => _box.put(log.id, log);

  Future<void> delete(String id) => _box.delete(id);
}
