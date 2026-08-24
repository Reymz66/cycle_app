// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'symptom_log_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SymptomLogAdapter extends TypeAdapter<SymptomLog> {
  @override
  final int typeId = 1;

  @override
  SymptomLog read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SymptomLog(
      id: fields[0] as String,
      date: fields[1] as DateTime,
      symptomKeys: (fields[2] as List).cast<String>(),
      note: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SymptomLog obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.symptomKeys)
      ..writeByte(3)
      ..write(obj.note);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SymptomLogAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
