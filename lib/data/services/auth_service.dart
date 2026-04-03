import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth;

  AuthService({FirebaseAuth? auth}) : _auth = auth ?? FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  User? get currentUser => _auth.currentUser;

  Future<User> signup({
    required String email,
    required String password,
    required String displayName,
  }) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );

    await credential.user!.updateDisplayName(displayName.trim());

    await credential.user!.reload();
    return _auth.currentUser!;
  }

  Future<User> signin({required String email, required String password}) async {
    final credentail = await _auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
    return credentail.user!;
  }

  Future<void> signout() => _auth.signOut();

  Future<void> sendPasswordResetEmail(String email) =>
      _auth.sendPasswordResetEmail(email: email.trim());

  static String mapAuthError(FirebaseAuthException exception) {
    switch (exception.code) {
      case 'user-not-found':
        return 'No account found with this email.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'email-already-in-use':
        return 'An account with this email already exists.';
      case 'weak-password':
        return 'Password is too weak. Use at least 6 characters.';
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'too-many-requests':
        return 'Too many attempts. Please wait and try again.';
      case 'network-request-failed':
        return 'Network error. Check your connection.';
      default:
        return exception.message ?? 'An unexpected error occurred.';
    }
  }
}
