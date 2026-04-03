import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freecodecamp_flutter_course/core/constants/app_constants.dart';

class UserModel {
  final String uid;
  final String email;
  final String photoUrl;
  final String displayName;

  const UserModel({
    required this.uid,
    required this.email,
    required this.photoUrl,
    required this.displayName,
  });

  factory UserModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;

    return UserModel(
      uid: doc.id,
      email: data[AppConstants.fieldEmail] as String? ?? '',
      photoUrl: data[AppConstants.fieldPhotoUrl] as String? ?? '',
      displayName: data[AppConstants.fieldDisplayName] as String? ?? '',
    );
  }

  Map<String, dynamic> toFirestore() => {
    AppConstants.fieldUid: uid,
    AppConstants.fieldEmail: email,
    AppConstants.fieldPhotoUrl: photoUrl,
    AppConstants.fieldDisplayName: displayName,
  };

  UserModel copyWith({String? displayName, String? photoUrl}) {
    return UserModel(
      uid: uid,
      email: email,
      photoUrl: photoUrl ?? this.photoUrl,
      displayName: displayName ?? this.displayName,
    );
  }
}
