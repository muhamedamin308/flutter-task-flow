import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:freecodecamp_flutter_course/core/constants/app_constants.dart';

class StorageService {
  final FirebaseStorage _storage;

  StorageService({FirebaseStorage? storage})
    : _storage = storage ?? FirebaseStorage.instance;

  Future<String> uploadProfilePicture({
    required String uid,
    required File imageFile,
    void Function(double progress)? onProgress,
  }) async {
    final ref = _storage
        .ref()
        .child(AppConstants.profilePicturesPath)
        .child('$uid.jpg');

    final uploadTask = ref.putFile(
      imageFile,
      SettableMetadata(contentType: 'image/jpeg'),
    );

    if (onProgress != null) {
      uploadTask.snapshotEvents.listen((snapshot) {
        final progerss = snapshot.bytesTransferred / snapshot.totalBytes;
        onProgress(progerss);
      });
    }

    await uploadTask;

    return ref.getDownloadURL();
  }

  Future<void> deleteProfilePicture(String uid) async {
    try {
      await _storage
          .ref()
          .child(AppConstants.profilePicturesPath)
          .child('$uid.jpg')
          .delete();
    } on FirebaseException catch (e) {
      if (e.code != 'object-not-found') {
        rethrow;
      }
    }
  }
}
