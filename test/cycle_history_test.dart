import 'package:cycle_app/features/cycle/data/cycle_entry_model.dart';
import 'package:cycle_app/features/cycle/data/symptom_log_model.dart';
import 'package:cycle_app/features/cycle/domain/cycle_history.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  CycleEntry entry(DateTime start, [DateTime? end]) =>
      CycleEntry(id: start.toIso8601String(), startDate: start, endDate: end);

  SymptomLog log(DateTime date, List<String> keys) => SymptomLog(
        id: date.toIso8601String(),
        date: date,
        symptomKeys: keys,
      );

  test('returns an empty list when there are no entries', () {
    expect(buildCycleHistory([], []), isEmpty);
  });

  test('computes period and cycle length, most recent first', () {
    final entries = [
      entry(DateTime(2026, 1, 1), DateTime(2026, 1, 5)), // 5-day period
      entry(DateTime(2026, 1, 29), DateTime(2026, 2, 2)), // 5-day period
    ];

    final history = buildCycleHistory(entries, []);

    expect(history, hasLength(2));
    // Most recent cycle first.
    expect(history[0].periodEntry.startDate, DateTime(2026, 1, 29));
    expect(history[0].periodLength, 5);
    expect(history[0].cycleLength, isNull); // no next entry yet

    expect(history[1].periodEntry.startDate, DateTime(2026, 1, 1));
    expect(history[1].periodLength, 5);
    expect(history[1].cycleLength, 28); // Jan 1 -> Jan 29
  });

  test('treats an ongoing period (no end date) as lasting until today', () {
    final today = DateTime.now();
    final entries = [entry(today.subtract(const Duration(days: 2)))];

    final history = buildCycleHistory(entries, []);

    expect(history.single.periodLength, 3); // start, start+1, today inclusive
    expect(history.single.cycleLength, isNull);
  });

  test('assigns symptom logs to the cycle they fall within', () {
    final entries = [
      entry(DateTime(2026, 1, 1), DateTime(2026, 1, 5)),
      entry(DateTime(2026, 1, 29), DateTime(2026, 2, 2)),
    ];
    final logs = [
      log(DateTime(2026, 1, 10), ['fatigue']), // belongs to the first cycle
      log(DateTime(2026, 1, 28), ['bloating']), // last day before next period
      log(DateTime(2026, 1, 29), ['cramps']), // belongs to the second cycle
    ];

    final history = buildCycleHistory(entries, logs);

    final firstCycle = history.firstWhere(
      (h) => h.periodEntry.startDate == DateTime(2026, 1, 1),
    );
    final secondCycle = history.firstWhere(
      (h) => h.periodEntry.startDate == DateTime(2026, 1, 29),
    );

    expect(firstCycle.symptomLogs.map((l) => l.symptomKeys.first), [
      'fatigue',
      'bloating',
    ]);
    expect(secondCycle.symptomLogs.map((l) => l.symptomKeys.first), [
      'cramps',
    ]);
  });
}
