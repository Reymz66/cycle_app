import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/date_utils.dart';
import '../../data/symptom_log_model.dart';
import '../../data/symptom_repository.dart';

final symptomRepositoryProvider = Provider<SymptomRepository>((ref) {
  throw UnimplementedError(
    'symptomRepositoryProvider must be overridden in main() once the Hive '
    'box has been opened.',
  );
});

class SymptomLogsNotifier extends StateNotifier<List<SymptomLog>> {
  SymptomLogsNotifier(this._repository) : super(_repository.getAll());

  final SymptomRepository _repository;

  Future<void> upsert(SymptomLog log) async {
    await _repository.upsert(log);
    state = _repository.getAll();
  }

  Future<void> delete(String id) async {
    await _repository.delete(id);
    state = _repository.getAll();
  }

  SymptomLog? entryForDay(DateTime day) {
    final date = dateOnly(day);
    for (final log in state) {
      if (dateOnly(log.date) == date) return log;
    }
    return null;
  }
}

final symptomLogsProvider =
    StateNotifierProvider<SymptomLogsNotifier, List<SymptomLog>>((ref) {
  final repository = ref.watch(symptomRepositoryProvider);
  return SymptomLogsNotifier(repository);
});
