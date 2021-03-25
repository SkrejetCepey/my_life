// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'icon_data_structure.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IconDataStructureAdapter extends TypeAdapter<IconDataStructure> {
  @override
  final int typeId = 2;

  @override
  IconDataStructure read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IconDataStructure(fields[0] as int, fields[1] as String);
  }

  @override
  void write(BinaryWriter writer, IconDataStructure obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj._unicode)
      ..writeByte(1)
      ..write(obj._fontFamily);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IconDataStructureAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
