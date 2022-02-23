import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';

class Storage {
  Future<String> get _localPath async {
    // Application documents directory: /data/user/0/{package_name}/{app_name}
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File("$path/counter.txt");
  }

 Future<String> readData () async {
    final file = await _localFile;
    String body = await file.readAsString();
    return body;
  }

  Future<File> writeData (String data) async {
    final file = await _localFile;
    return file.writeAsString(data, mode: FileMode.append);
  }

  Future<File> rewriteStorage (List<double> data) async {
    final file = await _localFile;
    String stringData = data.join(",");
    stringData.replaceAll(",", "0,1.0,");
    stringData += "0,1.0,";
    return file.writeAsString(stringData);
  }

  Future<File> clearData () async {
    final file = await _localFile;
    return file.writeAsString("");
  }
}