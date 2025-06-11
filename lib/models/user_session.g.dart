// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_session.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserSessionAdapter extends TypeAdapter<UserSession> {
  @override
  final int typeId = 0;

  @override
  UserSession read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserSession(
      email: fields[0] as String,
      lastLoginTime: fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, UserSession obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.email)
      ..writeByte(1)
      ..write(obj.lastLoginTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserSessionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
