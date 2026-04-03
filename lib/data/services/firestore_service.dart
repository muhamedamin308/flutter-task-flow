import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freecodecamp_flutter_course/core/constants/app_constants.dart';
import 'package:freecodecamp_flutter_course/data/models/task_model.dart';
import 'package:freecodecamp_flutter_course/data/models/user_model.dart';

class FirestoreService {
  final FirebaseFirestore _store;

  FirestoreService({FirebaseFirestore? store})
    : _store = store ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> _taskRef(String uid) => _store
      .collection(AppConstants.usersCollection)
      .doc(uid)
      .collection(AppConstants.tasksCollection);

  DocumentReference<Map<String, dynamic>> _userRef(String uid) =>
      _store.collection(AppConstants.usersCollection).doc(uid);

  // User Profile
  Future<void> createUserProfile(UserModel user) =>
      _userRef(user.uid).set(user.toFirestore(), SetOptions(merge: true));

  Future<UserModel?> getUserProfile(String uid) async {
    final snap = await _userRef(uid).get();
    if (!snap.exists) return null;
    return UserModel.fromFirestore(snap);
  }

  Future<void> updateUserPofile(String uid, Map<String, dynamic> data) =>
      _userRef(uid).update(data);

  // Tasks - real-time stream

  /// The core of the real-time feature.
  ///
  /// [snapshots()] opens a persistent WebSocket to Firestore. Every time a
  /// task document changes (create, update, delete) Firestore pushes the
  /// updated snapshot, and the Stream emits a new list. [StreamBuilder] in
  /// the UI reacts automatically — no manual refresh needed.
  ///
  /// Tasks are ordered newest-first via the [createdAt] timestamp.
  Stream<List<TaskModel>> taskStream(String uid) {
    return _taskRef(uid)
        .orderBy(AppConstants.fieldCreatedAt, descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => TaskModel.fromFirestore(doc)).toList(),
        );
  }

  // ─── Tasks – CRUD ─────────────────────────────────────────────────────────

  /// [add] lets Firestore auto-generate the document ID.
  /// [FieldValue.serverTimestamp()] ensures the timestamp is set by the server,
  /// avoiding issues with incorrect device clocks.
  Future<void> addTask(String uid, String title, String description) =>
      _taskRef(uid).add({
        AppConstants.fieldTitle: title.trim(),
        AppConstants.fieldDescription: description.trim(),
        AppConstants.fieldIsCompleted: false,
        AppConstants.fieldCreatedAt: FieldValue.serverTimestamp(),
      });

  Future<void> toggleTaskCompletion(
    String uid,
    String taskId,
    bool currentValue,
  ) => _taskRef(
    uid,
  ).doc(taskId).update({AppConstants.fieldIsCompleted: !currentValue});

  Future<void> deleteTask(String uid, String taskId) =>
      _taskRef(uid).doc(taskId).delete();

  Future<void> updateTask(
    String uid,
    String taskId, {
    required String title,
    required String description,
  }) => _taskRef(uid).doc(taskId).update({
    AppConstants.fieldTitle: title.trim(),
    AppConstants.fieldDescription: description.trim(),
  });
}
