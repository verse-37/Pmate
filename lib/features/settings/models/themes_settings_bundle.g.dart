// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'themes_settings_bundle.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ThemeSettingsBundleAdapter extends TypeAdapter<ThemeSettingsBundle> {
  @override
  final int typeId = 1;

  @override
  ThemeSettingsBundle read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ThemeSettingsBundle(
      themeMode: fields[0] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ThemeSettingsBundle obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.themeMode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ThemeSettingsBundleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
