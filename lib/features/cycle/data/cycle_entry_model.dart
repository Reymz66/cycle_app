import 'package:hive/hive.dart';

part 'cycle_entry_model.g.dart';

@HiveType(typeId: 0)
class CycleEntry extends HiveObject {
  CycleEntry({
    required this.id,
    required this.startDate,
    this.endDate,
  });

  @HiveField(0)
  final String id;

  @HiveField(1)
  final DateTime startDate;

  @HiveField(2)
  final DateTime? endDate;

  bool get isOngoing => endDate == null;

  CycleEntry copyWith({DateTime? startDate, DateTime? endDate}) {
    return CycleEntry(
      id: id,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }
}
