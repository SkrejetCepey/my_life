// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'particle_checkbox.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ParticleCheckboxAdapter extends TypeAdapter<ParticleCheckbox> {
  @override
  final int typeId = 1;

  @override
  ParticleCheckbox read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ParticleCheckbox(
      title: fields[1] as String,
      state: fields[2] as bool,
      dateTime: fields[3] as DateTime,
      id: fields[0] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ParticleCheckbox obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.state)
      ..writeByte(3)
      ..write(obj.dateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ParticleCheckboxAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
