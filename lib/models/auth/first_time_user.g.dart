// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'first_time_user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FirstTimeUserAdapter extends TypeAdapter<FirstTimeUser> {
  @override
  final int typeId = 1;

  @override
  FirstTimeUser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FirstTimeUser(
      firstTimeUserBool: fields[0] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, FirstTimeUser obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.firstTimeUserBool);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FirstTimeUserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
