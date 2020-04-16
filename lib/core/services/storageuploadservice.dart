import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class UploadService {

  Future<void> uploadFile(File file, String filename) async {
    var fileType = 'image';

    StorageReference storageReference;
    if (fileType == 'image') {
      storageReference =
          FirebaseStorage.instance.ref().child("tallyassist/$filename");
    }
    // if (fileType == 'audio') {
    //   storageReference =
    //     FirebaseStorage.instance.ref().child("audio/$filename");
    // }
    // if (fileType == 'video') {
    //   storageReference =
    //     FirebaseStorage.instance.ref().child("videos/$filename");
    // }
    // if (fileType == 'pdf') {
    //   storageReference =
    //     FirebaseStorage.instance.ref().child("pdf/$filename");
    // }
    // if (fileType == 'others') {
    //   storageReference =
    //     FirebaseStorage.instance.ref().child("others/$filename");
    // }
    final StorageUploadTask uploadTask = storageReference.putFile(file);
    final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
    final String url = (await downloadUrl.ref.getDownloadURL());
    print("URL is $url");
  }
}
