import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;

class StorageService {
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

  Future<void> downloadFile(String filename) async {
    var fileType = 'image';

    StorageReference storageReference;
    if (fileType == 'image') {
      storageReference =
          FirebaseStorage.instance.ref().child("tallyassist/$filename");
    }

    final String url = await storageReference.getDownloadURL();
    // final String uuid = Uuid().v1();
    await http.get(url);
    final Directory systemTempDir = Directory.systemTemp;
    final File tempFile = File('${systemTempDir.path}/$filename');
    if (tempFile.existsSync()) {
      await tempFile.delete();
    }
    await tempFile.create();
    assert(await tempFile.readAsString() == "");
    // final StorageFileDownloadTask task = storageReference.writeToFile(tempFile);
    // final int byteCount = (await task.future).totalByteCount;
    // final String tempFileContents = await tempFile.readAsString();
    // assert(tempFileContents == kTestString);
    // assert(byteCount == kTestString.length);

    // final String fileContents = downloadData.body;
    // final String name = await storageReference.getName();
    // final String bucket = await storageReference.getBucket();
    // final String path = await storageReference.getPath();
    // _scaffoldKey.currentState.showSnackBar(SnackBar(
    //   content: Text(
    //     'Success!\n Downloaded $name \n from url: $url @ bucket: $bucket\n '
    //     'at path: $path \n\nFile contents: "$fileContents" \n'
    //     'Wrote "$tempFileContents" to tmp.txt',
    //     style: const TextStyle(color: Color.fromARGB(255, 0, 155, 0)),
    //   ),
    // ));
  }
}
