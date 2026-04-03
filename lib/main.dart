import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // Add this
import 'app.dart';
import 'firebase_options.dart';

void main() async {
  // 1. This ensures that the Flutter framework is ready before we start Firebase
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  await dotenv.load(fileName: ".env");

  // 2. This initializes Firebase using the "dictionary" file you generated
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const ProviderScope(child: TaskFlowApp()));
}
