import '../../../core/utils/date_utils.dart';
import '../data/cycle_entry_model.dart';
import 'cycle_calculator.dart';

enum CyclePhase { menstrual, follicular, ovulatory, luteal }

CyclePhase currentPhase(
  DateTime today,
  List<CycleEntry> entries,
  CyclePrediction prediction,
) {
  final date = dateOnly(today);

  for (final entry in entries) {
    final start = dateOnly(entry.startDate);
    final end = entry.endDate == null ? start : dateOnly(entry.endDate!);
    if (!date.isBefore(start) && !date.isAfter(end)) {
      return CyclePhase.menstrual;
    }
  }

  if (!date.isBefore(prediction.nextPeriodStart)) {
    return CyclePhase.menstrual;
  }

  if (!date.isBefore(prediction.fertileWindowStart) &&
      !date.isAfter(prediction.fertileWindowEnd)) {
    return CyclePhase.ovulatory;
  }

  if (date.isAfter(prediction.fertileWindowEnd)) {
    return CyclePhase.luteal;
  }

  return CyclePhase.follicular;
}
