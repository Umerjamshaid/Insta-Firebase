import 'dart:typed_data';

abstract class StorageRepo {
  //Upload profile image  to mobile platform
  Future<String?> uploadProfileImageMobil(String path, String fileName);

  //ANd for the web platforms as well , although i am not creating and web or pc versions.
  Future<String?> uploadProfileImageWeb(Uint8List fileBytes, String fileName);
}
