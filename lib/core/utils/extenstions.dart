extension StringExtensions on String? {
  bool get isValidValue {
    return this == null || this!.trim().isEmpty;
  }
}
