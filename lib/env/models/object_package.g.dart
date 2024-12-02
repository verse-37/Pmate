// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'object_package.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ObjectPackageAdapter extends TypeAdapter<ObjectPackage> {
  @override
  final int typeId = 1;

  @override
  ObjectPackage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ObjectPackage(
      intProperties: (fields[0] as Map).cast<String, int>(),
      listIntProperties: (fields[1] as Map).map((dynamic k, dynamic v) =>
          MapEntry(k as String, (v as List).cast<int>())),
      stringProperties: (fields[2] as Map).cast<String, String>(),
      listStringProperties: (fields[3] as Map).map((dynamic k, dynamic v) =>
          MapEntry(k as String, (v as List).cast<String>())),
      boolProperties: (fields[4] as Map).cast<String, bool>(),
      listBoolProperties: (fields[5] as Map).map((dynamic k, dynamic v) =>
          MapEntry(k as String, (v as List).cast<bool>())),
      doubleProperties: (fields[6] as Map).cast<String, double>(),
      listDoubleProperties: (fields[7] as Map).map((dynamic k, dynamic v) =>
          MapEntry(k as String, (v as List).cast<double>())),
    );
  }

  @override
  void write(BinaryWriter writer, ObjectPackage obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.intProperties)
      ..writeByte(1)
      ..write(obj.listIntProperties)
      ..writeByte(2)
      ..write(obj.stringProperties)
      ..writeByte(3)
      ..write(obj.listStringProperties)
      ..writeByte(4)
      ..write(obj.boolProperties)
      ..writeByte(5)
      ..write(obj.listBoolProperties)
      ..writeByte(6)
      ..write(obj.doubleProperties)
      ..writeByte(7)
      ..write(obj.listDoubleProperties);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ObjectPackageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
