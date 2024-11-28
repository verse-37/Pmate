// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'difficulty.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DifficultyAdapter extends TypeAdapter<Difficulty> {
  @override
  final int typeId = 2;

  @override
  Difficulty read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Difficulty.veryEasy;
      case 1:
        return Difficulty.easy;
      case 2:
        return Difficulty.medium;
      case 3:
        return Difficulty.hard;
      case 4:
        return Difficulty.veryHard;
      default:
        return Difficulty.veryEasy;
    }
  }

  @override
  void write(BinaryWriter writer, Difficulty obj) {
    switch (obj) {
      case Difficulty.veryEasy:
        writer.writeByte(0);
        break;
      case Difficulty.easy:
        writer.writeByte(1);
        break;
      case Difficulty.medium:
        writer.writeByte(2);
        break;
      case Difficulty.hard:
        writer.writeByte(3);
        break;
      case Difficulty.veryHard:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DifficultyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
