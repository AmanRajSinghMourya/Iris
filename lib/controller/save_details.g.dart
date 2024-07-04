// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_details.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SaveDetailsAdapter extends TypeAdapter<SaveDetails> {
  @override
  final int typeId = 0;

  @override
  SaveDetails read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SaveDetails()
      ..productDetail = fields[0] as String?
      ..remarks = fields[1] as String?
      ..region = fields[2] as String?
      ..nextCommunication = fields[3] as String?
      ..leadStatus = fields[4] as String?
      ..cardData = fields[5] as String?;
  }

  @override
  void write(BinaryWriter writer, SaveDetails obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.productDetail)
      ..writeByte(1)
      ..write(obj.remarks)
      ..writeByte(2)
      ..write(obj.region)
      ..writeByte(3)
      ..write(obj.nextCommunication)
      ..writeByte(4)
      ..write(obj.leadStatus)
      ..writeByte(5)
      ..write(obj.cardData);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SaveDetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
