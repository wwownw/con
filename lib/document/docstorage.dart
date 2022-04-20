import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class DocStorage {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<void> uploadFile(
    String filePath,
    String fileName,
  ) async {
    File file = File(filePath);

    try {
      await storage.ref('document/$fileName').putFile(file);
    } on firebase_storage.FirebaseException catch (e) {
      print(e);
    }
  }

  Future<firebase_storage.ListResult> listFiles() async {
    firebase_storage.ListResult result =
        await storage.ref('document').listAll();
    for (var ref in result.items) {
      print('found file: $ref');
    }
    return result;
  }
}
