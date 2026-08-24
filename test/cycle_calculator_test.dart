import 'package:cycle_app/features/cycle/data/cycle_entry_model.dart';
import 'package:cycle_app/features/cycle/domain/cycle_calculator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const calculator = CycleCalculator();

  CycleEntry entry(DateTime start, [DateTime? end]) =>
      CycleEntry(id: start.toIso8601String(), startDate: start, endDate: end);

  group('predict', () {
    test('returns null when there are no entries', () {
      expect(calculator.predict([]), isNull);
    });

    test('falls back to defaults with a single entry', () {
      final start = DateTime(2026, 1, 1);
      final prediction = calculator.predict([entry(start)]);

      expect(prediction, isNotNull);
      expect(prediction!.averageCycleLength, 28);
      expect(prediction.averagePeriodLength, 5);
      expect(prediction.nextPeriodStart, DateTime.utc(2026, 1, 29));
      expect(prediction.ovulationDate, DateTime.utc(2026, 1, 15));
      expect(prediction.fertileWindowStart, DateTime.utc(2026, 1, 10));
      expect(prediction.fertileWindowEnd, DateTime.utc(2026, 1, 16));
    });

    test('computes the average cycle length from regular past cycles', () {
      final entries = [
        entry(DateTime(2026, 1, 1), DateTime(2026, 1, 5)),
        entry(DateTime(2026, 1, 29), DateTime(2026, 2, 2)),
        entry(DateTime(2026, 2, 26), DateTime(2026, 3, 2)),
      ];

      final prediction = calculator.predict(entries);

      expect(prediction!.averageCycleLength, 28);
      expect(prediction.averagePeriodLength, 5);
      expect(prediction.nextPeriodStart, DateTime.utc(2026, 3, 26));
      expect(prediction.ovulationDate, DateTime.utc(2026, 3, 12));
    });

    test('averages irregular cycle lengths', () {
      final entries = [
        entry(DateTime(2026, 1, 1)),
        entry(DateTime(2026, 1, 26)), // gap 25
        entry(DateTime(2026, 2, 27)), // gap 32
      ];

      final prediction = calculator.predict(entries);

      // average of 25 and 32 = 28.5 -> rounds to 29 (using .round())
      expect(prediction!.averageCycleLength, 29);
      expect(
        prediction.nextPeriodStart,
        DateTime.utc(2026, 2, 27 + 29), // Feb 27 + 29 days = Mar 28
      );
    });

    test('only considers the most recent maxCyclesConsidered cycles', () {
      const shortHistoryCalculator = CycleCalculator(maxCyclesConsidered: 2);
      final entries = [
        entry(DateTime(2026, 1, 1)), // ignored gap of 20 to next
        entry(DateTime(2026, 1, 21)), // gap 20 -> excluded by window of 2
        entry(DateTime(2026, 2, 20)), // gap 30
        entry(DateTime(2026, 3, 22)), // gap 30
      ];

      final prediction = shortHistoryCalculator.predict(entries);

      expect(prediction!.averageCycleLength, 30);
    });
  });
}
