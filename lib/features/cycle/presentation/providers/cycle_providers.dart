import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/date_utils.dart';
import '../../data/cycle_entry_model.dart';
import '../../data/cycle_repository.dart';
import '../../domain/cycle_calculator.dart';

final cycleRepositoryProvider = Provider<CycleRepository>((ref) {
  throw UnimplementedError(
    'cycleRepositoryProvider must be overridden in main() once the Hive '
    'box has been opened.',
  );
});

final cycleCalculatorProvider = Provider<CycleCalculator>((ref) {
  return const CycleCalculator();
});

class CycleEntriesNotifier extends StateNotifier<List<CycleEntry>> {
  CycleEntriesNotifier(this._repository)
      : super(_repository.getAllSortedByStartDate());

  final CycleRepository _repository;

  Future<void> addOrUpdate(CycleEntry entry) async {
    await _repository.upsert(entry);
    state = _repository.getAllSortedByStartDate();
  }

  Future<void> delete(String id) async {
    await _repository.delete(id);
    state = _repository.getAllSortedByStartDate();
  }

  CycleEntry? entryCoveringDay(DateTime day) {
    final date = dateOnly(day);
    for (final entry in state) {
      final start = dateOnly(entry.startDate);
      final end =
          entry.endDate == null ? dateOnly(DateTime.now()) : dateOnly(entry.endDate!);
      if (!date.isBefore(start) && !date.isAfter(end)) {
        return entry;
      }
    }
    return null;
  }
}

final cycleEntriesProvider =
    StateNotifierProvider<CycleEntriesNotifier, List<CycleEntry>>((ref) {
  final repository = ref.watch(cycleRepositoryProvider);
  return CycleEntriesNotifier(repository);
});

final cyclePredictionProvider = Provider<CyclePrediction?>((ref) {
  final entries = ref.watch(cycleEntriesProvider);
  final calculator = ref.watch(cycleCalculatorProvider);
  return calculator.predict(entries);
});
