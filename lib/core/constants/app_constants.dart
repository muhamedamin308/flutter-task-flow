class AppConstants {
  AppConstants._();

  // Firestore collection names
  static const String usersCollection = 'users';
  static const String tasksCollection = 'tasks';

  // Firestore field names (avoids magic strings scattered in the codebase)
  static const String fieldUid = 'uid';
  static const String fieldEmail = 'email';
  static const String fieldDisplayName = 'displayName';
  static const String fieldPhotoUrl = 'photoUrl';
  static const String fieldTitle = 'title';
  static const String fieldDescription = 'description';
  static const String fieldIsCompleted = 'isCompleted';
  static const String fieldCreatedAt = 'createdAt';

  // Firebase Storage paths
  static const String profilePicturesPath = 'profile_pictures';

  // UI
  static const double defaultPadding = 16.0;
  static const double cardBorderRadius = 12.0;
}
