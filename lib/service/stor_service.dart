import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

import 'logger.dart';

class StoreService {
  static final storage = FirebaseStorage.instance.ref();
  //name of image folder
  static const folder = "post_images";

  static Future<String> uploadImage(File image) async {
    String imgName = "image_${DateTime.now()}";
    var firebaseStorageRef = storage.child(folder).child(imgName);
    var uploadTask = firebaseStorageRef.putFile(image);
    final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => {});
    String downloadUrl = await firebaseStorageRef.getDownloadURL();
    LogService.i(downloadUrl);
    return downloadUrl;
  }
}
