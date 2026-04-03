import 'package:freecodecamp_flutter_course/core/utils/extenstions.dart';

class Validators {
  Validators._();

  static String? email(String? email) {
    if (email.isValidValue) {
      return 'Email is required';
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email!)) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  static String? password(String? password) {
    if (password.isValidValue) {
      return 'Password is required';
    }

    if (password!.length < 6) {
      return 'Password must be at least 6 characters long';
    }

    return null;
  }

  static String? confirmPassword(String? password, String? confirmPassword) {
    if (confirmPassword.isValidValue) {
      return 'Please confirm your password';
    }

    if (password != confirmPassword) {
      return 'Passwords do not match';
    }

    return null;
  }

  static String? taskTitle(String? title) {
    if (title.isValidValue) {
      return 'Task title is required';
    }

    if (title!.trim().length < 2 || title.trim().length > 100) {
      return 'Task title must be between 2 and 100 characters long';
    }

    return null;
  }

  static String? displayName(String? name) {
    if (name.isValidValue) {
      return 'Display name is required';
    }

    if (name!.trim().length < 2 || name.trim().length > 50) {
      return 'Display name must be between 2 and 50 characters long';
    }

    return null;
  }
}
