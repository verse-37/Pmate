// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_communicator.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskCommunicatorAdapter extends TypeAdapter<TaskCommunicator> {
  @override
  final int typeId = 0;

  @override
  TaskCommunicator read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskCommunicator(
      title: fields[0] as String,
      description: fields[1] as String,
      status: fields[4] as int,
      createdAt: fields[3] as String,
      checkListNames: (fields[5] as List).cast<String>(),
      checkListCompletion: (fields[6] as List).cast<bool>(),
      difficulty: fields[7] as int,
    );
  }

  @override
  void write(BinaryWriter writer, TaskCommunicator obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.createdAt)
      ..writeByte(4)
      ..write(obj.status)
      ..writeByte(5)
      ..write(obj.checkListNames)
      ..writeByte(6)
      ..write(obj.checkListCompletion)
      ..writeByte(7)
      ..write(obj.difficulty);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskCommunicatorAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}