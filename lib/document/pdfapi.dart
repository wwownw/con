import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;

class PDFapi {
  //asset 에서 가져오기
  static Future<File> loadAsset(String path) async {
    final data = await rootBundle.load(path);
    final bytes = data.buffer.asUint8List();
    return _storeFile(path, bytes);
  }

  //링크로 pdf 가져오기
  static Future<File> loadNetwork(String url) async {
    final response = await http.get(Uri.parse(url));
    final bytes = response.bodyBytes;

    return _storeFile(url, bytes);
  }

  static Future<File> _storeFile(String url, List<int> bytes) async {
    final filename = basename(url);
    final dir = await getApplicationDocumentsDirectory();

    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }

  //폰 파일에서 가져오기
  static Future<File?> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result == null) return null;
    return File('${result.paths.first}');
  }

  //firebase
  static Future<File?> loadFirebase(String url) async {
    try {
      final refPDF = FirebaseStorage.instance.ref('document').child(url);
      final bytes = await refPDF.getData();
      return _storeFile(url, bytes!);
    } catch (e) {
      return null;
    }
  }
}
