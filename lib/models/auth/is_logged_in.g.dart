// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'is_logged_in.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IsLoggedInAdapter extends TypeAdapter<IsLoggedIn> {
  @override
  final int typeId = 3;

  @override
  IsLoggedIn read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IsLoggedIn(
      fields[0] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, IsLoggedIn obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.isLoggedIn);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IsLoggedInAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
