import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class Writer {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/data/data.json');
  }

  Future<int> readCounter() async {
    try {
      final file = await _localFile;

      // Read the file.
      String contents = await file.readAsString();

      return int.parse(contents);
    } catch (e) {
      // If encountering an error, return 0.
      return 0;
    }
  }

  void writeFile(String  newFile) async {
    File file = await _localFile;

    // Write the file.
    return file.writeAsStringSync(newFile, mode: FileMode.append);
  }
}
