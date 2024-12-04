import 'dart:io';

import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

class LocalStorage {
  Future<String> get localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> localFile(String filename) async {
    final path = await localPath;
    return File('$path/$filename');
  }

  Future<String> readFile(String filename) async {
    try {
      final file = await localFile(filename);
      return await file.readAsString();
    } catch (e) {
      Logger().e("Error reading file $filename: $e");
      return "";
    }
  }

  Future<File> writeFile(String filename, String content) async {
    final file = await localFile(filename);
    return await file.writeAsString(content);
  }
}
