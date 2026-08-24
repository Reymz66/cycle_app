import 'package:hive/hive.dart';

part 'symptom_log_model.g.dart';

@HiveType(typeId: 1)
class SymptomLog extends HiveObject {
  SymptomLog({
    required this.id,
    required this.date,
    required this.symptomKeys,
    this.note,
  });

  @HiveField(0)
  final String id;

  @HiveField(1)
  final DateTime date;

  @HiveField(2)
  final List<String> symptomKeys;

  @HiveField(3)
  final String? note;
}
