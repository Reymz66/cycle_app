import '../../../core/utils/date_utils.dart';
import '../data/cycle_entry_model.dart';

class CyclePrediction {
  const CyclePrediction({
    required this.averageCycleLength,
    required this.averagePeriodLength,
    required this.nextPeriodStart,
    required this.ovulationDate,
    required this.fertileWindowStart,
    required this.fertileWindowEnd,
  });

  final int averageCycleLength;
  final int averagePeriodLength;
  final DateTime nextPeriodStart;
  final DateTime ovulationDate;
  final DateTime fertileWindowStart;
  final DateTime fertileWindowEnd;
}

class CycleCalculator {
  const CycleCalculator({
    this.defaultCycleLength = 28,
    this.defaultPeriodLength = 5,
    this.lutealPhaseLength = 14,
    this.fertileWindowDaysBeforeOvulation = 5,
    this.fertileWindowDaysAfterOvulation = 1,
    this.maxCyclesConsidered = 6,
  });

  final int defaultCycleLength;
  final int defaultPeriodLength;
  final int lutealPhaseLength;
  final int fertileWindowDaysBeforeOvulation;
  final int fertileWindowDaysAfterOvulation;
  final int maxCyclesConsidered;

  /// [entries] must be sorted by ascending [CycleEntry.startDate].
  /// Returns null when there is no entry to base a prediction on.
  CyclePrediction? predict(List<CycleEntry> entries) {
    if (entries.isEmpty) return null;

    final avgCycleLength = _averageCycleLength(entries);
    final avgPeriodLength = _averagePeriodLength(entries);

    final lastStart = dateOnly(entries.last.startDate);
    final nextPeriodStart = lastStart.add(Duration(days: avgCycleLength));
    final ovulationDate =
        nextPeriodStart.subtract(Duration(days: lutealPhaseLength));

    return CyclePrediction(
      averageCycleLength: avgCycleLength,
      averagePeriodLength: avgPeriodLength,
      nextPeriodStart: nextPeriodStart,
      ovulationDate: ovulationDate,
      fertileWindowStart: ovulationDate
          .subtract(Duration(days: fertileWindowDaysBeforeOvulation)),
      fertileWindowEnd:
          ovulationDate.add(Duration(days: fertileWindowDaysAfterOvulation)),
    );
  }

  int _averageCycleLength(List<CycleEntry> entries) {
    if (entries.length < 2) return defaultCycleLength;

    final recent = entries.length > maxCyclesConsidered
        ? entries.sublist(entries.length - maxCyclesConsidered)
        : entries;

    final gaps = <int>[];
    for (var i = 1; i < recent.length; i++) {
      final gap = dateOnly(recent[i].startDate)
          .difference(dateOnly(recent[i - 1].startDate))
          .inDays;
      if (gap > 0) gaps.add(gap);
    }

    if (gaps.isEmpty) return defaultCycleLength;
    return (gaps.reduce((a, b) => a + b) / gaps.length).round();
  }

  int _averagePeriodLength(List<CycleEntry> entries) {
    final completed = entries.where((e) => e.endDate != null).toList();
    final recent = completed.length > maxCyclesConsidered
        ? completed.sublist(completed.length - maxCyclesConsidered)
        : completed;

    if (recent.isEmpty) return defaultPeriodLength;

    final lengths = recent
        .map((e) =>
            dateOnly(e.endDate!).difference(dateOnly(e.startDate)).inDays + 1)
        .where((length) => length > 0)
        .toList();

    if (lengths.isEmpty) return defaultPeriodLength;
    return (lengths.reduce((a, b) => a + b) / lengths.length).round();
  }
}
