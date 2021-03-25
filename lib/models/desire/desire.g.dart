// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'desire.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DesireAdapter extends TypeAdapter<Desire> {
  @override
  final int typeId = 0;

  @override
  Desire read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Desire(
      title: fields[0] as String,
    )
      ..iconDataStructure = fields[1] as IconDataStructure
      ..description = fields[2] as String
      ..particleModels = (fields[3] as List)?.cast<DesireParticleModel>();
  }

  @override
  void write(BinaryWriter writer, Desire obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.iconDataStructure)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.particleModels);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DesireAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
