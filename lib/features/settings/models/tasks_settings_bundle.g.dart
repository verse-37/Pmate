// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasks_settings_bundle.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskSettingsBundleAdapter extends TypeAdapter<TaskSettingsBundle> {
  @override
  final int typeId = 2;

  @override
  TaskSettingsBundle read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskSettingsBundle(
      doneTaskOnLeftSwipe: fields[0] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, TaskSettingsBundle obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.doneTaskOnLeftSwipe);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskSettingsBundleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
