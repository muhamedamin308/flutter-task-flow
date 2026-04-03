import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freecodecamp_flutter_course/data/services/auth_service.dart';
import 'package:freecodecamp_flutter_course/data/services/firestore_service.dart';
import 'package:freecodecamp_flutter_course/data/services/storage_service.dart';

final authServiceProvider = Provider<AuthService>((ref) => AuthService());

final firestoreServiceProvider = Provider<FirestoreService>(
  (ref) => FirestoreService(),
);

final storageServiceProvider = Provider<StorageService>(
  (ref) => StorageService(),
);

final authStateProvider = StreamProvider<User?>(
  (ref) => ref.watch(authServiceProvider).authStateChanges,
);

final currentUserProvider = Provider<User?>(
  (ref) => ref.watch(authStateProvider).asData?.value,
);
