// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 3;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      username: fields[1] as String,
      login: fields[2] as String,
      password: fields[3] as String,
      firstName: fields[4] as String,
      lastName: fields[5] as String,
      city: fields[6] as String,
      email: fields[7] as String,
      accessToken: fields[9] as String,
      refreshToken: fields[10] as String,
      role: fields[11] as String,
    )
      ..id = fields[0] as String
      ..desiresList = (fields[8] as List)?.cast<Desire>()
      ..goalsList = (fields[12] as List)?.cast<Desire>();
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.username)
      ..writeByte(2)
      ..write(obj.login)
      ..writeByte(3)
      ..write(obj.password)
      ..writeByte(4)
      ..write(obj.firstName)
      ..writeByte(5)
      ..write(obj.lastName)
      ..writeByte(6)
      ..write(obj.city)
      ..writeByte(7)
      ..write(obj.email)
      ..writeByte(8)
      ..write(obj.desiresList)
      ..writeByte(9)
      ..write(obj.accessToken)
      ..writeByte(10)
      ..write(obj.refreshToken)
      ..writeByte(11)
      ..write(obj.role)
      ..writeByte(12)
      ..write(obj.goalsList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
