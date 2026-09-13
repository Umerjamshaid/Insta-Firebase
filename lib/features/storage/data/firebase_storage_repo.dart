import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:insta/features/storage/domain/storage_repo.dart';

class FirebaseStorageRepo implements StorageRepo {
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  @override
  Future<String?> uploadProfileImageMobil(String path, String fileName) {
    return _uploadFile(path, fileName, "profile_images");
  }

  @override
  Future<String?> uploadProfileImageWeb(Uint8List fileBytes, String fileName) {
    return _uploadFileBytes(fileBytes, fileName, "profile_images");
  }

  /*

  Firebase Storage Repo
  helper class for uploading images to firebase storage/supabase storage

  */

  //mobile platforms Files Upload (Files)
  Future<String?> _uploadFile(
    String path,
    String fileName,
    String folder,
  ) async {
    try {
      //Get a file reference etc..
      final file = File(path);

      //find a place to store it..
      final storageRef = firebaseStorage.ref().child('$folder/$fileName');

      //Upload the file..
      final uploadTask = await storageRef.putFile(file);

      //get Image download url
      final downloadUrl = await uploadTask.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      return null;
    }
  }

  //Web Platform Files Upload (Bytes)
  Future<String?> _uploadFileBytes(
    Uint8List fileBytes,
    String fileName,
    String folder,
  ) async {
    try {
      //find a place to store it..
      final storageRef = firebaseStorage.ref().child('$folder/$fileName');

      //Upload the file..
      final uploadTask = await storageRef.putData(fileBytes);

      //get Image download url
      final downloadUrl = await uploadTask.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      return null;
    }
  }
}
