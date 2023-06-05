import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class Firebase_Storage_Service {
  Reference referenceRoot = FirebaseStorage.instance.ref();

  Future<void> uploadFile(
    String filePath,
    String fileName,
  ) async {
    Reference referenceDirImages = referenceRoot.child('images');
    Reference referenceImageToUpload = referenceDirImages.child(fileName);
    File file = File(filePath);
    try {
      //Store the file
      await referenceImageToUpload.putFile(File(file.path));
      //Success: get the download URL
    } catch (error) {
      //Some error occurred
    }
  }

  Future<String> downloadUrl(String imgName) async {
    Reference referenceDirImages = referenceRoot.child('images');
    Reference referenceImageToUpload = referenceDirImages.child(imgName);

    String downloadUrl = await referenceImageToUpload.getDownloadURL();

    return downloadUrl;
  }

  Future<String> uploadImageToDefaultBucket(File image, String imgName) async {
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref("product_images").child(imgName);
    UploadTask uploadTask = firebaseStorageRef.putFile(image);
    TaskSnapshot taskSnapshot = await uploadTask;
    return taskSnapshot.ref.getDownloadURL();
  }
}
