import '../../../core/utils/date_utils.dart';
import '../data/cycle_entry_model.dart';
import '../data/symptom_log_model.dart';

class CycleHistoryEntry {
  const CycleHistoryEntry({
    required this.periodEntry,
    required this.periodLength,
    required this.cycleLength,
    required this.symptomLogs,
  });

  final CycleEntry periodEntry;
  final int periodLength;
  final int? cycleLength;
  final List<SymptomLog> symptomLogs;
}

/// [sortedEntries] must be sorted by ascending [CycleEntry.startDate], as
/// returned by `CycleRepository.getAllSortedByStartDate()`.
/// Returns cycles ordered most-recent-first.
List<CycleHistoryEntry> buildCycleHistory(
  List<CycleEntry> sortedEntries,
  List<SymptomLog> symptomLogs,
) {
  final today = dateOnly(DateTime.now());
  final history = <CycleHistoryEntry>[];

  for (var i = 0; i < sortedEntries.length; i++) {
    final entry = sortedEntries[i];
    final start = dateOnly(entry.startDate);
    final hasNext = i + 1 < sortedEntries.length;

    final periodLength = entry.endDate == null
        ? today.difference(start).inDays + 1
        : dateOnly(entry.endDate!).difference(start).inDays + 1;

    final cycleLength =
        hasNext ? dateOnly(sortedEntries[i + 1].startDate).difference(start).inDays : null;

    final spanEnd = hasNext
        ? dateOnly(sortedEntries[i + 1].startDate).subtract(const Duration(days: 1))
        : today;

    final logsInCycle = symptomLogs.where((log) {
      final date = dateOnly(log.date);
      return !date.isBefore(start) && !date.isAfter(spanEnd);
    }).toList();

    history.add(CycleHistoryEntry(
      periodEntry: entry,
      periodLength: periodLength,
      cycleLength: cycleLength,
      symptomLogs: logsInCycle,
    ));
  }

  return history.reversed.toList();
}
