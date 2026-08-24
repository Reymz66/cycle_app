import 'package:cycle_app/features/cycle/data/cycle_entry_model.dart';
import 'package:cycle_app/features/cycle/domain/cycle_calculator.dart';
import 'package:cycle_app/features/cycle/domain/cycle_phase.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const calculator = CycleCalculator();

  final entries = [
    CycleEntry(
      id: '1',
      startDate: DateTime(2026, 1, 1),
      endDate: DateTime(2026, 1, 5),
    ),
  ];
  // With a single 5-day entry: nextPeriodStart = Jan 29, ovulation = Jan 15,
  // fertile window = Jan 10 - Jan 16.
  final prediction = calculator.predict(entries)!;

  test('is menstrual on a day covered by a logged period', () {
    expect(
      currentPhase(DateTime(2026, 1, 3), entries, prediction),
      CyclePhase.menstrual,
    );
  });

  test('is follicular after the period and before the fertile window', () {
    expect(
      currentPhase(DateTime(2026, 1, 8), entries, prediction),
      CyclePhase.follicular,
    );
  });

  test('is ovulatory within the fertile window', () {
    expect(
      currentPhase(DateTime(2026, 1, 12), entries, prediction),
      CyclePhase.ovulatory,
    );
  });

  test('is luteal after the fertile window and before the next period', () {
    expect(
      currentPhase(DateTime(2026, 1, 20), entries, prediction),
      CyclePhase.luteal,
    );
  });

  test('is menstrual once the predicted period has started, even if late',
      () {
    expect(
      currentPhase(DateTime(2026, 1, 29), entries, prediction),
      CyclePhase.menstrual,
    );
    expect(
      currentPhase(DateTime(2026, 2, 3), entries, prediction),
      CyclePhase.menstrual,
    );
  });
}
