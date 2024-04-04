// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserCardAdapter extends TypeAdapter<UserCard> {
  @override
  final int typeId = 3;

  @override
  UserCard read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserCard(
      cardId: fields[0] as int,
      cardNumber: fields[1] as String,
      expirationDate: fields[2] as DateTime,
      status: fields[3] as String,
      userId: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, UserCard obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.cardId)
      ..writeByte(1)
      ..write(obj.cardNumber)
      ..writeByte(2)
      ..write(obj.expirationDate)
      ..writeByte(3)
      ..write(obj.status)
      ..writeByte(4)
      ..write(obj.userId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserCardAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
