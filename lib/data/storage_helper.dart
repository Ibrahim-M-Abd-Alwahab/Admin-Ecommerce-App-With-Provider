import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageHelper {
  static StorageHelper storageHelper = StorageHelper();
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  // uploadImage method  ==> It will upload a file in firestorage and return the link
  Future<String> uploadImage(File file) async {
    String fileName = file.path.split('/').last;
    // How or Where do I want to upload the file in #fireStorage
    Reference reference = firebaseStorage.ref('images/$fileName');
    
    //  It hasn't started uploading the file
    // UploadTask uploadTask = reference.putFile(file);

    // taskSnapshot ==> The file which uploaded
    TaskSnapshot taskSnapshot = await reference.putFile(file);

    /*
      switch (taskSnapshot.state) {
        case TaskState.running:
          final progress =
              100.0 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
          print("Upload is $progress% complete.");
          break;
        case TaskState.paused:
          print("Upload is paused.");
          break;
        case TaskState.success:
          // ...
          break;
        case TaskState.canceled:
          print("Upload was canceled");
          break;
        case TaskState.error:
          // ...
          break;
      }
    */

    // fetch image link to use it within the app
    String imageUrl = await reference.getDownloadURL();
    return imageUrl;
  }
}
