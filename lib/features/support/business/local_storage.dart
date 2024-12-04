import 'dart:io';

import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

class LocalStorage {
  Future<String> get localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<String> get cachePath async {
    final directory = await getTemporaryDirectory();
    return directory.path;
  }

  Future<File> localFile(String filename, {required bool isPermanent}) async {
    final path = isPermanent ? await localPath : await cachePath;
    return File('$path/$filename');
  }

  Future<String> readFile(String filename, {required bool isPermanent}) async {
    try {
      final file = await localFile(filename, isPermanent: isPermanent);
      return await file.readAsString();
    } catch (e) {
      Logger().e("Error reading file $filename: $e");
      return "";
    }
  }

  Future<File> writeFile(String filename, String content,
      {required bool isPermanent}) async {
    final file = await localFile(filename, isPermanent: isPermanent);
    return await file.writeAsString(content);
  }
}
