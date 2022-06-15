// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'office.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OfficeAdapter extends TypeAdapter<Office> {
  @override
  final int typeId = 3;

  @override
  Office read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Office(
      id: fields[0] == null ? 0 : fields[0] as int,
      employee: fields[1] as int,
      designation: fields[2] as String,
      department: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Office obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.employee)
      ..writeByte(2)
      ..write(obj.designation)
      ..writeByte(3)
      ..write(obj.department);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OfficeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
