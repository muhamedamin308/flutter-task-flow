import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freecodecamp_flutter_course/core/constants/app_constants.dart';

class TaskModel {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;
  final DateTime createdAt;

  const TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.createdAt,
  });

  factory TaskModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;

    return TaskModel(
      id: doc.id,
      title: data[AppConstants.fieldTitle] as String? ?? '',
      description: data[AppConstants.fieldDescription] as String? ?? '',
      isCompleted: data[AppConstants.fieldIsCompleted] as bool? ?? false,
      createdAt:
          (data[AppConstants.fieldCreatedAt] as Timestamp?)?.toDate() ??
          DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() => {
    AppConstants.fieldTitle: title,
    AppConstants.fieldDescription: description,
    AppConstants.fieldIsCompleted: isCompleted,
    AppConstants.fieldCreatedAt: Timestamp.fromDate(createdAt),
  };

  TaskModel copyWith({String? title, String? description, bool? isCompleted}) {
    return TaskModel(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt,
    );
  }

  
}
